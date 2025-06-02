import 'dart:async';

import 'package:intl/intl.dart';
import 'package:latlong_to_osgrid/latlong_to_osgrid.dart';
import 'package:location/location.dart';

import '../exports_config.dart';

// TODO landscapify this screen gh#28
// https://medium.com/flutter-community/controlling-screen-orientation-in-flutter-apps-on-a-per-screen-basis-d637702f9368

// TODO monospace font for iOS so the screen doesn't jump around
// TODO individual char boxes evenly spaced to allow non-monospace font gh#88

class LocationDisplay extends StatefulWidget {
  @override
  State<LocationDisplay> createState() => _LocationDisplayState();
}

class _LocationDisplayState extends State<LocationDisplay> {

  Location locationObject = Location();
  LatLongConverter converter = LatLongConverter();

  // may not need these
  double latitude = 0.0;
  double longitude = 0.0;

  String osGridRef = '';
  String osGridRefLetters = '';
  String osGridRefEastings = '';
  String osGridRefNorthings = '';
  String dayString = '';
  String dateString = '';
  String timeString = '';
  String latDisplay = '';
  String longDisplay = '';
  String coordDisplay = '';

  late StreamSubscription<LocationData> locationSubscription;

  String locationStatusNotice() {
    if (
    globLocationServiceEnabled &&
        (globLocationPermissionGranted == PermissionStatus.granted
            || globLocationPermissionGranted == PermissionStatus.grantedLimited)
    ) {
      return 'Waiting for GPS...';
    } else if (!globLocationServiceEnabled) {
      return 'Please enable location services';
    } else if (!(globLocationPermissionGranted == PermissionStatus.granted
        || globLocationPermissionGranted == PermissionStatus.grantedLimited)) {
      return 'Please grant location permission';
    } else {
      print('ERROR: unexpected combination of location service flags');
      return 'ERROR';
    }
  }


  @override
  void initState() {
    super.initState();

    // Show the time straight away, then refresh it every second
    _getTime();
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());

    // Got through location permission and service enabled steps
    locateMe(locationObject);

    print('init!');
    print(globLocationServiceEnabled);
    print(globLocationPermissionGranted);

    coordDisplay = locationStatusNotice();
    
    /*if (
      locationServiceEnabled &&
        (locationPermissionGranted == PermissionStatus.granted
        || locationPermissionGranted == PermissionStatus.grantedLimited)
    ) {
      coordDisplay = 'Waiting for GPS...';
    } else if (!locationServiceEnabled) {
      coordDisplay = 'Please enable location services';
    } else if (!(locationPermissionGranted == PermissionStatus.granted
               || locationPermissionGranted == PermissionStatus.grantedLimited)) {
      coordDisplay = 'Please grant location permission';
    } else {
      coordDisplay = 'ERROR';
    }*/

    locationSubscription = locationObject.onLocationChanged.listen((LocationData currentLocation)
    {
      print('Running the onLocationChanged code');
      print(currentLocation);
      // If we're not getting a real location from the phone, set our coords to 0,0 and then test for those values to show waiting message
      latitude = currentLocation.latitude ?? 0.0;
      longitude = currentLocation.longitude ?? 0.0;
      if ((latitude != 0.0) && (longitude != 0.0) && mounted) {
        latDisplay = latitude.toStringAsFixed(5).replaceAllMapped(
            RegExp(r'-'), (match) => '\u{2212}');
        longDisplay = longitude.toStringAsFixed(5).replaceAllMapped(
            RegExp(r'-'), (match) => '\u{2212}');
        setState(() {
          print('onLocationChanged is setting state with nonzero coords');
          // TODO test for weird values here, e.g. out of scope for OS gh#88
          osGridRef = latLongToOSNumeric(latitude, longitude);
          // Print each char with a hair space in between for better clarity if camera capture ends up blurry
          osGridRefLetters = '${osGridRef[0]}\u{200A}${osGridRef[1]}';
          osGridRefEastings =
          '${osGridRef[3]}\u{200A}${osGridRef[4]}\u{200A}${osGridRef[5]}\u{200A}${osGridRef[6]}\u{200A}${osGridRef[7]}';
          osGridRefNorthings =
          '${osGridRef[9]}\u{200A}${osGridRef[10]}\u{200A}${osGridRef[11]}\u{200A}${osGridRef[12]}\u{200A}${osGridRef[13]}';
          // Round displayed lat and long to 5 decimal places (+/- ~1m) to avoid false precision and busy screen that jumps if last decimal place changes to/from 0
          // Also do string substitution of ugly hyphen minus for proper unicode minus
          coordDisplay = 'Lat & Long: $latDisplay, $longDisplay';
        });
      } else if (mounted) {
        setState(() {
          print(
              'onLocationChanged is setting state to say we are waiting for fix');
          coordDisplay = 'Waiting for fix...'; // TODO this isn't showing - we probably don't even get to the if unless location changes, and if it does then we have a non-null result
        });
      }
      print('Lat: $latitude   Long: $longitude   Gridref: $osGridRef');
    });

