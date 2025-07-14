import 'dart:async';

import 'package:fleet_sync/apiKey.dart';
import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_search_bar.dart';
import 'package:fleet_sync/drawer_screen/drawer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static const double drawerWidth = 290.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      endDrawer: SizedBox(width: drawerWidth, child: DrawerPage()),
      body: SafeArea(
        child: Column(
          children: [
            // _appbar(),
            _search(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  customElevatedButton(
                    top: 0,
                    title: ConstStrings.destination,
                    onPressed: () {},
                    height: 32,
                    width: 118,
                  ),
                  Spacer(),
                  SvgPicture.asset('assets/icons/location_pin_button_icon.svg'),
                  SizedBox(width: 8),
                  SvgPicture.asset('assets/icons/service_man_button_icon.svg'),
                ],
              ),
            ),
            Expanded(child: MapService()),
          ],
        ),
      ),
    );
  }

  Widget _search() {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
      child: SizedBox(
        height: 55,
        child: Row(
          children: [
            CustomSearchBar(
              hintText: ConstStrings.searchHere,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  'assets/icons/search.svg',
                  colorFilter: ColorFilter.mode(
                    ConstColours.colorGreen,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openEndDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }
}

class MapService extends StatefulWidget {
  const MapService({super.key});

  static const radisson = LatLng(23.815677, 90.408378);
  static const mohammadpur = LatLng(23.772276, 90.361320);

  static const radissonPoint = PointLatLng(23.815677, 90.408378);
  static const mohammadpurPoint = PointLatLng(23.772276, 90.361320);

  @override
  State<MapService> createState() => _MapServiceState();
}

class _MapServiceState extends State<MapService> {
  LatLng? _currentP;
  Map<PolylineId, Polyline> polyLines = {};

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    getLocationUpdate().then((_) => getPolylinepoints().then((coordinate)=>generatePolyLine(coordinate)));
  }

  @override
  void dispose() {
    getLocationUpdate();
    _mapController;
    _currentP;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentP == null) {
      return Text('Loading... ');
    } else {
      return GoogleMap(
        onMapCreated:
            (GoogleMapController controller) =>
                _mapController.complete(controller),
        initialCameraPosition: CameraPosition(
          target: MapService.radisson,
          zoom: 14.4746,
        ),
        markers: {
          Marker(
            markerId: MarkerId('currentLocation'),
            icon: BitmapDescriptor.defaultMarker,
            position: _currentP!,
          ),
          Marker(
            markerId: MarkerId('value'),
            icon: BitmapDescriptor.defaultMarker,
            position: MapService.radisson,
          ),
          Marker(
            markerId: MarkerId('value'),
            icon: BitmapDescriptor.defaultMarker,
            position: MapService.mohammadpur,
          ),
          //    Marker(
          //   markerId: MarkerId('value'),
          //   icon: BitmapDescriptor.defaultMarker,
          //   position: _currentP!,
          // ),
        },
        polylines: Set<Polyline>.of(polyLines.values),
      );
    }
  }

  Future<void> cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 14.4746,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdate() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    // LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) async {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        // locationData = await location.getLocation();
        // _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        _currentP = LatLng(
          currentLocation.latitude!,
          currentLocation.longitude!,
        );
        // cameraToPosition(_currentP!);
        print(
          '*********************************************************************************************************************************************$_currentP',
        );
        setState(() {});
      }
    });
  }

  Future<List<LatLng>> getPolylinepoints() async {
    List<LatLng> polyLineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineRequest request = PolylineRequest(
      origin: MapService.radissonPoint,
      destination: MapService.mohammadpurPoint,
      mode: TravelMode.driving,
    );
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: request,
      googleApiKey: GOOGLE_MAPS_api_Key,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polyLineCoordinates;
  }

  void generatePolyLine(List<LatLng> polyLineCoordinates) async {
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
}
