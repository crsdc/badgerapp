import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/dragmarker.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
//import 'package:location/location.dart';
import 'package:what3words/what3words.dart' as w3w;
import '../exports_config.dart';
//import '../main.dart';

class EmbedMap extends StatefulWidget { // TODO tidy this

  final bool constrain;
  late MapController mapController;
  late List<DragMarker> pinList;
  late LatLng pinLocation;
  late w3w.What3WordsV3 w3wAPI;
  late List<LatLng> tappedPoints = [];
  late TextEditingController w3wController;
  late MapFormModel model = MapFormModel();
  late TextEditingController pinGridRefController;
  late CenterOnLocationUpdate centerOnLocationUpdate;
  late StreamController<double?> centerCurrentLocationStreamController;
  final LatLng startingCentre;
  final double startingZoom;
  final PopupController popupLayerController;
  late List<Loc> locs;
  //late List<Marker> locsMarkerList;
  late Location locationObject;

  Function(
    List<DragMarker> pinList,
    LatLng pinLocation,
    String pinGridRefControllerText,
    String w3wControllerText,
  ) callback;

  EmbedMap( // TODO replace with named parameters
      this.constrain,
      this.mapController,
      this.pinList,
      this.pinLocation,
      this.w3wAPI,
      this.tappedPoints,
      this.w3wController,
      this.model,
      this.pinGridRefController,
      this.centerOnLocationUpdate,
      this.centerCurrentLocationStreamController,
      this.startingCentre,
      this.startingZoom,
      this.popupLayerController,
      this.locs,
      this.locationObject,
      this.callback,
  );

  @override
  EmbedMapState createState() => EmbedMapState();
}

class EmbedMapState extends State<EmbedMap> {

  @override
  Widget build(BuildContext context) {

    List<Marker> locsMarkerList = [];
    print('LOCS BUILD $widget.locs');
    for(int i = 0; i < widget.locs.length; i++) {
      LocMarker locMarker = LocMarker(loc: widget.locs[i], selected: false);
      locsMarkerList.add(locMarker);
    }

    FlutterMap flutterMap = FlutterMap(
      mapController: widget.mapController,
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
          if (widget.pinLocation == LatLng(0.0, 0.0)) {
            print('Map tapped at ${tapPosition.global} and we\'ll place a pin');

            // Attempt w3w conversion
            var w3Words = await widget.w3wAPI.convertTo3wa(
                w3w.Coordinates(tapLocation.latitude, tapLocation.longitude))
                .language('en')
                .execute();
            print('w3w: ${w3Words.data()!.toJson()['words']}');

            setState(() {
              print('Pin placement tap setState');
              print(widget.model.pinGridRef);

              // Set the form data and the on-screen text field
              widget.model.pinGridRef = latLongToOSNumeric(tapLocation.latitude, tapLocation.longitude);
              widget.pinGridRefController.text = widget.model.pinGridRef;
              print(widget.pinGridRefController.text);
              print(widget.pinList.length); // TODO where is this used?

              // Set the pin on the map
              widget.pinLocation = LatLng(tapLocation.latitude, tapLocation.longitude);
              widget.tappedPoints.clear();
              widget.tappedPoints.add(LatLng(tapLocation.latitude, tapLocation.longitude));
              print('Create pin at ${widget.pinLocation}');

              // W3W setting
              widget.w3wController.text = w3Words.data()!.toJson()['words'];

              // Callback to make map update
              widget.callback(widget.pinList, widget.pinLocation, widget.pinGridRefController.text, widget.w3wController.text);
            });
          } else {
            print('Map tapped at ${tapPosition.global} but we already have a pin, so don\'t add one');
            widget.popupLayerController.hideAllPopups();
          }
        },

        onPositionChanged: (MapPosition position, bool hasGesture) {
          // If map moves because of a gesture, take focus to hide keyboard
          if (hasGesture) {
            FocusScope.of(context).requestFocus(FocusNode());
            // Then if we are continuously centering, stop doing that
            if(widget.centerOnLocationUpdate != CenterOnLocationUpdate.never) {
              print('Gesture detected so stop center on location update');
              setState(() => widget.centerOnLocationUpdate = CenterOnLocationUpdate.never);
            }
          }
        },
      ),
      children: <Widget>[
        TileLayer(
          urlTemplate: mapTemplateUrl + mapKeyApi,
          subdomains: const ['a', 'b', 'c'],
          // TODO errorImage, and what about tile caching?
          tileProvider: FlutterMapTileCaching.instance('TF-OSM-landscape').getTileProvider(),
          backgroundColor: Colors.white,
          //errorImage: maybe implement in the future, for now coloured background
          //userAgentPackageName: , not clear that it's needed for TF
          /*tileProvider: FlutterMapTileCaching.instance('TF-OSM-landscape').getTileProvider(
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
              //color: crimeRed,
            ),
            markerSize: const Size(20, 20),
            accuracyCircleColor: Colors.blue.withOpacity(0.5),
            //accuracyCircleColor: crimeRed.withOpacity(0.3),
            // Heading often misleading especially when stationary
            showHeadingSector: false,
          ),
          centerOnLocationUpdate: widget.centerOnLocationUpdate,
          centerCurrentLocationStream: widget.centerCurrentLocationStreamController.stream,
          turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
        ),


        PopupMarkerLayerWidget(
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
        ),

        DragMarkers(
          markers: widget.pinList,
        ),

        // 3 below were in non-rotated children
        Positioned(
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

              // TODO need to get the location here before moving, or show an indication we are waiting for location
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
        ),
        AttributionWidget(
          alignment: Alignment.bottomLeft,
          // Innards modified from flutter_map stock example
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
                      fontSize: 8.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    return flutterMap;
  }
}
