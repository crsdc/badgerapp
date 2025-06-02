import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

import '../config/sizes.dart';
import '../config/textstyles.dart';

// Bullet points etc
// Thanks to Mjaustro, https://stackoverflow.com/questions/51690067/how-can-i-write-a-paragraph-with-bullet-points-using-flutter/62341566#62341566

class UnorderedList extends StatelessWidget {
  const UnorderedList(this.texts);
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      // Add list item
      widgetList.add(UnorderedListItem(text));
      // Add space between items
      widgetList.add(const SizedBox(height: smallBreak));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  const UnorderedListItem(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          ' \u2002  ',
          style: mTBold,
        ),
        Expanded(
          child: Text(
            text,
            style: mTStyle,
          ),
        ),
      ],
    );
  }
}

// A version of the above that takes TextSpans so we can do rich formatting within bullet points

class UnorderedListRich extends StatelessWidget {
  const UnorderedListRich(this.texts);
  final List<TextSpan> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      // Add list item
      widgetList.add(UnorderedListItemRich(text));
      // Add space between items
      widgetList.add(const SizedBox(height: smallBreak));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListItemRich extends StatelessWidget {
  const UnorderedListItemRich(this.text);
  final TextSpan text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          ' \u2002  ',
          style: mTBold,
        ),
        Expanded(
          child: RichText(text: text),
        ),
      ],
    );
  }
}
