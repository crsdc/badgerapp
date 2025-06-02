import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import '../config/colours.dart';
import '../config/sizes.dart';

enum PillButtonType {
  standard,
  highlight,
  deemphasised,
}

class PillButton extends StatelessWidget {
  final PillButtonType buttonType; // enum to specify style
  final String buttonText;
  final void Function()? pressFunction;

  const PillButton({
    Key? key,
    required this.buttonType,
    required this.buttonText,
    this.pressFunction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color foregroundColor;
    Color backgroundColor;

    switch (buttonType) {
      case PillButtonType.standard:
        foregroundColor = Colors.white;
        backgroundColor = appDB;
        break;
      case PillButtonType.highlight:
        foregroundColor = Colors.white;
        backgroundColor = crimeRed;
        break;
      case PillButtonType.deemphasised:
        foregroundColor = appDB;
        backgroundColor = Colors.white;
        break;
    }

    return Expanded(
      child: Center(
        child: Padding(
          padding: outsideButtonAll,
          child: SizedBox(
            height: 50,
            width: 130,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                textStyle: const TextStyle(fontSize: mTSize),
                foregroundColor: foregroundColor,
                backgroundColor: backgroundColor,
              ),
              onPressed: pressFunction,
              child: Padding(
                padding: insideButtonAll,
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
