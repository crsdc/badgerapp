import 'package:flutter/gestures.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../exports_config.dart';
import 'modal_legislation_contents.dart';

TextSpan legLink (Legislation legRef, int section, BuildContext context) {
  return TextSpan(
    text: '(s.\u{00A0}$section)', // non-breaking space
    style: xsTLegLink,
    recognizer: TapGestureRecognizer()..onTap = () => legislationModal(legRef, context),
  );
}

TextSpan legLinkSched (Legislation legRef, int schedule, BuildContext context) {
  return TextSpan(
    text: '(sch.\u{00A0}$schedule)', // non-breaking space
    style: xsTLegLink,
    recognizer: TapGestureRecognizer()..onTap = () => legislationModal(legRef, context),
  );
}

Widget legislationModal(Legislation legRef, BuildContext context) {
  showMaterialModalBottomSheet(
    //barrierColor: barrierDark,
    context: context,
    backgroundColor: Colors.transparent,
    //enableDrag: false, // not clear what effect this has
    builder: (context) => FloatingModal(
      child: Scrollbar(
        thumbVisibility: true,
        //isAlwaysShown: true,
        thickness: 8.0,
        child: SingleChildScrollView(
          controller: ModalScrollController.of(context),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: legModalContents(context, legRef),
          ),
        ),
      ),
    ),
  );
  return Container();
}

List<Widget> legModalIntro = [
  const SizedBox(height: paraBreak),
  const Icon(
    MdiIcons.scaleBalance,
    size: xxlTSize * 1.5,
    color: appLB,
  ),
  const SizedBox(height: smallBreak),
];

Widget legModalTitle(String titleText) {
  return Text(
    titleText,
    textAlign: TextAlign.center,
    style: lTBold,
  );
}

Widget legModalSubtitle(String subtitleText) {
  return Text(
    subtitleText,
    textAlign: TextAlign.center,
    style: lTBold,
  );
}

Widget legModalAsAmended = const Text(
  'as amended',
  textAlign: TextAlign.center,
  style: xsTItalic,
);

Widget legPara (double indentlevel, String text) {
  return Padding(
    padding: EdgeInsets.only(left: indentlevel),
    child: Text(
      text,
      //textAlign: TextAlign.left,
      style: sTStyle,
    ),
  );
}

List<Widget> legModalOutro (BuildContext context, Legislation legRef) {
  return [
    const SizedBox(height: paraBreak),
    Align(
      alignment: Alignment.centerRight,
      child: RichText(
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        //textAlign: TextAlign.right,
        textWidthBasis: TextWidthBasis.longestLine,
        text: TextSpan(
          text: 'COPY   ',
          style: xsTBoldLink,
          recognizer: TapGestureRecognizer()
            ..onTap = () async => _copyToClipboard(legRef),
        ),
      ),
    ),
    const SizedBox(height: paraBreak),
    const Divider(
      color: appLB,
      height: 25,
      thickness: 2,
    ),
    const SizedBox(height: smallBreak),
    Center(
      child: RichText(
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        text: TextSpan(
          style: xsTStyle,
          children: [
            const TextSpan(text: 'Source: '),
            TextSpan(
              text: 'legislation.gov.uk',
              style: xsTLink,
              recognizer: TapGestureRecognizer()
                ..onTap = () async =>
                    myLaunchUrl(
                        'https://www.legislation.gov.uk/ukpga/1992/51/section/3'),
            ),
            extLinkIcon(),
          ],
        ),
      ),
    ),
    const SizedBox(height: smallBreak),
    const Center(
      child: Text(
        'Verified as of $legVerifiedAsOfDate',
        style: xsTStyle,
      ),
    ),
  ];
}

Future<void> _copyToClipboard(Legislation legRef) async {
  await Clipboard.setData(
      ClipboardData(
          text: legText[legRef]!
      )
  );
  toastCopied();
}
