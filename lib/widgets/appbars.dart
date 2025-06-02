import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';

import '../config/colours.dart';
import '../config/routes.dart';
import '../config/textstyles.dart';

PreferredSizeWidget? appBarOneLineWithHome({required String titleText, required BuildContext context, }) {
  return AppBar(
    backgroundColor: appBarColor,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    centerTitle: true,
    title: Text(titleText),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.home),
        onPressed: () {
          // TODO Draft warning needs to come in here
          Navigator.of(context).pushNamedAndRemoveUntil(sHomeScreen, (route) => false);
          //Navigator.of(context).pushNamed(sHomeScreen);
        },
      ),
    ],
  );
}

PreferredSizeWidget? appBarTwoLineWithHome({required String titleText, required BuildContext context}) {
  return AppBar(
    backgroundColor: appBarColor,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    centerTitle: true,
    title: Text(
      titleText,
      style: appBarTwoLine,
      textAlign: TextAlign.center,
    ),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.home),
        onPressed: () {
          // TODO Draft warning needs to come in here
          Navigator.of(context).pushNamedAndRemoveUntil(sHomeScreen, (route) => false);
          //Navigator.of(context).pushNamed(sHomeScreen);
        },
      ),
    ],
  );
}
