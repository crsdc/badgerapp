import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:latlong_to_osgrid/latlong_to_osgrid.dart';

import 'map_conversion.dart';

/// State singleton for the map interface
class MapManager {

  // Singleton pattern
  static final MapManager _instance = MapManager._internal();
  factory MapManager() => _instance;

  // Initialization method - what happens if removed?
  MapManager._internal() {
    print('init singleton');
  }

  // Actual location, only set from user input after processing
  LatLng _activeLocation = LatLng(0.0, 0.0);
  String _activeGridref = '';
  //String activeW3w = '';

  // Location formats shown or entered in the UI
  LatLng _pinLocation = LatLng(0.0, 0.0);
  String _gridrefFormText = '';
  String _latlongDisplayed = '';
  //String w3wDisplayed = '';

  // Other UI state
  bool showMylocDisplay = false;
  bool showLatlongDisplay = false;
  bool showW3wDisplay = false;

  // UI notifiers
  final notifierPinLocation = ValueNotifier<LatLng>(LatLng(0.0, 0.0));
  final notifierGridref = ValueNotifier<String>('');
  final notifierLatlong = ValueNotifier<String>('');
  final notifierW3w = ValueNotifier<String>('');
  final notifierShowMylocDisplay = ValueNotifier<bool>(false);
  final notifierShowLatlongDisplay = ValueNotifier<bool>(false);
  final notifierShowW3wDisplay = ValueNotifier<bool>(false);

  LatLng get pinLocation => _pinLocation;

  /// Take a putative grid reference. Validate, normalise, convert to other
  /// formats, then update UI.
  applyGridref(String inputGridref) {
    print('applyGridref was passed $inputGridref');

    // Validate and apply user input grid ref
    final LatLongConverter converter = LatLongConverter();
    bool isInputValid = false;
    try {
      LatLong converted = converter.getLatLongFromOSGBLetterRef(inputGridref);
      _activeLocation = LatLng(converted.lat, converted.long);
      isInputValid = true;
    } catch(e) {
      print('ERROR: Invalid grid ref. $e');
    }

    if(isInputValid) {
      // Normalise user input grid ref by feeding latlong back through converter
      _activeGridref = converter.getOSGBfromDec(_activeLocation.latitude, _activeLocation.longitude).letterRef;

      // sync w3w
      // include a toggle for whetyher to bother with w3w, and how to handle no network for w3w
      // TODO

      // Update UI fields
      _pinLocation = _activeLocation;
      _gridrefFormText = _activeGridref;

      //_latlongDisplayed = '${_activeLocation.latitude.toString().substring(0, 6)}, ${_activeLocation.longitude.toString().substring(0, 6)}';
      // Format latlong for user-friendly display
      String lat, lng, ewchar;
      // Truncate latitude to 5 decimal places
      lat = _activeLocation.latitude.toString().substring(0, 8);
      // Strip leading minus if east of 0 degrees
      // Truncate longitude to 5 decimal places
      if (_activeLocation.longitude < 0.0) {
        lng = _activeLocation.longitude.toString().substring(1, 8);
        ewchar = 'W';
      } else {
        lng = _activeLocation.longitude.toString().substring(0, 7);
        ewchar = 'E';
      }
      _latlongDisplayed = '$lat\u{b0} N, $lng\u{b0} $ewchar';

    } else {
      // TODO show the user an error somehow
    }

    // Notify listeners
    notifierPinLocation.value = _pinLocation;
    notifierGridref.value = _gridrefFormText;
    notifierLatlong.value = _latlongDisplayed;
  }




  /// Take location from a dropped or dragged pin
  /// Convert to other formats, then update UI
  applyPinPlacement() {
    // accessed by tapping to drop a new pin, or dragging an existing one

    // update everything with the new location of the pin

    // convert to grid ref
    // fill in grid ref form field
    // set w3w if active

    /*print('Map tapped at ${tapPosition.global} and we\'ll place a pin');

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
    });*/


  }

//  toggleVisibility

  void saveLocation() {

  }
}
