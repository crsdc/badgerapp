import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/dragmarker.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:location/location.dart';
import 'package:what3words/what3words.dart' as w3w;
import '../exports_config.dart';
import '../logic/map_manager.dart';
//import '../main.dart';

class EmbedMap2 extends StatefulWidget {

  final MapManager mapManager;
  final LatLng startingCentre;
  final double startingZoom;

  const EmbedMap2({
    Key? key,
    required this.mapManager,
    required this.startingCentre,
    required this.startingZoom,
  }) : super(key: key);

  @override
  EmbedMap2State createState() => EmbedMap2State();
}

class EmbedMap2State extends State<EmbedMap2> {

  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        center: widget.startingCentre,
        zoom: widget.startingZoom,
        maxZoom: 18.0,
        minZoom: 5.0,
        swPanBoundary: LatLng(49.84, -6.47),
        nePanBoundary: LatLng(55.93, 2.05),

        // Stops map rotating: enable all interactions except rotation
        // Also means layers can be used instead of nonRotatedLayers (may be obsolete)
        // Weird syntax
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,

        // Needed for the drag plugin
        absorbPanEventsOnScrollables: false,

        // May be needed to stop map reset when it's in a scrollable screen
        //keepAlive: true,

        onTap: (tapPosition, tapLocation) async {
          // Take focus away from text field to hide keyboard if it's showing
          FocusScope.of(context).requestFocus(FocusNode());

          // Check whether pin already exists i.e. isn't at 0,0
          if (widget.mapManager.pinLocation == LatLng(0.0, 0.0)) {
            // CALL A METHOD IN THE MAP MANAGER
          } else {
            //widget.popupLayerController.hideAllPopups();
          }
        },

