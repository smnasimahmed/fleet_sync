import 'dart:async';
import 'dart:math';

import 'package:fleet_sync/apiKey.dart';
import 'package:fleet_sync/const/const_colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapService extends StatefulWidget {
  final TextEditingController Function()? getFromController;
  final TextEditingController Function()? getToController;
  
  const MapService({
    super.key,
    this.getFromController,
    this.getToController,
  });

  @override
  State<MapService> createState() => MapServiceState();
}

class MapServiceState extends State<MapService> {
  LatLng? _currentP; // Current driver position
  LatLng? _selectedDestination; // Destination chosen by user tap
  LatLng? _lastPolylineFetchPosition; // Last position when polyline was fetched
  String _currentAddress = ''; // Current address as string

  Map<PolylineId, Polyline> polyLines = {}; // Polyline storage
  Set<Marker> _markers = {}; // All markers including current location

  get currentPosition => _currentP;
  get currentAddress => _currentAddress;

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  late final StreamSubscription<LocationData> _locationSubscription;

  // List of static hot places
  final List<Map<String, dynamic>> hotPlaces = [
    {
      'name': 'Food Point 1',
      'position': LatLng(23.8103, 90.4125),
      'icon': BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      'type': 'food',
    },
    {
      'name': 'Food Point 2',
      'position': LatLng(23.8103, 90.4565),
      'icon': BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      'type': 'food',
    },
    {
      'name': 'Food Point 3',
      'position': LatLng(23.8103, 90.5158),
      'icon': BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      'type': 'food',
    },
    {
      'name': 'Mechanic 1',
      'position': LatLng(23.8156, 90.4255),
      'icon': BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      'type': 'mechanic',
    },
    {
      'name': 'Mechanic 2',
      'position': LatLng(23.8156, 90.4655),
      'icon': BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      'type': 'mechanic',
    },
    {
      'name': 'Mechanic 3',
      'position': LatLng(23.8156, 90.4955),
      'icon': BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      'type': 'mechanic',
    },
  ];

  @override
  void initState() {
    super.initState();
    getLocationUpdate();
    _setupHotPlaceMarkers();
  }

  void _setupHotPlaceMarkers() {
    _markers = hotPlaces.map((place) => Marker(
      markerId: MarkerId(place['name']),
      icon: place['icon'],
      position: place['position'],
      infoWindow: InfoWindow(
        title: place['name'],
        snippet: 'Tap to navigate',
      ),
      onTap: () {
        if (_selectedDestination == place['position']) {
          clearDestination();
        } else {
          _selectDestination(place['position']);
        }
      },
    )).toSet();
  }

  void _selectDestination(LatLng destination) {
    setState(() {
      _selectedDestination = destination;
    });
    _updateDestinationMarker();
    getPolylinepoints();
  }

