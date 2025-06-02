import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

// TODO deprecate and replace with a widget that scales in proportion to text size, maybe takes argument that reflects size of text around, and doesn't have hardcoded 10.0
TextSpan paraBreakText () {
  return const TextSpan(
    text: '\n \n',
    style: TextStyle (
      fontSize: 10.0,
    ),
  );
}

// from https://github.com/flutter/flutter/issues/41549
// ONLY USED IN FONT TEST NOW - deprecate
class ScalableTextSpan extends TextSpan {
  const ScalableTextSpan._internal({
    String? text,
    List<InlineSpan>? children,
    TextStyle? style,
    GestureRecognizer? recognizer,
    String? semanticsLabel,
  }) : super(
    style: style,
    text: text,
    children: children,
    recognizer: recognizer,
    semanticsLabel: semanticsLabel,
  );
  factory ScalableTextSpan(
      BuildContext context, {
        String? text,
        List<InlineSpan>? children,
        TextStyle? style,
        GestureRecognizer? recognizer,
        String? semanticsLabel,
      }) {
    double fontSize;
    style = style ?? DefaultTextStyle.of(context).style;
    //The default fontSize is 14.0
    fontSize = style.fontSize ?? 14.0;
    return ScalableTextSpan._internal(
      style: style.copyWith(
          fontSize: fontSize * MediaQuery.of(context).textScaleFactor),
      text: text,
      children: children,
      recognizer: recognizer,
      semanticsLabel: semanticsLabel,
    );
  }
}
