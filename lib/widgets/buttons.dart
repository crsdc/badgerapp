import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import '../config/colours.dart';
import '../config/sizes.dart';

// Deprecated button styles
// TODO rest of the button widgets

final ButtonStyle lbButton = ElevatedButton.styleFrom(
  textStyle: const TextStyle(fontSize: mTSize),
  foregroundColor: Colors.white,
  backgroundColor: appLB,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
);

final ButtonStyle dbButton = ElevatedButton.styleFrom(
  textStyle: const TextStyle(fontSize: mTSize),
  foregroundColor: Colors.white,
  backgroundColor: appDB,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
);

final ButtonStyle dbButtonFullWidth = ElevatedButton.styleFrom(
  minimumSize: const Size.fromHeight(50),
  textStyle: const TextStyle(fontSize: mTSize),
  foregroundColor: Colors.white,
  backgroundColor: appDB,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
);

final ButtonStyle pillButton = ElevatedButton.styleFrom(
  shape: const StadiumBorder(),
  textStyle: const TextStyle(fontSize: mTSize),
  foregroundColor: Colors.white,
  backgroundColor: appDB,
);

final ButtonStyle pillButtonCR = ElevatedButton.styleFrom(
  shape: const StadiumBorder(),
  textStyle: const TextStyle(fontSize: mTSize),
  foregroundColor: Colors.white,
  backgroundColor: crimeRed,
);

final ButtonStyle pillButtonPaler = ElevatedButton.styleFrom(
  shape: const StadiumBorder(),
  textStyle: const TextStyle(fontSize: mTSize),
  foregroundColor: appDB,
  backgroundColor: Colors.white,
);
