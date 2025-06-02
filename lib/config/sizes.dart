import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

// Text
const double xxlTSize = 30.0; // was title
const double xlTSize =  20.0; // was heading, 22
const double lTSize =   18.0; // was bigger, 20
const double mTSize =   16.0; // was body, 18
const double sTSize =   14.0; // was compact, 16
const double xsTSize =  12.0; // was smaller, 14
const double xxsTSize =  8.0; // used for small print, e.g. map attribution text

// Padding
const double edgePad = 8.0;
const double insideButton = 6.0;
const double outsideButton = 10.0;
const outsideButtonDoubleTop = EdgeInsets.fromLTRB(outsideButton, outsideButton * 2, outsideButton, outsideButton);
//const outsideButtonNoTop = EdgeInsets.fromLTRB(outsideButton, 0.0, outsideButton, outsideButton); // not used
const outsideButtonAll = EdgeInsets.all(outsideButton);
const insideButtonAll = EdgeInsets.all(insideButton);

// Button height for block buttons - TODO might need revising
const double buttonHeight1 = mTSize * 2 + 3.0;
const double buttonHeight2 = mTSize * 3 + 3.0;
const double buttonHeight3 = mTSize * 4 + 3.0;
const double buttonHeight4 = mTSize * 5 + 3.0; // not used yet
const double buttonHeight5 = mTSize * 6.5 + 3.0; // TODO check w different system-set font scaling factors gh#24

// Text spacers - TODO might need replacing
const double smallBreak = 5.0;
const double paraBreak = 14.0;

// Text indents for legislation popups
const double legIndent1 = 10.0;
const double legIndent2 = 20.0;
const double legIndent3 = 30.0;
