import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/dragmarker.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:what3words/what3words.dart' as w3w;

import '../exports_config.dart';

/*class DeviceLocationData {
  Location deviceLocation = Location();
  bool locationServiceEnabled = false;
  PermissionStatus? locationPermissionGranted;
}

Future<Location> locateMe(deviceLocationData) async {
  print('_locateMe() 1. Check whether service is enabled');
  deviceLocationData.locationServiceEnabled = await deviceLocationData.deviceLocation.serviceEnabled();
  print('_locateMe() _serviceEnabled = $locationServiceEnabled');
  if (!locationServiceEnabled) {
    print('_locateMe() So now we will requestService()');
    locationServiceEnabled = await location.requestService();
    print('_locateMe() requestService() done');
    if (!locationServiceEnabled) {
      print('_locateMe() _serviceEnabled still NO after requesting so GIVE UP');
      return location;
    }
  }
  print('_locateMe() 2. Check whether we have location permission');
  locationPermissionGranted = await location.hasPermission();
  print('_locateMe() $locationPermissionGranted');
  if (locationPermissionGranted == PermissionStatus.denied) {
    print('_locateMe() so now we will requestPermission()');
    locationPermissionGranted = await location.requestPermission();
    print('_locateMe() requestPermission() done');
    if (locationPermissionGranted != PermissionStatus.granted) {
      print('_locateMe() _permissionGranted still NO after requesting so GIVE UP');
      return location;
    }
  }
  print('_locateMe() Completed and we have both location service and permission');
  return location;
}*/

class Mapp extends StatefulWidget {
  @override
  State<Mapp> createState() => _MappState();
}

class _MappState extends State<Mapp> {

  final LocRepository _locRepository = GetIt.I.get();
  List<Loc> _locs = [];
  var locsIfActive = <Loc>[];

  // Form
  final GlobalKey<FormState> _formKeyMapp = GlobalKey<FormState>();
  MapFormModel model = MapFormModel();
  final TextEditingController _pinGridRefController = TextEditingController();
  final TextEditingController _w3wController = TextEditingController();
  final TextEditingController _locSaveNameController = TextEditingController();

  // Map
  late final MapController mapController;
  CenterOnLocationUpdate centerOnLocationUpdate = CenterOnLocationUpdate.never;
  late StreamController<double?> centerCurrentLocationStreamController;
  final LatLng startingCentre = LatLng(52.9, -1.9);
  final double startingZoom = 6.0;
  final PopupController popupLayerController = PopupController();

  // Surrounding interface
  bool latlongDisplayEnabled = false;
  bool w3wDisplayEnabled = false;
  bool mylocDisplayEnabled = false;

  // w3w
  w3w.What3WordsV3 w3wAPI = w3w.What3WordsV3(w3wKeyApi); // final??
  String w3wDisplay = '';

  // List of pins - but should it be done with lists??
  LatLng pinLocation = LatLng(0.0, 0.0);
  List<DragMarker> pinList = [];
  List<LatLng> tappedPoints = [];

  LiveReport liveReport = LiveReport();

  // To update state from inside the map widget
  callback(newPinList, newPinLocation, newPinGridRefControllerText, newW3wControllerText) {
    setState(() {
      print('CALLBACK');
      print(newPinLocation.latitude);
      //print(newPinList);
      print('newPinGridRefControllerText $newPinGridRefControllerText');
      pinLocation = newPinLocation;
      //_pinGridRefController.text = newPinGridRefControllerText;
      //pinList.clear();
      //pinList = newPinList;
    });
  }

  // Clear button on grid ref field only shown when something to clear
  bool _showClearButton = false;
  Widget? _clearButton() {
    if (!_showClearButton) {
      return null;
    } else {
      return IconButton(
        onPressed: () {
          _pinGridRefController.clear();
          pinLocation = LatLng(0.0, 0.0);
          _w3wController.clear();
          w3wDisplay = '';
          //tappedPoints.clear();
        },
        icon: const Icon(Icons.clear),
      );
    }
  }

  //Location locationObject = Location();
  //Location locationObject = Location();
  //late LocationData? locationData;
  Location locationObject = Location();

