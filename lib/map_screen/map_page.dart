import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/map_screen/map_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fleet_sync/apiKey.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final FocusNode fromFocusNode = FocusNode();
  final FocusNode toFocusNode = FocusNode();

  final GlobalKey<MapServiceState> mapServiceKey = GlobalKey<MapServiceState>();

  List<Map<String, dynamic>> fromSuggestions = [];
  List<Map<String, dynamic>> toSuggestions = [];
  bool showFromSuggestions = false;
  bool showToSuggestions = false;

  @override
  void initState() {
    super.initState();
    _setupSearchListeners();
  }

  void _setupSearchListeners() {
    fromController.addListener(() {
      if (fromController.text.isNotEmpty) {
        _searchPlaces(fromController.text, isFrom: true);
      } else {
        setState(() {
          showFromSuggestions = false;
          fromSuggestions.clear();
        });
      }
    });

    toController.addListener(() {
      if (toController.text.isNotEmpty) {
        _searchPlaces(toController.text, isFrom: false);
      } else {
        setState(() {
          showToSuggestions = false;
          toSuggestions.clear();
        });
      }
    });

    fromFocusNode.addListener(() {
      if (fromFocusNode.hasFocus && fromController.text.isNotEmpty) {
        setState(() {
          showFromSuggestions = true;
        });
      } else {
        setState(() {
          showFromSuggestions = false;
        });
      }
    });

    toFocusNode.addListener(() {
      if (toFocusNode.hasFocus && toController.text.isNotEmpty) {
        setState(() {
          showToSuggestions = true;
        });
      } else {
        setState(() {
          showToSuggestions = false;
        });
      }
    });
  }

  Future<void> _searchPlaces(String query, {required bool isFrom}) async {
    if (query.length < 2) return;

    try {
      // Get current location for nearby search
      final currentLocation = mapServiceKey.currentState?.currentPosition;

      List<Map<String, dynamic>> suggestions = await _getPlaceSuggestions(
        query,
        currentLocation: currentLocation,
      );

      setState(() {
        if (isFrom) {
          fromSuggestions = suggestions;
          showFromSuggestions = true;
        } else {
          toSuggestions = suggestions;
          showToSuggestions = true;
        }
      });
    } catch (e) {
      print('Error searching places: $e');
    }
  }

  Future<List<Map<String, dynamic>>> _getPlaceSuggestions(
    String query, {
    dynamic currentLocation,
  }) async {
    try {
      String url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
          'input=${Uri.encodeComponent(query)}&'
          'key=$GOOGLE_MAPS_api_Key&'
          'types=geocode&'
          'language=en&'
          'components=country:bd'; // Restrict to Bangladesh, change as needed

      // Add location bias if current location is available
      if (currentLocation != null) {
        url +=
            '&location=${currentLocation.latitude},${currentLocation.longitude}&'
            'radius=50000'; // 50km radius
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          List<Map<String, dynamic>> suggestions = [];

          for (var prediction in data['predictions']) {
            // Get place details for coordinates
            final placeDetails = await _getPlaceDetails(prediction['place_id']);

            if (placeDetails != null) {
              suggestions.add({
                'name': prediction['description'],
                'latitude': placeDetails['latitude'],
                'longitude': placeDetails['longitude'],
                'place_id': prediction['place_id'],
                'main_text': prediction['structured_formatting']['main_text'],
                'secondary_text':
                    prediction['structured_formatting']['secondary_text'] ?? '',
              });
            }

            if (suggestions.length >= 5) break;
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
          'key=$GOOGLE_MAPS_api_Key',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final location = data['result']['geometry']['location'];
          return {'latitude': location['lat'], 'longitude': location['lng']};
        }
      }
    } catch (e) {
      print('Error getting place details: $e');
    }

    return null;
  }

  String _formatPlaceName(geocoding.Placemark place) {
    List<String> parts = [];

    if (place.name != null && place.name!.isNotEmpty) {
      parts.add(place.name!);
    }
    if (place.street != null &&
        place.street!.isNotEmpty &&
        place.street != place.name) {
      parts.add(place.street!);
    }
    if (place.locality != null && place.locality!.isNotEmpty) {
      parts.add(place.locality!);
    }
    if (place.administrativeArea != null &&
        place.administrativeArea!.isNotEmpty) {
      parts.add(place.administrativeArea!);
    }

    return parts.join(', ');
  }

  void _onSuggestionSelected(
    Map<String, dynamic> suggestion, {
    required bool isFrom,
  }) {
    setState(() {
      if (isFrom) {
        fromController.text = suggestion['name'];
        showFromSuggestions = false;
        fromFocusNode.unfocus();
      } else {
        toController.text = suggestion['name'];
        showToSuggestions = false;
        toFocusNode.unfocus();

        // Navigate to destination
        mapServiceKey.currentState?.searchDestination(suggestion['name']);
      }
    });
  }

  void _onCurrentLocationPressed() {
    mapServiceKey.currentState?.setCurrentLocationAsFrom((address) {
      setState(() {
        fromController.text = address;
      });
    });
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    fromFocusNode.dispose();
    toFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _searchSection(),
                _buttonSection(),
                Expanded(
                  child: MapService(
                    key: mapServiceKey,
                    getFromController: () => fromController,
                    getToController: () => toController,
                  ),
                ),
              ],
            ),
            if (showFromSuggestions || showToSuggestions)
              _buildSuggestionOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _searchSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              child: TextField(
                controller: fromController,
                focusNode: fromFocusNode,
                decoration: InputDecoration(
                  hintText: 'From (Current Location)',
                  prefixIcon: Icon(
                    Icons.my_location,
                    color: ConstColours.colorGreen,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.gps_fixed, color: ConstColours.colorGreen),
                    onPressed: _onCurrentLocationPressed,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: ConstColours.colorGreen),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: ConstColours.colorGreen,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 50,
              child: TextField(
                controller: toController,
                focusNode: toFocusNode,
                decoration: InputDecoration(
                  hintText: 'Where to?',
                  prefixIcon: Icon(Icons.location_on, color: Colors.red),
                  suffixIcon:
                      toController.text.isNotEmpty
                          ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              toController.clear();
                              mapServiceKey.currentState?.clearDestination();
                            },
                          )
                          : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: ConstColours.colorGreen,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          customElevatedButton(
            top: 0,
            title: ConstStrings.destination,
            onPressed: () {
              if (toController.text.isNotEmpty) {
                mapServiceKey.currentState?.searchDestination(
                  toController.text,
                );
              }
            },
            height: 32,
            width: 118,
          ),
          Spacer(),
          SvgPicture.asset('assets/icons/location_pin_button_icon.svg'),
          SizedBox(width: 8),
          SvgPicture.asset('assets/icons/service_man_button_icon.svg'),
        ],
      ),
    );
  }

  Widget _buildSuggestionOverlay() {
    return Positioned(
      top: 70, // Adjust based on search section height
      left: 20,
      right: 20,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          constraints: BoxConstraints(maxHeight: 300),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showFromSuggestions) ...[
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.my_location,
                          color: ConstColours.colorGreen,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'From Suggestions',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...fromSuggestions.map(
                    (suggestion) =>
                        _buildSuggestionItem(suggestion, isFrom: true),
                  ),
                ],
                if (showToSuggestions) ...[
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.red, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'Destination Suggestions',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...toSuggestions.map(
                    (suggestion) =>
                        _buildSuggestionItem(suggestion, isFrom: false),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionItem(
    Map<String, dynamic> suggestion, {
    required bool isFrom,
  }) {
    return InkWell(
      onTap: () => _onSuggestionSelected(suggestion, isFrom: isFrom),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color:
                    isFrom
                        ? ConstColours.colorGreen
                        : Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                isFrom ? Icons.my_location : Icons.location_on,
                color: isFrom ? ConstColours.colorGreen : Colors.red,
                size: 16,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    suggestion['main_text'] ?? suggestion['name'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (suggestion['secondary_text'] != null &&
                      suggestion['secondary_text'].isNotEmpty) ...[
                    SizedBox(height: 3),
                    Text(
                      suggestion['secondary_text'],
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            Icon(Icons.north_west, color: Colors.grey.shade400, size: 16),
          ],
        ),
      ),
    );
  }

  void openEndDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }
}
