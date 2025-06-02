import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:latlong2/latlong.dart';

import '../config/colours.dart';
import '../config/sizes.dart';

Widget w3wNiceDisplay(String w3wDisplay) {
  // Don't display slashes if there's no address to display
  if (w3wDisplay == '') {
    return const SizedBox.shrink();
  } else {
    return Padding(
      padding: const EdgeInsets.fromLTRB(outsideButton, 0.0, outsideButton, outsideButton / 2),
      child: Container(
        padding: const EdgeInsets.fromLTRB(outsideButton, outsideButton / 2, outsideButton, outsideButton / 2),
        color: softBackground,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('///$w3wDisplay',),
            // TODO reinstate
            //Icon(Icons.copy),
          ],
        ),
      ),
    );
  }
}

Widget latLongNiceDisplay(LatLng location) {
  String lat, lng, ewchar = '';

  if (location != LatLng(0.0, 0.0)) {

    // Truncate latitude to 5 decimal places
    lat = location.latitude.toString().substring(0, 8);

    // Strip leading minus if east of 0 degrees
    // and truncate longitude to 5 decimal places
    if (location.longitude < 0.0) {
      lng = location.longitude.toString().substring(1, 8);
      ewchar = 'W';
    } else {
      lng = location.longitude.toString().substring(0, 7);
      ewchar = 'E';
    }

    // Format the string and return a text widget
    // TODO make consistent with w3w
    //return Text('$lat\u{b0} N, $lng\u{b0} $ewchar');
    return Padding(
      padding: const EdgeInsets.fromLTRB(outsideButton, 0.0, outsideButton, outsideButton / 2),
      child: Container(
        padding: const EdgeInsets.fromLTRB(outsideButton, outsideButton / 2, outsideButton, outsideButton / 2),
        color: softBackground,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$lat\u{b0}N $lng\u{b0}$ewchar'),
            // TODO reinstate
            //Icon(Icons.copy),
          ],
        ),
      ),
    );

  } else {
    // Leave blank if pin location not set
    return const SizedBox.shrink();
  }
}
