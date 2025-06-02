import '../exports_config.dart';

class Settinterf1HappeningWhatLicence extends StatefulWidget {
  @override
  State<Settinterf1HappeningWhatLicence> createState() => _Settinterf1HappeningWhatLicenceState();
}

class _Settinterf1HappeningWhatLicenceState extends State<Settinterf1HappeningWhatLicence> {
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
    String happeningString = '';
    if (liveReport.activeReport.interfHappening == InterfHappening.hapnow) {
      happeningString = 'Happening now';
    } else if (liveReport.activeReport.interfHappening == InterfHappening.nothapnow) {
      happeningString = 'Not happening now';
    } else {
      happeningString = '${Error.interfHappeningNotPassed.substring(0, 10)} ${Error.userMessageTellDev}';
      print(Error.interfHappeningNotPassed);
    }

    return Scaffold(
      backgroundColor: appBackground,
      appBar: appBarTwoLineWithHome(
        titleText: '${liveReport.interfTypeString}:\n$happeningString',
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

                  // Different wording about who to speak to for the different interfTypes
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.forestry,
                    child: const Text(
                      'If safe to do so, speak with workers, a site manager or the landowner to find out if a licence was obtained to carry out this work.',
                      style: mTStyle,
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.farming,
                    child: const Text(
                      'If safe to do so, speak with the farmer or landowner to find out if a licence was obtained to carry out this work.',
                      style: mTStyle,
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.development,
                    child: const Text(
                      'If safe to do so, speak with the site manager or landowner to find out if planning permission is in place for this location, an ecological survey was carried out, and a licence was obtained from the relevant licensing body.',
                      style: mTStyle,
                    ),
                  ),

                  // Displayed on all versions
                  RichText(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    text: const TextSpan(
                      style: mTStyle,
                      children: [
                        TextSpan(
                          text: '\nWhat is the licensing status of the work being undertaken?',
                          style: mTBold,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),

            // TODO row buttons, are they consistent? gh#87
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(outsideButton),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: buttonHeight1),
                      child: ElevatedButton(
                        style: dbButton,
                        onPressed: () {
                          liveReport.activeReport.interfLicensed = InterfLicensed.licensed;
                          Navigator.of(context).pushNamed(sSettinterf1Licensed, arguments: liveReport);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(insideButton),
                          child: Text(
                            'Licensed',
                            textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(outsideButton),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: buttonHeight1),
                      child: ElevatedButton(
                        style: dbButton,
                        onPressed: () {
                          liveReport.activeReport.interfLicensed = InterfLicensed.unlicensed;
                          if (liveReport.activeReport.interfHappening == InterfHappening.hapnow) {
                            Navigator.of(context).pushNamed(sSettinterf1HapnowUnlicensed, arguments: liveReport);
                          } else if (liveReport.activeReport.interfHappening == InterfHappening.nothapnow) {
                            Navigator.of(context).pushNamed(sMapp, arguments: liveReport);
                          } else {
                            print(Error.interfHappeningNotPassed);
                            errorSnackBar(context, Error.interfHappeningNotPassed);
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(insideButton),
                          child: Text(
                            'Unlicensed or unable to confirm',
                            textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
             children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(outsideButton),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: buttonHeight1),
                      child: ElevatedButton(
                        style: dbButton,
                        onPressed: () {
                          liveReport.activeReport.interfLicensed = InterfLicensed.noncompliant;
                          if (liveReport.activeReport.interfHappening == InterfHappening.hapnow) {
                            Navigator.of(context).pushNamed(sSettinterf1HapnowUnlicensed, arguments: liveReport);
                          } else if (liveReport.activeReport.interfHappening == InterfHappening.nothapnow) {
                            Navigator.of(context).pushNamed(sMapp, arguments: liveReport);
                          } else {
                            print(Error.interfHappeningNotPassed);
                            errorSnackBar(context, Error.interfHappeningNotPassed);
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(insideButton),
                          child: Text(
                            'Licensed but non-compliant',
                            textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
