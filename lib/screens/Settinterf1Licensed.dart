import 'package:flutter/gestures.dart';

import '../exports_config.dart';

class Settinterf1Licensed extends StatefulWidget {
  @override
  State<Settinterf1Licensed> createState() => _Settinterf1LicensedState();
}

class _Settinterf1LicensedState extends State<Settinterf1Licensed> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {

    // Set up LiveReport
    LiveReport liveReport = LiveReport();
    if (ModalRoute.of(context)?.settings.arguments != null) {
      final LiveReport receivedData = ModalRoute.of(context)?.settings.arguments as LiveReport;
      liveReport = receivedData;
    } else {
      print(Error.noArgsForLiveReport);
    }

    return Scaffold(
      backgroundColor: appBackground,
      appBar: appBarTwoLineWithHome(
        titleText: '${liveReport.interfTypeString}\nLicensed',
        context: context,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Image.asset(liveReport.themeImage),

            // Explanatory text
            Padding(
              padding: outsideButtonAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    text: TextSpan(
                      style: mTStyle,
                      children: [
                        const TextSpan(text: 'Please still document and report licensed sett interference to Badger Trust for their records.',),
                        paraBreakText(),
                        //const TextSpan(text: 'If you have immediate badger welfare concerns, please also contact your local badger group using the link on the home screen.',),
                        const TextSpan(text: 'If you have immediate badger welfare concerns, please also contact your local badger group. See the '),
                        TextSpan(
                          text: 'map of local groups',
                          style: mTLink,
                          recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://www.badgertrust.org.uk/you#comp-krn9h83l'),
                        ),
                        extLinkIcon(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                PillButton(
                  buttonType: PillButtonType.standard,
                  // TODO should probably be a standard material arrow gh#87
                  buttonText: 'OK',
                  pressFunction: () {
                    Navigator.of(context).pushNamed(sMapp, arguments: liveReport);
                  },
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