  void _updateDestinationMarker() {
    if (_selectedDestination != null) {
      _markers.add(Marker(
        markerId: MarkerId('destination'),
        position: _selectedDestination!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: 'Destination',
          snippet: 'Your selected destination',
        ),
      ));
    } else {
      _markers.removeWhere((marker) => marker.markerId.value == 'destination');
    }
  }

  void clearDestination() {
    setState(() {
      _selectedDestination = null;
      polyLines.clear();
      _markers.removeWhere((marker) => marker.markerId.value == 'destination');
    });
    _setupHotPlaceMarkers();
  }

  void setCurrentLocationAsFrom(Function(String) onAddressReceived) {
    if (_currentP != null) {
      updateFromAddress(_currentP!, onAddressReceived);
    }
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentP == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: ConstColours.colorGreen),
            SizedBox(height: 16),
            Text(
              'Getting your location...',
              style: TextStyle(
                fontSize: 16,
                color: ConstColours.colorGreen,
              ),
            ),
          ],
        ),
      );
    }

    return GoogleMap(
      onMapCreated: (controller) => _mapController.complete(controller),
      initialCameraPosition: CameraPosition(target: _currentP!, zoom: 14.5),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      compassEnabled: true,
      mapToolbarEnabled: true,
      zoomControlsEnabled: false,
      markers: _markers,
      polylines: Set<Polyline>.of(polyLines.values),
      onTap: (LatLng position) {
        // Optional: Allow users to tap on map to set destination
        // _selectDestination(position);
      },
    );
  }

  Future<void> cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: pos, zoom: 16.0),
      ),
    );
  }

  Future<void> getLocationUpdate() async {
    Location location = Location();

    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) return;
    }

    if (await location.hasPermission() == PermissionStatus.denied) {
      if (await location.requestPermission() != PermissionStatus.granted) return;
    }

    _locationSubscription = location.onLocationChanged.listen((currentLocation) async {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        LatLng newPos = LatLng(
          currentLocation.latitude!,
          currentLocation.longitude!,
        );
        
        bool isFirstLocation = _currentP == null;
        _currentP = newPos;
        
        if (mounted) {
          setState(() {});
          
          // Update current address
          await updateFromAddress(newPos);
          
          // If first location, center camera
          if (isFirstLocation) {
            await cameraToPosition(newPos);
          }
        }

        // If a destination is set, check for significant movement before refetching polyline
        if (_selectedDestination != null) {
          if (_lastPolylineFetchPosition == null ||
              calculateDistance(_lastPolylineFetchPosition!, newPos) > 50) {
            await getPolylinepoints();
            _lastPolylineFetchPosition = newPos;
          }
        }
      }
    });
  }

  Future<void> updateFromAddress(LatLng pos, [Function(String)? onAddressReceived]) async {
    try {
      List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );
      
      if (placemarks.isNotEmpty) {
        geocoding.Placemark place = placemarks[0];
        String address = _formatAddress(place);
        
        if (mounted) {
          setState(() {
            _currentAddress = address;
          });
          
          if (onAddressReceived != null) {
            onAddressReceived(address);
          }
        }
      }
    } catch (e) {
      print('Error getting address: $e');
    }
  }

  String _formatAddress(geocoding.Placemark place) {
    List<String> addressParts = [];
    
    if (place.street != null && place.street!.isNotEmpty) {
      addressParts.add(place.street!);
    }
    if (place.locality != null && place.locality!.isNotEmpty) {
      addressParts.add(place.locality!);
    }
    if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
      addressParts.add(place.administrativeArea!);
    }
    
    return addressParts.join(', ');
  }

  Future<void> searchDestination(String address) async {
    if (address.isEmpty) return;

    try {
      // First try Google Places API for better results
      final suggestions = await _getPlaceSuggestions(address);
      
      if (suggestions.isNotEmpty) {
        LatLng destination = LatLng(
          suggestions[0]['latitude'],
          suggestions[0]['longitude'],
        );
        
        _selectDestination(destination);
        await cameraToPosition(destination);
      } else {
        // Fallback to geocoding
        List<geocoding.Location> locations = await geocoding.locationFromAddress(address);
        
        if (locations.isNotEmpty) {
          LatLng destination = LatLng(
            locations[0].latitude,
            locations[0].longitude,
          );
          
          _selectDestination(destination);
          await cameraToPosition(destination);
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Address not found'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error searching address: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<List<Map<String, dynamic>>> _getPlaceSuggestions(String query) async {
    try {
      String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
          'input=${Uri.encodeComponent(query)}&'
          'key=$GOOGLE_MAPS_api_Key&'
          'types=geocode&'
          'language=en&'
          'components=country:bd';

      if (_currentP != null) {
        url += '&location=${_currentP!.latitude},${_currentP!.longitude}&'
               'radius=50000';
      }

      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['status'] == 'OK') {
          List<Map<String, dynamic>> suggestions = [];
          
          for (var prediction in data['predictions']) {
            final placeDetails = await _getPlaceDetails(prediction['place_id']);
            
            if (placeDetails != null) {
              suggestions.add({
                'name': prediction['description'],
                'latitude': placeDetails['latitude'],
                'longitude': placeDetails['longitude'],
                'place_id': prediction['place_id'],
              });
            }
            
            if (suggestions.length >= 1) break; // Only need first one for search
          }
          
          return suggestions;
        }
      }
    } catch (e) {
      print('Error getting place suggestions: $e');
    }
    
    return [];
  }

  Future<Map<String, dynamic>?> _getPlaceDetails(String placeId) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/place/details/json?'
          'place_id=$placeId&'
          'fields=geometry&'
          'key=$GOOGLE_MAPS_api_Key'
        ),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['status'] == 'OK') {
          final location = data['result']['geometry']['location'];
          return {
            'latitude': location['lat'],
            'longitude': location['lng'],
          };
        }
      }
    } catch (e) {
      print('Error getting place details: $e');
    }
    
    return null;
  }

  Future<void> getPolylinepoints() async {
    if (_currentP == null || _selectedDestination == null) return;

    try {
      List<LatLng> polyLineCoordinates = [];
      PolylinePoints polylinePoints = PolylinePoints();

      PolylineRequest request = PolylineRequest(
        origin: PointLatLng(_currentP!.latitude, _currentP!.longitude),
        destination: PointLatLng(
          _selectedDestination!.latitude,
          _selectedDestination!.longitude,
        ),
        mode: TravelMode.driving,
      );

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        request: request,
        googleApiKey: GOOGLE_MAPS_api_Key,
      );

      if (result.points.isNotEmpty) {
        for (PointLatLng point in result.points) {
          polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
        generatePolyLine(polyLineCoordinates);
      } else {
        print('Polyline fetch error: ${result.errorMessage}');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Unable to find route'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      print('Error getting polyline: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error getting directions'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void generatePolyLine(List<LatLng> polyLineCoordinates) {
    if (mounted) {
      PolylineId id = PolylineId('route');
      Polyline polyline = Polyline(
        polylineId: id,
        color: ConstColours.colorGreen,
        points: polyLineCoordinates,
        width: 5,
        patterns: [],
      );
      
      setState(() {
        polyLines[id] = polyline;
      });
    }
  }

  double calculateDistance(LatLng p1, LatLng p2) {
    const double earthRadius = 6371000; // in meters
    double dLat = (p2.latitude - p1.latitude) * (pi / 180);
    double dLng = (p2.longitude - p1.longitude) * (pi / 180);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(p1.latitude * (pi / 180)) *
            cos(p2.latitude * (pi / 180)) *
            sin(dLng / 2) *
            sin(dLng / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  // Public methods for external control
  void focusOnCurrentLocation() {
    if (_currentP != null) {
      cameraToPosition(_currentP!);
    }
  }

  void focusOnDestination() {
    if (_selectedDestination != null) {
      cameraToPosition(_selectedDestination!);
    }
  }

  void fitMarkersInView() async {
    if (_currentP != null && _selectedDestination != null) {
      final GoogleMapController controller = await _mapController.future;
      
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          min(_currentP!.latitude, _selectedDestination!.latitude),
          min(_currentP!.longitude, _selectedDestination!.longitude),
        ),
        northeast: LatLng(
          max(_currentP!.latitude, _selectedDestination!.latitude),
          max(_currentP!.longitude, _selectedDestination!.longitude),
        ),
      );
      
      await controller.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 100.0),
      );
    }
  }
}