  // moved into global
  //bool locationServiceEnabled = false;
  //PermissionStatus locationPermissionGranted = PermissionStatus.denied;


  //LatLng userLocation = LatLng(0.0, 0.0);
  //DeviceLocationData deviceLocationData = DeviceLocationData();

  /*void locateMe() async {
    print('locateMe() called and prior location was ${globUserLocation.latitude}, ${globUserLocation.longitude}');

    print('locateMe() 1. Check whether service is enabled');
    locationServiceEnabled = await locationObject.serviceEnabled();
    print('locateMe() locationserviceEnabled = $locationServiceEnabled');
    if (!locationServiceEnabled) {
      print('locateMe() So now we will requestService()');
      locationServiceEnabled = await locationObject.requestService();
      // TODO why is it asking twice?
      print('locateMe() requestService() done');
      if (!locationServiceEnabled) {
        print('locateMe() Still NO after requesting so GIVE UP trying to enable location service');
        return;
      }
    }

    print('locateMe() 2. Check whether we have location permission');
    locationPermissionGranted = await locationObject.hasPermission();
    print('locateMe() $locationPermissionGranted');
    if (locationPermissionGranted == PermissionStatus.denied) {
      print('locateMe() So now we will requestPermission()');
      locationPermissionGranted = await locationObject.requestPermission();
      print('locateMe() requestPermission() done');
      if (locationPermissionGranted != PermissionStatus.granted) {
        print('locateMe() Still NO after requesting so GIVE UP trying to obtain location permission');
        return;
      }
    }

    print('locateMe() 3. We have both location service and permission');
    LocationData locationData = await locationObject.getLocation();
    print('locateMe() LOCATION IS ${locationData.latitude}, ${locationData.longitude}');
    globUserLocation = LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
    return;
  }*/

  @override
  void initState() {
    print('INIT STATE');
    super.initState();

    mapController = MapController();
    //centerOnLocationUpdate = CenterOnLocationUpdate.never;
    centerCurrentLocationStreamController = StreamController<double?>();
    _pinGridRefController.addListener(() => setState(() => _showClearButton = _pinGridRefController.text.isNotEmpty));

    _loadLocs();

    // Get location as soon as we init, but this might not be a good place for it
    locateMe(locationObject);
    //deviceLocationData = locateMe(deviceLocationData);

    //Location locationObject = Location();
    //LocationData locationData = await locateMe(locationObject);
    //print(locationObject.getLocation().toString());

    // Centre the location marker on the map and zoom the map to level 12
    //centerCurrentLocationStreamController.add(12.0);
    // TODO SEEK LOCATION IF AT THE SCENE NOW, but if not then should wait for user to ask for it
  }

