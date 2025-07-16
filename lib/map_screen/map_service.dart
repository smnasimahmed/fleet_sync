import 'dart:async';
import 'dart:math';

import 'package:fleet_sync/apiKey.dart';
import 'package:fleet_sync/const/const_colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geocoding/geocoding.dart' hide Location;
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapService extends StatefulWidget {
  final Function(String)? onCurrentAddress;
  final TextEditingController Function()? getTocontroller;
  const MapService({super.key, this.onCurrentAddress, this.getTocontroller});

  @override
  State<MapService> createState() => _MapServiceState();
}

class _MapServiceState extends State<MapService> {
  LatLng? _currentP; // Current driver position
  LatLng? _selectedDestination; // Destination chosen by user tap
  LatLng? _lastPolylineFetchPosition; // Last position when polyline was fetched

  Map<PolylineId, Polyline> polyLines = {}; // Polyline storage

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  late final StreamSubscription<LocationData>
  _locationSubscription; // For proper cleanup

  // List of static hot places
  final List<Map<String, dynamic>> hotPlaces = [
    {
      'name': 'Food Point 1',
      'position': LatLng(23.8103, 90.4125),
      'icon': BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    },
    {
      'name': 'Food Point 2',
      'position': LatLng(23.8103, 90.4565),
      'icon': BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    },
    {
      'name': 'Food Point 3',
      'position': LatLng(23.8103, 90.5158),
      'icon': BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    },
    {
      'name': 'Mechanic 1',
      'position': LatLng(23.8156, 90.4255),
      'icon': BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    },
    {
      'name': 'Mechanic 2',
      'position': LatLng(23.8156, 90.4655),
      'icon': BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    },
    {
      'name': 'Mechanic 3',
      'position': LatLng(23.8156, 90.4955),
      'icon': BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    },
  ];

  @override
  void initState() {
    super.initState();
    getLocationUpdate(); // Start location tracking immediately
  }

  @override
  void dispose() {
    _locationSubscription.cancel(); // Clean up to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentP == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return GoogleMap(
        onMapCreated: (controller) => _mapController.complete(controller),
        initialCameraPosition: CameraPosition(target: _currentP!, zoom: 14.5),
        myLocationEnabled: true,
        markers: {
          ...hotPlaces.map(
            (place) => Marker(
              markerId: MarkerId(place['name']),
              icon: place['icon'],
              position: place['position'],
              infoWindow: InfoWindow(title: place['name']),
              onTap: () {
                if (_selectedDestination == place['position']) {
                  // If already selected, unselect
                  _selectedDestination = null;
                  polyLines.clear(); // remove polyline
                } else {
                  _selectedDestination =
                      place['position']; // Set new destination
                  getPolylinepoints(); // Fetch polyline
                }
              },
            ),
          ),
        },
        polylines: Set<Polyline>.of(polyLines.values),
      );
    }
  }

  Future<void> cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    await controller.animateCamera(CameraUpdate.newLatLng(pos));
  }

  Future<void> getLocationUpdate() async {
    Location location = Location();

    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) return;
    }

    if (await location.hasPermission() == PermissionStatus.denied) {
      if (await location.requestPermission() != PermissionStatus.granted)
        return;
    }

    _locationSubscription = location.onLocationChanged.listen((
      currentLocation,
    ) async {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        LatLng newPos = LatLng(
          currentLocation.latitude!,
          currentLocation.longitude!,
        );
        _currentP = newPos;
        setState(() {});

        // cameraToPosition(newPos); // Optional: camera follows driver

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
    // TODO: Right here need to call updateFromAddress
    // if (_currentP != null) {
    //   await updateFromAddress(_currentP!);
    // }
  }

  // Future<void> updateFromAddress(LatLng pos) async {
  //   List<geocoding.Placemark> placemarks = await geocoding
  //       .placemarkFromCoordinates(pos.latitude, pos.longitude);
  //   if (placemarks.isNotEmpty && widget.onCurrentAddress != null) {
  //     widget.onCurrentAddress!(
  //       '${placemarks[0].street}, ${placemarks[0].locality}',
  //     );
  //   }
  // }

  // Future<void> searchDestination(String address) async {
  //   if (address.isEmpty) return;
  //   List<geocoding.Location> locations = await geocoding.locationFromAddress(
  //     address,
  //   );
  //   if (locations.isNotEmpty) {
  //     _selectedDestination = LatLng(
  //       locations[0].latitude,
  //       locations[0].longitude,
  //     );
  //     getPolylinepoints();
  //   }
  // }

  Future<void> getPolylinepoints() async {
    if (_currentP == null || _selectedDestination == null) return;

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
    }
  }

  void generatePolyLine(List<LatLng> polyLineCoordinates) {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: ConstColours.colorGreen,
      points: polyLineCoordinates,
      width: 8,
    );
    setState(() {
      polyLines[id] = polyline;
    });
  }

  double calculateDistance(LatLng p1, LatLng p2) {
    const double earthRadius = 6371000; // in meters
    double dLat = (p2.latitude - p1.latitude) * (pi / 180);
    double dLng = (p2.longitude - p1.longitude) * (pi / 180);

    double a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(p1.latitude * (pi / 180)) *
            cos(p2.latitude * (pi / 180)) *
            sin(dLng / 2) *
            sin(dLng / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }
}

