import 'package:badger/config/colours.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import '../config/sizes.dart';

enum MenuButtonPos {
  left,
  right,
  topleft,
  topright,
  midleft,
  midright,
  bottomleft,
  bottomright,
}

enum MenuButtonType {
  standard,
  highlight,
}

class MenuButton extends StatelessWidget {
  final MenuButtonType buttonType;
  final String buttonText;
  final void Function()? pressFunction;
  final double height;
  final MenuButtonPos? buttonPos; // enum to specify where it fits in a grid
  final bool softWrap;
  //final bool fullWidth;

  const MenuButton({
    Key? key,
    required this.buttonType,
    required this.buttonText,
    required this.pressFunction,
    required this.height,
    this.buttonPos,
    this.softWrap = false,
    //this.fullWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Decide asymmetrical padding around buttons based on grid position enum
    EdgeInsets outerPadding = const EdgeInsets.all(0.0);
    switch(buttonPos) {
      case MenuButtonPos.left:
        outerPadding = const EdgeInsets.fromLTRB(outsideButton, outsideButton, outsideButton / 2, outsideButton);
        break;
      case MenuButtonPos.right:
        outerPadding = const EdgeInsets.fromLTRB(outsideButton / 2, outsideButton, outsideButton, outsideButton);
        break;
      case MenuButtonPos.topleft:
        outerPadding = const EdgeInsets.fromLTRB(outsideButton, outsideButton, outsideButton / 2, outsideButton / 2);
        break;
      case MenuButtonPos.topright:
        outerPadding = const EdgeInsets.fromLTRB(outsideButton / 2, outsideButton, outsideButton, outsideButton / 2);
        break;
      case MenuButtonPos.midleft:
        outerPadding = const EdgeInsets.fromLTRB(outsideButton, outsideButton / 2, outsideButton / 2, outsideButton / 2);
        break;
      case MenuButtonPos.midright:
        outerPadding = const EdgeInsets.fromLTRB(outsideButton / 2, outsideButton / 2, outsideButton, outsideButton / 2);
        break;
      case MenuButtonPos.bottomleft:
        outerPadding = const EdgeInsets.fromLTRB(outsideButton, outsideButton / 2, outsideButton / 2, outsideButton);
        break;
      case MenuButtonPos.bottomright:
        outerPadding = const EdgeInsets.fromLTRB(outsideButton / 2, outsideButton / 2, outsideButton, outsideButton);
        break;
      default:
    }

    Color backgroundColor;
    switch(buttonType) {
      case MenuButtonType.standard:
        backgroundColor = appDB;
        break;
      case MenuButtonType.highlight:
        backgroundColor = crimeRed;
        break;
    }

    return Expanded(
      child: Padding(
        padding: outerPadding,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: height * MediaQuery.of(context).textScaleFactor,
            maxHeight: height * MediaQuery.of(context).textScaleFactor,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              //minimumSize: fullWidth ? const Size.fromHeight(50) : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              textStyle: const TextStyle(fontSize: mTSize),
              foregroundColor: Colors.white,
              backgroundColor: backgroundColor,
            ),
            onPressed: pressFunction,
            child: Padding(
              padding: insideButtonAll,
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      buttonText,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                      softWrap: softWrap,
                      //maxLines: 3, // could specify a max height that corresponds to the buttonHeight, but not needed for now
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