        onPositionChanged: (MapPosition position, bool hasGesture) {
          // If map moves because of a gesture, take focus to hide keyboard
          if (hasGesture) {
            FocusScope.of(context).requestFocus(FocusNode());
            // Then if we are continuously centering, stop doing that
            /*if(widget.centerOnLocationUpdate != CenterOnLocationUpdate.never) {
              print('Gesture detected so stop center on location update');
              setState(() => widget.centerOnLocationUpdate = CenterOnLocationUpdate.never);
            }*/
          }
        },

      ),
      children: <Widget>[

        TileLayer(
          urlTemplate: mapTemplateUrl + mapKeyApi,
          subdomains: const ['a', 'b', 'c'],
          tileProvider: FlutterMapTileCaching.instance('TF-OSM-landscape').getTileProvider(),
          backgroundColor: Colors.white,
          //errorImage: maybe implement in the future, for now coloured background
          //userAgentPackageName: , not clear that it's needed for TF
          /* code from caching plugin example
          tileProvider: FlutterMapTileCaching.instance('TF-OSM-landscape').getTileProvider(
            FMTCTileProviderSettings(
              behavior: CacheBehavior.values
                  .byName(metadata.data!['behaviour']!),
              cachedValidDuration: int.parse(
                metadata.data!['validDuration']!,
              ) ==
                  0
                  ? Duration.zero
                  : Duration(
                days: int.parse(
                  metadata.data!['validDuration']!,
                ),
              ),
            ),
          ),*/
        ),
        CurrentLocationLayer(
          style: LocationMarkerStyle(
            marker: const DefaultLocationMarker(
              // TODO make it fuzzy or something
            ),
            markerSize: const Size(20, 20),
            accuracyCircleColor: Colors.blue.withOpacity(0.5),
            // Heading often misleading especially when stationary
            showHeadingSector: false,
          ),
          //centerOnLocationUpdate: widget.centerOnLocationUpdate,
          //centerCurrentLocationStream: widget.centerCurrentLocationStreamController.stream,
          turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
        ),

        /*PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
              popupController: widget.popupLayerController,
              markers: locsMarkerList,
              markerRotateAlignment: PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
              markerTapBehavior: MarkerTapBehavior.custom((marker, popupState, popupController) async {
                print('TAPPED a pin from MY LOCATIONS!');

                var w3Words = await widget.w3wAPI.convertTo3wa(
                    w3w.Coordinates(marker.point.latitude, marker.point.longitude))
                    .language('en')
                    .execute();
                print('w3w: ${w3Words.data()!.toJson()['words']}');

                setState(() {
                  print('Pin my locations selection setState');
                  print(widget.model.pinGridRef);

                  // Set the form data and the on-screen text field
                  widget.model.pinGridRef = latLongToOSNumeric(marker.point.latitude, marker.point.longitude);
                  widget.pinGridRefController.text = widget.model.pinGridRef;
                  print(widget.pinGridRefController.text);
                  print(widget.pinList.length); // TODO where is this used?

                  // Set the pin on the map
                  widget.pinLocation = LatLng(marker.point.latitude, marker.point.longitude);
                  widget.tappedPoints.clear();
                  widget.tappedPoints.add(LatLng(marker.point.latitude, marker.point.longitude));
                  print('Create pin at ${widget.pinLocation}');

                  // W3W setting
                  widget.w3wController.text = w3Words.data()!.toJson()['words'];

                  // Callback to make map update
                  widget.callback(widget.pinList, widget.pinLocation, widget.pinGridRefController.text, widget.w3wController.text);
                });


                if (popupState.selectedMarkers.contains(marker)) {
                  popupController.hideAllPopups();
                } else {
                  popupController.showPopupsOnlyFor([marker]);
                }
              }),
              popupSnap: PopupSnap.markerTop,
              popupBuilder: (BuildContext context, Marker marker) {
                if (marker is LocMarker) {
                  return LocPopup(marker);
                } else {
                  return const Card(child: Text('ERROR: Not a locmarker'));
                }
              }
          ),
        ),*/

        ValueListenableBuilder<LatLng>(
          valueListenable: widget.mapManager.notifierPinLocation,
          builder: (context, notifiedPinLocation, child) {
            print('will return dragmarker, $notifiedPinLocation');
            return DragMarkers(
              markers: [
                DragMarker(
                  point: notifiedPinLocation,
                  width: 80.0,
                  height: 80.0,
                  builder: (ctx) => const Icon(
                    MdiIcons.mapMarker,
                    color: crimeRed,
                    size: 50.0, // TODO spin off this and any other hardcoded sizes gh#81
                  ),
                  // Worked out by trial and error; 15 would be middle but icon doesn't fill its 50 box
                  anchorPos: AnchorPos.exactly(Anchor(40.0, 20.0)),
                  updateMapNearEdge: true,

                  onDragEnd: (details, point) async {
                    // TODO spin off logic to map manager
                    /*print('Finished drag at ${point.latitude}, ${point.longitude}');

                  // Attempt w3w conversion
                  var w3Words = await w3wAPI.convertTo3wa(
                      w3w.Coordinates(point.latitude, point.longitude))
                      .language('en')
                      .execute();
                  print('w3w: ${w3Words.data()!.toJson()['words']}');

                  // W3W setting
                  _w3wController.text = w3Words.data()!.toJson()['words'];
                  w3wDisplay = _w3wController.text;

                  // Set the pin on the map
                  pinLocation = LatLng(point.latitude, point.longitude);

                  // Set the form data and the on-screen text field
                  model.pinGridRef = latLongToOSNumeric(pinLocation.latitude, pinLocation.longitude);
                  _pinGridRefController.text = model.pinGridRef;

                  setState(() {
                    print('Pin placement dragged and dropped setState');
                    //print(model.pinGridRef);
                  });*/
                  }
                ),
              ],
            );
          },
        ),

        /*Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            backgroundColor: crimeRed,
            splashColor: yellowHighlight,
            // TODO more splash colours gh#80
            elevation: 10.0,
            onPressed: () {
              print('Locate Me button pressed');
              print('userLocation from inside FAB is $globUserLocation');

              // Take focus away from text fields to hide keyboard if it's showing
              FocusScope.of(context).requestFocus(FocusNode());

              //got to call locate me somehow
              locateMe(widget.locationObject);
              //widget.callback(widget.pinList, widget.pinLocation, widget.pinGridRefController.text, widget.w3wController.text);

              // FIXME need to get the location here before moving, or show an indication we are waiting for location
              setState(() {


                // Start centring location marker when location updates, until user interacts
                print('Set centerOnLocationUpdate to ALWAYS (had been ${widget.centerOnLocationUpdate})');
                widget.centerOnLocationUpdate = CenterOnLocationUpdate.always;
                // Centre the location marker and zoom to level 17
                widget.mapController.move(globUserLocation, 17.0);

              });
            },
            child: const Icon(
              Icons.my_location,
              color: Colors.white,
            ),
          ),
        ),*/
        AttributionWidget(
          alignment: Alignment.bottomLeft,
          attributionBuilder: (_) => const ColoredBox(
            color: Color(0xCCFFFFFF), // TODO abstract this gh#81
            child: Padding(
              padding: EdgeInsets.all(3.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '© OpenStreetMap contributors',
                    style: TextStyle(
                      // TODO abstract this gh#81
                      fontSize: xxsTSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Dispose of controllers
    try {
      //_pinGridRefController.dispose();
    } catch (e) {
      print('ERROR disposing of controllers in EmbedMap: $e');
    }
    super.dispose();
  }
}
