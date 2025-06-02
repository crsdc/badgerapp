import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'globals.dart';


void locateMe(Location locationObject) async {
  print('locateMe() called and prior location was ${globUserLocation.latitude}, ${globUserLocation.longitude}');

  print('locateMe() 1. Check whether service is enabled');
  globLocationServiceEnabled = await locationObject.serviceEnabled();
  print('locateMe() locationserviceEnabled = $globLocationServiceEnabled');
  if (!globLocationServiceEnabled) {
    print('locateMe() So now we will requestService()');
    globLocationServiceEnabled = await locationObject.requestService();
    // TODO why is it asking twice?
    print('locateMe() requestService() done');
    if (!globLocationServiceEnabled) {
      print('locateMe() Still NO after requesting so GIVE UP trying to enable location service');
      return;
    }
  }

  print('locateMe() 2. Check whether we have location permission');
  globLocationPermissionGranted = await locationObject.hasPermission();
  print('locateMe() $globLocationPermissionGranted');
  if (globLocationPermissionGranted == PermissionStatus.denied) {
    print('locateMe() So now we will requestPermission()');
    globLocationPermissionGranted = await locationObject.requestPermission();
    print('locateMe() requestPermission() done');
    if (globLocationPermissionGranted != PermissionStatus.granted) {
      print('locateMe() Still NO after requesting so GIVE UP trying to obtain location permission');
      return;
    }
  }

  print('locateMe() 3. We have both location service and permission');
  LocationData locationData = await locationObject.getLocation();
  print('locateMe() LOCATION IS ${locationData.latitude}, ${locationData.longitude}');
  globUserLocation = LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
  return;
}
