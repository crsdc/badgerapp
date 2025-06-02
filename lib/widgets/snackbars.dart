import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import '../config/colours.dart';
import '../config/errors.dart';
import '../config/sizes.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> savedSnackBar (BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        'Your settings have been saved',
        style: TextStyle(
          fontSize: mTSize, // TODO test whether needed
          color: Colors.white,
        ),
      ),
      backgroundColor: crimeRed,
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> disabledSnackBar (BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Temporarily disabled')
    )
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> errorSnackBar (BuildContext context, String errMsg) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${errMsg.substring(0, 10)} ${Error.userMessageTellDev}'),
    )
  );
}
