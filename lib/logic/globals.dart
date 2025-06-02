import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

// Global variables, pending a better way of handling state

// Determines visibility of various widgets and other toggles across the app
bool globTestMode = false;

// Location-related
LatLng globUserLocation = LatLng(0.0, 0.0);
bool globLocationServiceEnabled = false;
PermissionStatus globLocationPermissionGranted = PermissionStatus.denied;
