import 'package:flutter/gestures.dart';

import '../exports_config.dart';

class PoisonNearsett extends StatefulWidget {
  @override
  State<PoisonNearsett> createState() => _PoisonNearsettState();
}

class _PoisonNearsettState extends State<PoisonNearsett> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
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
        titleText: 'Poison:\nSuspicious substance',
        context: context,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: outsideButtonDoubleTop,
              child: Column(
                children: [
                  RichText(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    text: TextSpan(
                      style: mTStyle,
                      children: [
                        const TextSpan(text: 'Any suspected poisoning incident must be reported to the Health and Safety Executive on '),
                        TextSpan(
                          text: '0800 321600',
                          style: mTLink,
                          recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('tel:0800321600'),
                        ),
                        const TextSpan(text: ' under their '),
                        TextSpan(
                          text: 'Wildlife Incident Investigation Scheme',
                          style: mTLink,
                          recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://www.hse.gov.uk/pesticides/reducing-environmental-impact/wildlife/wildlife-incident-investigation-scheme.htm'),
                        ),
                        extLinkIcon(),
                        paraBreakText(),
                        const TextSpan(
                          text: 'Is the substance at or very close to a badger sett?',
                          style: mTBold,
                        ),
                        paraBreakText(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Yes/no buttons
            Row(
              children: <Widget>[
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'Yes',
                  pressFunction: () {
                    // Effectively reset report and go down the sett interf route
                    liveReport.activeReport.incidentType = IncidentType.settinterf;
                    liveReport.activeReport.interfType = InterfType.poisoning;
                    Navigator.of(context).pushNamed(sSettinterf2, arguments: liveReport);
                  },
                ),
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'No',
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
