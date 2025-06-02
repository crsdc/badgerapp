import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

import 'colours.dart';
import 'sizes.dart';

// textBlack should be theme dependent?

const TextStyle xlTStyle = TextStyle(
  color: textBlack,
  fontSize: xlTSize,
);


const TextStyle lTStyle = TextStyle(
  color: textBlack,
  fontSize: lTSize,
);
const TextStyle lTBold = TextStyle(
  color: textBlack,
  fontSize: lTSize,
  fontWeight: FontWeight.bold,
);


const TextStyle mTStyle = TextStyle(
  color: textBlack,
  fontSize: mTSize,
);
const TextStyle mTBold = TextStyle(
  color: textBlack,
  fontSize: mTSize,
  fontWeight: FontWeight.bold,
);
const TextStyle mTLink = TextStyle(
  color: hyperlinkColor,
  fontSize: mTSize,
  decoration: TextDecoration.underline,
);


const TextStyle sTStyle = TextStyle(
  color: textBlack,
  fontSize: sTSize,
);
const TextStyle sTBold = TextStyle(
  color: textBlack,
  fontSize: sTSize,
  fontWeight: FontWeight.bold,
);
const TextStyle sTLink = TextStyle(
  color: hyperlinkColor,
  fontSize: sTSize,
  decoration: TextDecoration.underline,
);
const TextStyle sTHighlight = TextStyle(
  color: textBlack,
  fontSize: sTSize,
  backgroundColor: yellowHighlight,
);


const TextStyle xsTStyle = TextStyle(
  color: textBlack,
  fontSize: xsTSize,
);
const TextStyle xsTItalic = TextStyle(
  color: textBlack,
  fontSize: xsTSize,
  fontStyle: FontStyle.italic,
);
const TextStyle xsTLink = TextStyle(
  color: hyperlinkColor,
  fontSize: xsTSize,
  decoration: TextDecoration.underline,
);
const TextStyle xsTLegLink = TextStyle(
  color: hyperlinkColor,
  fontSize: xsTSize,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.underline,
  backgroundColor: legPopupLinkColor,
);
const TextStyle xsTBoldLink = TextStyle(
  color: hyperlinkColor,
  fontSize: xsTSize,
  fontWeight: FontWeight.bold,
);


// TODO make consistent with custom AppBars
const TextStyle appBarTwoLine = TextStyle(
  color: textWhite,
  //color: Colors.deepPurple,// for diagnosing text problem
  fontSize: sTSize,
);