// import 'dart:async';

// import 'package:fleet_sync/apiKey.dart';
// import 'package:fleet_sync/const/const_colours.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class MapService extends StatefulWidget {
//   const MapService({super.key});

//   static const radisson = LatLng(23.815677, 90.408378);
//   static const mohammadpur = LatLng(23.772276, 90.361320);

//   static const radissonPoint = PointLatLng(23.815677, 90.408378);
//   static const mohammadpurPoint = PointLatLng(23.772276, 90.361320);

//   @override
//   State<MapService> createState() => _MapServiceState();
// }

// class _MapServiceState extends State<MapService> {
//   LatLng? _currentPosition;
//   LatLng? _selectedDistance;
//   LatLng? _lastPolylineFetchPosition;
//   bool _isFetchingPolyline = false;

//   final List<Map<String, dynamic>> hotPlaces = [
//     {
//       'name': 'Food Point 1',
//       'position': LatLng(23.8103, 90.4125),
//       'icon': BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//     },
//     {
//       'name': 'Mechanic 1',
//       'position': LatLng(23.8156, 90.4255),
//       'icon': BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
//     },
//     // Add as needed
//   ];

//   Map<PolylineId, Polyline> polyLines = {};

//   final Completer<GoogleMapController> _mapController =
//       Completer<GoogleMapController>();

//   @override
//   void initState() {
//     super.initState();
//     getLocationUpdate();

//     // .then(
//     //   (_) => getPolylinepoints()

//     // .then(
//     //   (coordinate) => generatePolyLine(coordinate),
//     // ),
//     // );
//   }

//   @override
//   void dispose() {
//     getLocationUpdate();
//     _mapController;
//     // _currentP;
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_currentPosition == null) {
//       return Text('Loading... ');
//     } else {
//       return GoogleMap(
//         onMapCreated:
//             (GoogleMapController controller) =>
//                 _mapController.complete(controller),
//         initialCameraPosition: CameraPosition(
//           target: _currentPosition!,
//           zoom: 14.4746,
//         ),
//         markers: {
//           Marker(
//             markerId: MarkerId('currentLocation'),
//             icon: BitmapDescriptor.defaultMarkerWithHue(
//               BitmapDescriptor.hueBlue,
//             ),
//             position: _currentPosition!,
//           ),
//           Marker(
//             markerId: MarkerId('value'),
//             icon: BitmapDescriptor.defaultMarker,
//             position: MapService.mohammadpur,
//           ),
//         },
//         polylines: Set<Polyline>.of(polyLines.values),
//       );
//     }
//   }

//   Future<void> cameraToPosition(LatLng pos) async {
//     final GoogleMapController controller = await _mapController.future;
//     CameraPosition _newCameraPosition = CameraPosition(
//       target: pos,
//       zoom: 14.4746,
//     );
//     await controller.animateCamera(
//       CameraUpdate.newCameraPosition(_newCameraPosition),
//     );
//   }

//   Future<void> getLocationUpdate() async {
//     Location location = Location();

//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }

//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     location.onLocationChanged.listen((LocationData currentLocation) async {
//       if (currentLocation.latitude != null &&
//           currentLocation.longitude != null) {
//         _currentPosition = LatLng(
//           currentLocation.latitude!,
//           currentLocation.longitude!,
//         );
//         // cameraToPosition(_currentP!);
//         print(
//           '*********************************************************************************************************************************************$_currentPosition',
//         );
//         setState(() {});
//       }
//       getPolylinepoints();
//     });
//   }

//   Future<void> getPolylinepoints() async {
//     List<LatLng> polyLineCoordinates = [];
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineRequest request = PolylineRequest(
//       origin: PointLatLng(
//         _currentPosition!.latitude,
//         _currentPosition!.longitude,
//       ), //MapService.radissonPoint,
//       destination: MapService.mohammadpurPoint,
//       mode: TravelMode.driving,
//     );
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       request: request,
//       googleApiKey: GOOGLE_MAPS_api_Key,
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
//         print(polyLineCoordinates);
//       });
//     } else {
//       print(result.errorMessage);
//     }
//     // return polyLineCoordinates;
//     generatePolyLine(polyLineCoordinates);
//   }

//   void generatePolyLine(List<LatLng> polyLineCoordinates) async {
//     PolylineId id = PolylineId('poly');
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: ConstColours.colorGreen,
//       points: polyLineCoordinates,
//       width: 8,
//     );
//     setState(() {
//       polyLines[id] = polyline;
//     });
//   }
// }
