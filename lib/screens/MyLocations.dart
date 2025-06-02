//import 'package:characters/characters.dart';
import 'dart:async';
import 'dart:math';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


import '../exports_config.dart';
import '../main.dart';

class MyLocations extends StatefulWidget {
  @override
  State<MyLocations> createState() => _MyLocationsState();
}

class _MyLocationsState extends State<MyLocations> {

  final LocRepository _locRepository = GetIt.I.get();
  List<Loc> _locs = [];
  //bool _customTileExpanded = false;

  // For the map
  late final MapController mapController;
  //CenterOnLocationUpdate centerOnLocationUpdate = CenterOnLocationUpdate.never;
  //late StreamController<double?> centerCurrentLocationStreamController;
  final LatLng startingCentre = LatLng(52.9, -1.9);
  final double startingZoom = 6.0;
  //LatLng pinLocation = LatLng(0.0, 0.0);
  //List<DragMarker> pinList = [];
  //List<LatLng> tappedPoints = [];
  final PopupController popupLayerController = PopupController();
  Location locationObject = Location();

  @override
  void initState() {
    super.initState();
    _loadLocs();

    // Map initialisation
    mapController = MapController();
    //centerCurrentLocationStreamController = StreamController<double?>();
  }

  @override
  Widget build(BuildContext context) {

    // Transform the loaded list of locs into a list of map markers
    // TODO this can be done with map rather than for loop
    List<Marker> locsMarkerList = [];
    print('LOCS BUILD $_locs');
    for(int i = 0; i < _locs.length; i++) {
      LocMarker locMarker = LocMarker(loc: _locs[i], selected: false);
      locsMarkerList.add(locMarker);
    }

    Widget myLocationsListViewBuilder = ListView.builder(
      itemCount: _locs.length,
      itemBuilder: (context, index) {
        final loc = _locs[index];
        return ExpansionTile(
          controlAffinity: ListTileControlAffinity.leading,
          //trailing: Icon(MdiIcons.dotsVertical),
          title: Text(loc.mnemonicLabel),
          //subtitle: Text('${report.id}'), /// Report ID for debugging
          // TODO parsing likely to be a mess
          subtitle: Text(DateFormat('E d MMM y').format(DateTime.parse(loc.createdDateTime))),
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(2 * edgePad, 0.0, 2 * edgePad, edgePad),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(loc.gridRefText, style: xsTStyle),
                    Text('${loc.latitude.toString().substring(0, 6)}, ${loc.longitude.toString().substring(0, 6)}', style: xsTStyle),
                    Text(loc.w3wText, style: xsTStyle),
                    //Text('${report.nearestTown}, ${report.county}'),
                    //Text(report.incidentType.value), //TODO
                    //if (report.crimeReference != '') Text('Police log or crime no. ${report.crimeReference}'),
                    //Text('${Characters(report.userNarrative).take(40)}...', style: smallerTextItalic),//TODO also make it conditional - not appear if no nararitve, dots only if cut off
                    /////TODO Text('Report created ' + DateFormat('HH:mm E d MMM y').format(DateTime.parse(report.whenCreated))),
                    //Text('Report created ' + Characters(report.whenCreated).take(10).toString()),
                    //report.reportCompleted ? const Text('COMPLETED') : const Text('DRAFT'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*Expanded(
                              child: ListTile(
                                  title: const Text('Edit'),
                                  leading: const Icon(MdiIcons.pencil),
                                  onTap: () {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit temporarily disabled')));}
                              )
                          ),
                          const VerticalDivider(width: 1.0),*/
                        Expanded(
                            child: ListTile(
                              title: const Text('Delete'),
                              leading: const Icon(MdiIcons.delete),
                              onTap: () => _deleteLoc(loc),
                              //onTap: () {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Delete temporarily disabled')));}
                            )
                        ),
                        //Expanded(child: Center(child: Text('delete'))),
                      ],
                    ),
                    //Text('Saved? ' + report.reportCompleted.toString()),
                  ],
                ),
              ),
            ),
            /*ListTile(dense: true, title: Text(report.gridRefText)),
              ListTile(dense: true, title: Text(report.nearestTown + ', ' + report.county)),
              ListTile(dense: true, title: Text(report.incidentType.toString())),
              ListTile(dense: true, title: Text(report.crimeReference)),
              ListTile(dense: true, title: Text(report.userNarrative)),
              ListTile(dense: true, title: Text('Report created ' + Characters(report.whenCreated).take(10).toString())),
              ListTile(dense: true, title: Text('Saved? ' + report.reportCompleted.toString())),*/
          ],
          //textColor: textBlack,
          //collapsedTextColor: textBlack,
        );
        /*return ListTile(
            title: Text(report.locationLabel),
            subtitle: Text(
                '${report.mnemonicLabel}\n'
                //'Grid ref: TQ ${report.gridRefE} ${report.gridRefN}\n'
                'ID: ${report.id}\n'
                'Created: ${report.whenCreated}\n'
                'Name: ${report.firstName} ${report.lastName}\n'
                'Date: ${report.incidentDateStr}\n'
                //'Type: ${report.incidentTypeKey}\n'
                //'Police report made? ${report.policeReport}'
                'Compl?: ${report.reportCompleted}\n'
                ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteReport(report),
            ),
            /*leading: IconButton(
              icon: const Icon(Icons.edit_location_outlined),
              onPressed: () => _editReport(report),
            ),*/
          );*/
      },
    );

    Widget myLocationsMapView = FlutterMap(
      mapController: mapController,
      options: MapOptions(

        onTap: (_, __) => popupLayerController.hideAllPopups(),

        center: startingCentre,
        zoom: startingZoom,

        // TODO spin off these constants if the map can't be spun off as one
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

        /*onTap: (tapPosition, tapLocation) async {
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
            print('Map tapped at ${tapPosition.global} but we already have a pin, so do nothing');
          }
        },*/

        /*onPositionChanged: (MapPosition position, bool hasGesture) {
          // If map moves because of a gesture, take focus to hide keyboard
          if (hasGesture) {
            FocusScope.of(context).requestFocus(FocusNode());
            // Then if we are continuously centering, stop doing that
            if(widget.centerOnLocationUpdate != CenterOnLocationUpdate.never) {
              print('Gesture detected so stop center on location update');
              setState(() => widget.centerOnLocationUpdate = CenterOnLocationUpdate.never);
            }
          }
        },*/
      ),
      children: <Widget>[
        TileLayer(
          urlTemplate: mapTemplateUrl + mapKeyApi,
          subdomains: const ['a', 'b', 'c'],
          // TODO errorImage, and what about tile caching?
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
          //centerOnLocationUpdate: centerOnLocationUpdate,
          //centerCurrentLocationStream: centerCurrentLocationStreamController.stream,
          turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
        ),
        /*DragMarkers(
          markers: widget.pinList,
        ),*/


        /*MarkerLayer(
          markers: locsMarkerList,
        ),*/

        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
            popupController: popupLayerController,
            markers: locsMarkerList,
            markerRotateAlignment: PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
            markerTapBehavior: MarkerTapBehavior.custom((marker, popupState, popupController) {
              print('TAPPED!');
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


        // 3 below were in non-rotated children
        Positioned(
          right: 15,
          bottom: 15,
          //bottom: 80,
          child: FloatingActionButton(
            heroTag: 'mapLocateMe',
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
              locateMe(locationObject);
              //widget.callback(widget.pinList, widget.pinLocation, widget.pinGridRefController.text, widget.w3wController.text);

              // TODO need to get the location here before moving, or show an indication we are waiting for location
              setState(() {


                // Start centring location marker when location updates, until user interacts
                //print('Set centerOnLocationUpdate to ALWAYS (had been ${centerOnLocationUpdate})');
                //centerOnLocationUpdate = CenterOnLocationUpdate.always;

                // Centre the location marker and zoom to level 17
                mapController.move(globUserLocation, 17.0);

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

    final myLocationsTabPages = <Widget>[
      myLocationsMapView,
      myLocationsListViewBuilder,
    ];

    final myLocationsTabs = <Tab>[
      const Tab(
        // TODO probably made the text go alongside. May need a child
        icon: Icon(Icons.map),
        text: 'Map',
      ),
      const Tab(
        icon: Icon(Icons.list),
        text: 'List',
      ),
    ];

    // TODO see if we can preserve state when switching tabs https://blog.logrocket.com/flutter-tabbar-a-complete-tutorial-with-examples/

    return DefaultTabController(
      length: myLocationsTabs.length,
      child: Scaffold(
        backgroundColor: appBackground,
        appBar: AppBar(
          // Based on appBarOneLineWithHome, but spun off because of TabBar
          backgroundColor: appBarColor,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          centerTitle: true,
          title: const Text('My locations'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => Navigator.of(context).pushNamed(sHomeScreen),
            ),
          ],
          bottom: TabBar(
            physics: const NeverScrollableScrollPhysics(),
            tabs: myLocationsTabs,
          )
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: myLocationsTabPages,
        ),
        /*floatingActionButton: FloatingActionButton(
          heroTag: 'addLoc',
          backgroundColor: crimeRed,
          splashColor: yellowHighlight,
          // TODO more splash colours gh#80
          elevation: 10.0,
          child: const Icon(MdiIcons.mapMarkerPlus),
          onPressed: _addLoc,
        ),*/
      ),
    );
  }

  @override
  void dispose() {
    print('DISPOSE Mapp');
    // Stop listening to location when we move away from the map
    //centerCurrentLocationStreamController.close();
    super.dispose();
  }

  _loadLocs() async {
    print('loading locations!! 1');
    final locs = await _locRepository.getAllLocs();
    print('loading locations!! 2');
    setState(() => _locs = locs);
    print('loading locations!! 3');
  }

  _addLoc() async {

    // Assign it an ID
    final int id = DateTime.now().millisecondsSinceEpoch;
    final list = ['Cow Farm sett', 'Woody forest', 'Watery lake', 'Building site', 'Sett in the woods']..shuffle();
    final String mnemonicLabel = list.first;

    final double latitude = Random().nextDouble() * 4 + 51;
    final double longitude = Random().nextDouble() * 5 - 4;
    //const double latitude = 52.5;
    //const double longitude = -0.4;


    const String gridRefText = 'TT 23546 25533';
    const String w3wText = 'hello.goodbye.yes';
    final String createdDateTime = DateTime.fromMillisecondsSinceEpoch(id, isUtc: true).toString(); // TODO need to allow for DST
    const String appVersionCreated = appVersion;

    final newLoc = Loc(
      id: id,
      mnemonicLabel: mnemonicLabel,
      latitude: latitude,
      longitude: longitude,
      gridRefText: gridRefText,
      w3wText: w3wText,
      createdDateTime: createdDateTime,
      appVersionCreated: appVersionCreated,
    );
    var insertresult = await _locRepository.insertLoc(newLoc);
    print('INSERT RESULT $insertresult');
    _loadLocs();
  }

  _deleteLoc(Loc loc) async {
    print('deleting loc 1: ${loc.createdDateTime}');
    print('deleting loc 1: ID ${loc.id}');
    print('deleting loc 1: ${loc.mnemonicLabel}');
    int? delresult = 66; //TODO
    delresult = await _locRepository.deleteLoc(loc.id);
    print('delresult..... $delresult');
    print('deleting loc 2: ${loc.id}');
    _loadLocs();
    print('deleting loc 3: ${loc.id}');
  }

// TODO all the required fields need to be spelled out here
/*_editReport(Report report) async {
    final updatedReport = report.copyWith(
      gridRefE: Random().nextInt(99999),
      gridRefN: Random().nextInt(99999),
    );
    await _reportRepository.updateReport(updatedReport);
    _loadReports();
  }*/
}
