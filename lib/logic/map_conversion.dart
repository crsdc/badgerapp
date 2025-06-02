import 'package:latlong2/latlong.dart';
import 'package:latlong_to_osgrid/latlong_to_osgrid.dart';

class ConversionException implements Exception {
  String errMsg() => 'Couldn\'t convert gibberish input';
}

String latLongToOSNumeric(double lat, double long) {
  LatLongConverter converter = LatLongConverter();
  // Avoid returning extrapolated gibberish outside of reasonable bounds for an OS grid ref
  if (lat < 49.85 || lat > 56 || long < -6.5 || long > 2) {
    return '';
  } else {
    var result = converter.getOSGBfromDec(lat, long);
    //return "${result.easting} ${result.northing}";
    return result.letterRef;
  }
}

LatLng osToLatLong(String input) {
  print('Called converter OS to LatLong');
  LatLongConverter converter = LatLongConverter();
  try {
    LatLong stage = converter.getLatLongFromOSGBLetterRef(input);
    LatLng result = LatLng(stage.lat, stage.long);
    return result;
  } catch(e) {
    print(e);
    print('caught exception above so throw one');
    throw ConversionException();
  }
}