    // If we've can get a location, listen for changes to it


      /*locationSubscription = locationObject
          .onLocationChanged
          .listen((LocationData currentLocation) async {
        setState(() {
          print('WOW SETSTATE 1');
        });
      });*/

      /*locationObject.onLocationChanged.listen((res) {
        print('Running the onLocationChanged code');
        // If we're not getting a real location from the phone, set our coords to 0,0 and then test for those values to show waiting message
        latitude = res.latitude ?? 0;
        longitude = res.longitude ?? 0;
        if ((latitude != 0) && (longitude != 0) && mounted) {
          latDisplay = latitude.toStringAsFixed(5).replaceAllMapped(
              RegExp(r'-'), (match) => '\u{2212}');
          longDisplay = longitude.toStringAsFixed(5).replaceAllMapped(
              RegExp(r'-'), (match) => '\u{2212}');
          setState(() {
            print('onLocationChanged is setting state with nonzero coords');
            // TODO test for weird values here, e.g. out of scope for OS
            osGridRef = latLongToOSNumeric(latitude, longitude);
            // Print each char with a hair space in between for better clarity if camera capture ends up blurry
            osGridRefLetters = '${osGridRef[0]}\u{200A}${osGridRef[1]}';
            osGridRefEastings =
            '${osGridRef[3]}\u{200A}${osGridRef[4]}\u{200A}${osGridRef[5]}\u{200A}${osGridRef[6]}\u{200A}${osGridRef[7]}';
            osGridRefNorthings =
            '${osGridRef[9]}\u{200A}${osGridRef[10]}\u{200A}${osGridRef[11]}\u{200A}${osGridRef[12]}\u{200A}${osGridRef[13]}';
            // Round displayed lat and long to 5 decimal places (+/- ~1m) to avoid false precision and busy screen that jumps if last decimal place changes to/from 0
            // Also do string substitution of ugly hyphen minus for proper unicode minus
            coordDisplay = 'Lat & Long: $latDisplay, $longDisplay';
          });
        } else if (mounted) {
          setState(() {
            print(
                'onLocationChanged is setting state to say we are waiting for fix');
            coordDisplay = 'Waiting for fix...'; // TODO this isn't showing
          });
        }
        print('Lat: $latitude   Long: $longitude   Gridref: $osGridRef');
      });*/

  }



  // these are now global
  //bool locationServiceEnabled = false;
  //PermissionStatus locationPermissionGranted = PermissionStatus.denied;


  /*void _locateMe() async {
    print('_locateMe() async begun');
    print('Calling serviceEnabled()');
    locationServiceEnabled = await locationObject.serviceEnabled();
    print('_serviceEnabled = $locationServiceEnabled');
    if (!locationServiceEnabled) {
      print('Calling requestService()');
      locationServiceEnabled = await locationObject.requestService();
      print('requestService() done');
      if (!locationServiceEnabled) {
        print('_serviceEnabled still not enabled');
        return;
      }
    }
    print('On to permission section');
    locationPermissionGranted = await locationObject.hasPermission();
    print('_permissionGranted = $locationPermissionGranted');
    if (locationPermissionGranted == PermissionStatus.denied) {
      print('_permissionGranted is DENIED');
      print('Requesting permission');
      locationPermissionGranted = await locationObject.requestPermission();
      print('_permissionGranted = $locationPermissionGranted');
      if (locationPermissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    print('serviceEnabled() and the permission section have both run. Now get location.');
    LocationData locationData = await locationObject.getLocation();
    print('INITIAL Longitude: ${locationData.longitude}');
    print('On to continuous updates section');

    // Continuously update location
    // fixme replace with a stream??? https://stackoverflow.com/questions/58077953/flutter-location-plugin-stop-listining-on-dispose
    locationObject.onLocationChanged.listen((res) {
      print('Running the onLocationChanged code');
      // If we're not getting a real location from the phone, set our coords to 0,0 and then test for those values to show waiting message
      latitude = res.latitude ?? 0;
      longitude = res.longitude ?? 0;
      if ((latitude != 0) && (longitude != 0) && mounted) {
        latDisplay = latitude.toStringAsFixed(5).replaceAllMapped(
          RegExp(r'-'), (match) => '\u{2212}');
        longDisplay = longitude.toStringAsFixed(5).replaceAllMapped(
          RegExp(r'-'), (match) => '\u{2212}');
        setState(() {
          print('onLocationChanged is setting state with nonzero coords');
          // TODO test for weird values here, e.g. out of scope for OS
          osGridRef = latLongToOSNumeric(latitude, longitude);
          // Print each char with a hair space in between for better clarity if camera capture ends up blurry
          osGridRefLetters = '${osGridRef[0]}\u{200A}${osGridRef[1]}';
          osGridRefEastings = '${osGridRef[3]}\u{200A}${osGridRef[4]}\u{200A}${osGridRef[5]}\u{200A}${osGridRef[6]}\u{200A}${osGridRef[7]}';
          osGridRefNorthings = '${osGridRef[9]}\u{200A}${osGridRef[10]}\u{200A}${osGridRef[11]}\u{200A}${osGridRef[12]}\u{200A}${osGridRef[13]}';
          // Round displayed lat and long to 5 decimal places (+/- ~1m) to avoid false precision and busy screen that jumps if last decimal place changes to/from 0
          // Also do string substitution of ugly hyphen minus for proper unicode minus
          coordDisplay = 'Lat & Long: $latDisplay, $longDisplay';
        });
      } else if (mounted) {
        setState(() {
          print('onLocationChanged is setting state to say we are waiting for fix');
          coordDisplay = 'Waiting for fix...'; // TODO this isn't showing
        });
      }
      print('Lat: $latitude   Long: $longitude   Gridref: $osGridRef');*/

      /*
      setState(() {
        print('onLocationChanged is setting state');
        // If we're not getting a real location from the phone, set our coords to 0,0 and then test for those values to show waiting message
        latitude = res.latitude ?? 0;
        longitude = res.longitude ?? 0;
        if ((latitude != 0) && (longitude != 0)) {

            // TODO test for weird values here, e.g. out of scope for OS
            osGridRef = latLongToOSNumeric(latitude, longitude);
            // Round displayed lat and long to 5 decimal places (+/- ~1m) to avoid false precision and busy screen that jumps if last decimal place changes to/from 0
            // Also do string substitution of ugly hyphen minus for proper unicode minus
            latDisplay = latitude.toStringAsFixed(5).replaceAllMapped(
                RegExp(r'-'), (match) => '\u{2212}');
            longDisplay = longitude.toStringAsFixed(5).replaceAllMapped(
                RegExp(r'-'), (match) => '\u{2212}');
            coordDisplay = latDisplay + ', ' + longDisplay;
          })
        } else {
          coordDisplay = "Waiting for fix...";
        }
        print('Lat: $latitude   Long: $longitude   Gridref: $osGridRef');
      });*/
