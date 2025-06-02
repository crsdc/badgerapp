import 'dart:async';

import 'package:flutter/gestures.dart';
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

class Nine extends StatefulWidget {
  @override
  State<Nine> createState() => _NineState();
}

class _NineState extends State<Nine> {

  final LocRepository _locRepository = GetIt.I.get();
  List<Loc> _locs = [];

  // Form
  final GlobalKey<FormState> _formKeyNine = GlobalKey<FormState>();
  MapFormModel model = MapFormModel();
  final TextEditingController _pinGridRefController = TextEditingController();
  final TextEditingController _w3wController = TextEditingController();

  // Map
  late final MapController mapController;
  CenterOnLocationUpdate centerOnLocationUpdate = CenterOnLocationUpdate.never;
  late StreamController<double?> centerCurrentLocationStreamController;
  final LatLng startingCentre = LatLng(52.9, -1.9);
  final double startingZoom = 6.0;
  final PopupController popupLayerController = PopupController();

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

  Location locationObject = Location();

  @override
  void initState() {
    print('INIT STATE');
    super.initState();

    //_loadLocs();

    mapController = MapController();
    centerCurrentLocationStreamController = StreamController<double?>();
    _pinGridRefController.addListener(() => setState(() => _showClearButton = _pinGridRefController.text.isNotEmpty));
    locateMe(locationObject);
  }

  @override
  Widget build(BuildContext context) {
    print('BUILD');
    print('pinLocation ${pinLocation.latitude}, ${pinLocation.longitude}');
    print('pinGridRefController.text ${_pinGridRefController.text}');
    print('model.pinGridRef ${model.pinGridRef}');

    if (ModalRoute.of(context)?.settings.arguments != null) {
      final LiveReport receivedData = ModalRoute.of(context)?.settings.arguments as LiveReport;
      liveReport = receivedData;
      print('receivedData on screen Nine:   $receivedData');
      print('liveReport on screen Nine:   $liveReport');
    } else {
      print(Error.noArgsForLiveReport);
    }

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
        title: const Text('Call 999'),
      ),

      body: GestureDetector(
        // Take focus from text field when another part of screen tapped
        onTap: () {
          print('Triggered the catch-all gesture detector');
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: [
            Form(
              key: _formKeyNine,
              child: Column(
                children: [
                  Padding(
                    padding: outsideButtonAll,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(
                                Icons.call,
                                //MdiIcons.phoneAlert,
                                //MdiIcons.carEmergency,
                                size: 50.0,
                                color: crimeRed,
                              ),
                            ),
                          ],
                        ),
                        RichText(
                          textScaleFactor: MediaQuery.of(context).textScaleFactor,
                          text: TextSpan(
                            style: mTStyle,
                            children: [
                              if (liveReport.dangerFlag) const TextSpan(text: 'This is a potentially dangerous situation and you should ensure your own safety. The information you have entered suggests you should call the police now on ')
                              else const TextSpan(text: 'The information you have entered suggests you should call the police now on '),
                              TextSpan(
                                text: '999',
                                style: mTLink,
                                recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('tel://1234567890'),
                              ),
                              const TextSpan(text: '.'),
                              paraBreakText(),
                              const TextSpan(text: 'Give them your location. Describe what you have witnessed. Include descriptions of any people or vehicles at the scene. Explain that you believe an offence has been or is being committed under the Protection of Badgers Act (1992), or cite other relevant legislation.'),
                              paraBreakText(),
                              const TextSpan(text: 'Emphasise that this incident is happening right now and police attendance is required. Ask them to flag the incident for a Wildlife Crime Officer as soon as possible.'),
                              paraBreakText(),
                              const TextSpan(
                                text: 'Incident location',
                                style: mTBold,
                              ),
                              paraBreakText(),
                              const TextSpan(text: 'Mark your location or the location of the crime on the map so you can provide it to the police, and so it can be included in the report to send to Badger Trust.'),
                              //const TextSpan(text: 'Hit the bullseye button on the map to find your current location.'),
                              //paraBreakText(),
                              //const TextSpan(text: 'If this is not the incident location, drop a pin to the correct location, edit the grid reference or W3W, or choose from saved locations.'),
                            ],
                          ),
                        ),
      
                      ],
                    ),
                  ),

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
                        padding: const EdgeInsets.fromLTRB(outsideButton / 2, 0.0, outsideButton, outsideButton / 2),
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
            
                  // W3W row as form field
                  Row(
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
                              /*onSaved: (value) {
                                liveReport.activeReport.gridRefText = value!;
                                print('hit save');
                                // TODO some logic for presenting the grid ref correctly gh#79
                                model.pinGridRef = value;
                              },*/
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: EmbedMap(
                      true, // constrain height
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
                      _locs,
                      locationObject,
                      //userLocation,
                      callback,
                    ),
                  ),

                  /*ElevatedButton(
                    style: dbButton,
                    onPressed: () {
                      disabledSnackBar(context);
                    },
                    child: const Text('Confirm and save incident location'),
                  ),*/
                  const SizedBox(height: paraBreak),
                  const Text(
                    'Incident number',
                    style: mTBold,
                  ),
                  const SizedBox(height: paraBreak),
                  const Text(
                    'Ask the police for an incident number, and record it here.',
                    style: mTStyle,
                  ),
                  const SizedBox(height: paraBreak),

                  // Incident number row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(outsideButton, 0.0, outsideButton, outsideButton),
                          child: SizedBox(
                            //height: 36,
                            child: TextFormField(
                              decoration: const InputDecoration(labelText: 'Incident number'),
                              initialValue: '',
                              onSaved: (value) {
                                model.incidentNumber = value!;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                  const SizedBox(height: paraBreak),
                  const Text(
                    'When you\'ve finished speaking to the police, tap Next to document evidence.',
                    style: mTStyle,
                  ),
                  const SizedBox(height: paraBreak),


                  // NEXT BUTTON
                  Row(
                    children: [
                      PillButton(
                        buttonType: PillButtonType.standard,
                        // TODO should probably be a standard material arrow gh#87
                        buttonText: 'Next',
                        pressFunction: () {
                          // Save location in the livereport
                          _formKeyNine.currentState!.save();
                          print('Nine saving lat ${pinLocation.latitude} long ${pinLocation.longitude}');
                          liveReport.activeReport.latitude = pinLocation.latitude;
                          liveReport.activeReport.longitude = pinLocation.longitude;
                          liveReport.activeReport.crimeReference = model.incidentNumber;
                          Navigator.of(context).pushNamed(sChecklist, arguments: liveReport);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
            
            
            
            /*Center(
              child: ListView(
                padding: const EdgeInsets.all(edgePad),
                children: <Widget>[
                  const SizedBox(height: paraBreak),
                  const Icon(Icons.call, size: 50.0),
                  const SizedBox(height: paraBreak),
                  RichText(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    text: TextSpan(
                      style: bodyText,
                      children: [

                      ],
                    ),
                  ),
                  const SizedBox(height: paraBreak),

                  const SizedBox(height: paraBreak),
                  Image.asset(imgMapWithFieldsPLACEHOLDER),
                  const SizedBox(height: paraBreak),

                ],
              ),
            ),*/


  }

  @override
  void dispose() {
    print('DISPOSE Nine');

    // Stop listening to location when we move away from the map
    centerCurrentLocationStreamController.close();

    // Dispose of controllers
    try {
      _pinGridRefController.dispose();
      _w3wController.dispose();
      //_locSaveNameController.dispose();
      mapController.dispose();
    } catch (e) {
      print('ERROR disposing of controllers on Nine: $e');
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
}