  @override
  Widget build(BuildContext context) {

    if(mylocDisplayEnabled) {
      print('eeeeeeeeee 1');
      locsIfActive.clear();
      locsIfActive = List.from(_locs);
    } else {
      print('eeeeeeeeee 2');
      locsIfActive.clear();
    }

    print('BUILD');
    print('pinLocation ${pinLocation.latitude}, ${pinLocation.longitude}');
    print('pinGridRefController.text ${_pinGridRefController.text}');
    print('model.pinGridRef ${model.pinGridRef}');

    if (ModalRoute.of(context)?.settings.arguments != null) {
      final LiveReport receivedData = ModalRoute.of(context)?.settings.arguments as LiveReport;
      liveReport = receivedData;
      print('receivedData on screen Mapp:   $receivedData');
      print('liveReport on screen Mapp:   $liveReport');
    } else {
      print(Error.noArgsForLiveReport);
    }

    // Building Mapp screen so seek location
    //locateMe(locationObject);

    /*if (_pinGridRefController.text != latLongToOSNumeric(pinLocation.latitude, pinLocation.longitude)) {
      print('text field and model are different');
    } else {
      print('text field and model are same');
      if (model.pinGridRef == latLongToOSNumeric(pinLocation.latitude, pinLocation.longitude)) {
        print('model and marker ARE ALREADY THE SAME!');
      } else {
        // TODO when the map moves it resets from this
        model.pinGridRef = latLongToOSNumeric(pinLocation.latitude, pinLocation.longitude);
      }
      //_pinGridRefController.text = model.pinGridRef;
      print('have reset map form');
    }*/

    List<DragMarker> pinList = tappedPoints.map((latlng) {
      return DragMarker(
        point: pinLocation,
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
          print('Finished drag at ${point.latitude}, ${point.longitude}');

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
          });
        }
      );
    }).toList();

    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: appBarColor,
        title: const Text('Map'),
      ),

      body: GestureDetector(
        // Take focus from text field when another part of screen tapped
        onTap: () {
          print('Triggered the catch-all gesture detector');
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: outsideButtonDoubleTop,
                    child: Text(
                      'Mark the incident location by tapping the map, entering a grid reference, or using a saved location',
                      style: mTStyle,
                      //textAlign: TextAlign.left, TODO test effect of this
                    ),
                  ),
                ),
              ],
            ),

            Form(
              key: _formKeyMapp,
              child: Column(
                children: [

                  // Grid ref field row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(outsideButton, 0.0, outsideButton / 2, 0.0),
                          child: SizedBox(
                            height: 36,
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.map),
                                hintText: 'Grid reference',
                                fillColor: Colors.white,
                                filled: true,
                                suffixIcon: _clearButton(),
                                //contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: outsideButton),
                              ),
                              controller: _pinGridRefController,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(outsideButton / 2, 0.0, outsideButton, 0.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: crimeRed,
                          ),
                          onPressed: () async {
                            print('Grid ref entry button pressed');
                            LatLng dropLocation = LatLng(0.0, 0.0);

                            // Take focus to hide keyboard
                            FocusScope.of(context).requestFocus(FocusNode());

                            // Check whether text field blank
                            if (_pinGridRefController.text == '') {
                              if (globUserLocation != LatLng(0.0, 0.0)) {
                                // If blank and we have a live user location, drop pin there
                                dropLocation = globUserLocation;
                              } else {
                                // If blank and we have no user location, drop pin at map centre
                                dropLocation = mapController.center;
                              }
                            } else {
                              // Text field isn't blank

                              // TODO need much better grid ref validation
                              /* future grid ref input validation?
                              strip spaces and other characters
                              must start with 2 letters
                              must have even number of digits <= 10
                              capitalise letters
                              space
                              first half of digits and pad out
                              second half of digits and pad out*/

                              // Convert OS grid ref to lat long and use that
                              print('taking text field input as a GRID REF');
                              print(dropLocation);
                              try {
                                dropLocation = osToLatLong(_pinGridRefController.text);
                              } on ConversionException {
                                print('back from conversion and it threw exception so show toast');
                                toastCustom('Not a valid grid reference');
                                print(dropLocation);
                                // Don't do anything with pin if we were given gibberish
                                return;
                              }
                              /*dropLocation = LatLng(
                                osToLatLong(_pinGridRefController.text).lat,
                                osToLatLong(_pinGridRefController.text).long
                              );*/
                              print(dropLocation);
                            }

                            // Set the pin on the map
                            pinLocation = dropLocation;
                            print('pinLocation ${pinLocation.latitude} ${pinLocation.longitude}');
                            tappedPoints.clear();
                            tappedPoints.add(pinLocation);

                            // Attempt w3w conversion
                            var w3Words = await w3wAPI.convertTo3wa(
                                w3w.Coordinates(pinLocation.latitude, pinLocation.longitude))
                                .language('en')
                                .execute();
                            print('w3w: ${w3Words.data()!.toJson()['words']}');
                            print('w3w: ${w3Words.data()!.toJson()['words']}');
                            // TODO sanity check for null island, os origin, map origin and centre

                            setState(() {
                              print('Pin placement typed in grid ref setState');
                              print(model.pinGridRef);

                              // W3W setting
                              _w3wController.text = w3Words.data()!.toJson()['words'];
                              w3wDisplay = _w3wController.text;

                              // Set the form data and the on-screen text field
                              model.pinGridRef = latLongToOSNumeric(pinLocation.latitude, pinLocation.longitude); // TODO replace with validated pingridref from above gh#79
                              _pinGridRefController.text = model.pinGridRef;

                              // W3W setting
                              _w3wController.text = w3Words.data()!.toJson()['words'];
                              w3wDisplay = _w3wController.text;
                            });
                          },
                          child: const Icon(MdiIcons.mapMarkerPlus),
                        ),
                      ),
                    ],
                  ),

                  // W3W and latlong rows
                  // TODO these should become the main displays
                  /*w3wNiceDisplay(_w3wController.text),
                  latLongNiceDisplay(pinLocation),*/

                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 8.0,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ActionChip(
                                avatar: const CircleAvatar(
                                  child: Icon(MdiIcons.folderMarker),
                                ),
                                label: Text(
                                  'my locations',
                                  style: TextStyle(
                                      color: mylocDisplayEnabled ? Colors.white : Colors.black
                                  )
                                ),
                                backgroundColor: mylocDisplayEnabled ? Colors.blue : softBackground,
                                onPressed: () {
                                  mylocDisplayEnabled = !mylocDisplayEnabled;
                                  print('myloc pressed');
                                  setState(() {
                                    if(!mylocDisplayEnabled) {
                                      print('myloc layer is disabled so hide popups');
                                      popupLayerController.hideAllPopups();
                                    }
                                  });
                                }
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                            ],
                          ),
                          Visibility(
                            visible: pinLocation != LatLng(0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ActionChip(
                                  avatar: const CircleAvatar(
                                    child: Icon(MdiIcons.web),
                                  ),
                                  label: Text(
                                    'lat/long',
                                    style: TextStyle(
                                      color: latlongDisplayEnabled ? Colors.white : Colors.black
                                    )
                                  ),
                                  backgroundColor: latlongDisplayEnabled ? Colors.blue : softBackground,
                                  onPressed: () {
                                    latlongDisplayEnabled = !latlongDisplayEnabled;
                                    print('latlong pressed');
                                    setState(() {});
                                  }
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                ActionChip(
                                  avatar: const CircleAvatar(
                                    child: Icon(MdiIcons.slashForward),
                                  ),
                                  label: Text(
                                    'w3w',
                                    style: TextStyle(
                                        color: w3wDisplayEnabled ? Colors.white : Colors.black
                                    )
                                  ),
                                  backgroundColor: w3wDisplayEnabled ? Colors.blue : softBackground,
                                  onPressed: () {
                                    w3wDisplayEnabled = !w3wDisplayEnabled;
                                    print('w3w pressed');
                                    setState(() {});
                                  }
                                ),
                              ],
                            ),
                          ),
                          /*ElevatedButton.icon(
                            icon: const Icon(MdiIcons.folderMarker),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: crimeRed,
                              // Shrink padding slightly. How this widget handles internal padding is complex, but this will do.
                              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                            ),
                            label: const Text('My locations'),
                            onPressed: () {
                              print('summon my locations3');
                              showModalBottomSheet<void>(
                                // context and builder are
                                // required properties in this widget
                                context: context,
                                builder: (BuildContext context) {
                                  // we set up a container inside which
                                  // we create center column and display text

                                  // Returning SizedBox instead of a Container
                                  return SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const <Widget>[
                                          Text('locations'),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),*/
                        ],
                      ),
                    ),
                  ),

                  Visibility(
                    visible: latlongDisplayEnabled,
                    child: latLongNiceDisplay(pinLocation),
                  ),
                  Visibility(
                    visible: w3wDisplayEnabled,
                    child: w3wNiceDisplay(_w3wController.text),
                  ),


                  // W3W row as form field
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(outsideButton, 0.0, outsideButton, outsideButton),
                          child: SizedBox(
                            //height: 36,
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.fromLTRB(outsideButton / 2, outsideButton, 0.0, outsideButton),
                                  child: Text(
                                    'W3W',
                                    style: TextStyle(color: highlightScrollbar),
                                  ),
                                ),
                                hintText: 'what3words',
                                fillColor: Colors.white,
                                filled: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    // TODO copy to clipboard
                                  },
                                  icon: const Icon(Icons.copy),
                                ),
                                //contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: outsideButton),
                              ),
                              controller: _w3wController,
                              keyboardType: TextInputType.text,
                              *//*onSaved: (value) {
                                liveReport.activeReport.gridRefText = value!;
                                print('hit save');
                                // TODO some logic for presenting the grid ref correctly gh#79
                                model.pinGridRef = value;
                              },*//*
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),*/
                ],
              ),
            ),


            // THE MAP ITSELF
            Flexible(
              child: EmbedMap(
                false, // fill height
                mapController,
                pinList,
                pinLocation,
                w3wAPI,
                tappedPoints,
                _w3wController,
                model,
                _pinGridRefController,
                centerOnLocationUpdate,
                centerCurrentLocationStreamController,
                startingCentre,
                startingZoom,
                popupLayerController,
                locsIfActive,
                locationObject,
                //userLocation,
                callback,
              ),
            ),

            // NEXT BUTTON
            Row(
              children: [
                PillButton(
                  buttonType: PillButtonType.standard,
                  // TODO should probably be a standard material arrow gh#87
                  buttonText: 'Next',
                  pressFunction: () {

                    // Save location in the livereport
                    print('Mapp saving lat ${pinLocation.latitude} long ${pinLocation.longitude}');
                    liveReport.activeReport.latitude = pinLocation.latitude;
                    liveReport.activeReport.longitude = pinLocation.longitude;
                    // TODO put grid ref and w3w in it here too


                    // If no pin set, move on to evidence checklist without a location
                    if (pinLocation == LatLng(0.0, 0.0)) {
                      Navigator.of(context).pushNamed(sChecklist, arguments: liveReport);

                    } else {
                      // Check whether pin location is one of user's saved locations,
                      // in which case don't ask to save it again.
                      bool askToSaveLoc = true;
                      for (Loc checkingLoc in _locs) {
                        if (pinLocation == LatLng(checkingLoc.latitude, checkingLoc.longitude)) askToSaveLoc = false;
                      }
                      if (!askToSaveLoc) {
                        Navigator.of(context).pushReplacementNamed(sChecklist, arguments: liveReport);
                      } else {
                        // Pin location is set and is not an already saved location, so show save dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Location'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    const Text(
                                        'Would you like to give this location an optional name so you can use it for future reports?'),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, outsideButton, 0.0, 0.0),
                                      child: SizedBox(
                                        height: 36,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                                MdiIcons.bookMarker),
                                            hintText: 'Name',
                                            fillColor: Colors.white,
                                            filled: true,
                                            suffixIcon: _clearButton(),
                                            //contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: outsideButton),
                                          ),
                                          controller: _locSaveNameController,
                                          keyboardType: TextInputType.name,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('SKIP'),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        sChecklist, arguments: liveReport);
                                  },
                                ),
                                TextButton(
                                  // TODO can't save if nothing written, and should disable button
                                  child: const Text('SAVE'),
                                  onPressed: () {
                                    if (_locSaveNameController.text != '') { // TODO isnotempty?
                                      print('save the location');
                                      _saveLoc();
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                          sChecklist, arguments: liveReport);
                                    }
                                  },
                                ),

                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('DISPOSE Mapp');

    // Stop listening to location when we move away from the map
    centerCurrentLocationStreamController.close();

    // Dispose of controllers
    try {
      _pinGridRefController.dispose();
      _w3wController.dispose();
      _locSaveNameController.dispose();
      mapController.dispose();
    } catch (e) {
      print('ERROR disposing of controllers on Mapp: $e');
    }

    super.dispose();
  }

  _loadLocs() async {
    print('loading locations!! 1');
    final locs = await _locRepository.getAllLocs();
    print('loading locations!! 2');
    setState(() => _locs = locs);
    print('loading locations!! 3');
  }

  _saveLoc() async {
    // Assign it an ID
    final int id = DateTime.now().millisecondsSinceEpoch;
    final String mnemonicLabel = _locSaveNameController.text;
    final double latitude = pinLocation.latitude;
    final double longitude = pinLocation.longitude;
    final String gridRefText = _pinGridRefController.text;
    final String w3wText = _w3wController.text;
    final String createdDateTime = DateTime
        .fromMillisecondsSinceEpoch(
        id, isUtc: true)
        .toString(); // TODO need to allow for DST
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
    var insertresult = await _locRepository
        .insertLoc(newLoc);
    print('INSERT RESULT $insertresult');
  }
}