/*    });
  }*/

  String latLongToOSNumeric(double lat, double long) {
    OSRef result = converter.getOSGBfromDec(lat, long);
    return result.letterRef;
  }

  void _getTime() {
    //final String formattedDate = DateFormat('EEEE d MMMM y').format(DateTime.now()).toString();
    //final String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now()).toString();
    if (mounted) {
      setState(() {
        dayString = DateFormat('EEEE').format(DateTime.now()).toString();
        ///dateString = '29' + DateFormat('MMM y').format(DateTime.now()).toString();
        dateString = DateFormat('d MMM y').format(DateTime.now()).toString();
        timeString = DateFormat('HH:mm:ss').format(DateTime.now()).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.black),
          child: Column(
            // Vertically center the widget inside the column
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Your current GPS location',
                style: TextStyle (color: Colors.white, fontSize: 28.0),
                ),
              const SizedBox(height: 10),
              Text(
                // Print each char with a hair space in between for better clarity if camera capture ends up blurry
                ///'T\u{200A}Q',
                osGridRefLetters,
                style: const TextStyle (color: Colors.white, fontSize: 85.0),
              ),
              Text(
                ///'3\u{200A}0\u{200A}0\u{200A}4\u{200A}1',
                osGridRefEastings,
                style: const TextStyle (color: Colors.white, fontSize: 85.0),
              ),
              Text(
                ///'7\u{200A}9\u{200A}9\u{200A}7\u{200A}8',
                osGridRefNorthings,
                style: const TextStyle (color: Colors.white, fontSize: 85.0),
              ),
              const SizedBox(height: 10),
              Text(
                ///'Lat & Long: 51.50378, \u{2212}0.12778',
                coordDisplay,
                style: TextStyle (color: Colors.grey[400], fontStyle: FontStyle.italic, fontSize: 20.0),
              ),
              const SizedBox(height: 50),
              Text(
                dayString,
                style: const TextStyle (color: Colors.white, fontSize: 28.0),
              ),
              Text(
                dateString,
                //'33 Sep 2222',
                style: const TextStyle (color: Colors.white, fontSize: 55.0),
              ),
              const SizedBox(height: 10),
              Text(
                timeString,
                style: const TextStyle (color: Colors.white, fontSize: 72.0, fontWeight: FontWeight.w400, fontFamily: 'RobotoMono'),
              ),
              /*ElevatedButton(
                child: Text("Locate"),
                onPressed: () {
                  print('Locate button pressed');
                  _locateMe();
                },
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  // TODO need a dispose method, but depends on sorting out the stream listener above
  @override
  void dispose() {
    print('DISPOSE LocationDisplay');
    // Stop listening to location when we move away from the screen
    locationSubscription.cancel();
    //locationObject.onLocationChanged.listen((_){}).cancel();
    //location.onLocationChanged.close();
    super.dispose();
  }
}

/*
class LocationData {
  final double latitude; // Latitude, in degrees
  final double longitude; // Longitude, in degrees
  final double accuracy; // Estimated horizontal accuracy of this location, radial, in meters
  final double altitude; // In meters above the WGS 84 reference ellipsoid
  final double speed; // In meters/second
  final double speedAccuracy; // In meters/second, always 0 on iOS
  final double heading; // Heading is the horizontal direction of travel of this device, in degrees
  final double time; // timestamp of the LocationData
  final bool isMock; // Is the location currently mocked
}

enum LocationAccuracy {
  powerSave, // To request best accuracy possible with zero additional power consumption,
  low, // To request "city" level accuracy
  balanced, // To request "block" level accuracy
  high, // To request the most accurate locations available
  navigation // To request location for navigation usage (affect only iOS)
}

// Status of a permission request to use location services.
enum PermissionStatus {
  /// The permission to use location services has been granted.
  granted,
  // The permission to use location services has been denied by the user. May have been denied forever on iOS.
  denied,
  // The permission to use location services has been denied forever by the user. No dialog will be displayed on permission request.
  deniedForever
}

*/
