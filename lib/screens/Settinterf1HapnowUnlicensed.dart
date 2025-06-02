import '../exports_config.dart';

class Settinterf1HapnowUnlicensed extends StatefulWidget {
  @override
  State<Settinterf1HapnowUnlicensed> createState() => _Settinterf1HapnowUnlicensedState();
}

class _Settinterf1HapnowUnlicensedState extends State<Settinterf1HapnowUnlicensed> {
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
        titleText: '${liveReport.interfTypeString}:\nHappening now',
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
                        // TODO explain a bit better that it's illegal, give the user something to go on
                        const TextSpan(text: 'If safe to do so, ask for work to be stopped.'),
                        paraBreakText(),
                        const TextSpan(
                          text: 'Has the work stopped?',
                          style: mTBold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Row of simple yes/no buttons
            Row(
              children: <Widget>[
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'Yes',
                  pressFunction: () {
                    liveReport.activeReport.interfStopped = InterfStopped.stopped;
                    Navigator.of(context).pushNamed(sMapp, arguments: liveReport);
                  },
                ),
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'No',
                  pressFunction: () {
                    liveReport.activeReport.interfStopped = InterfStopped.notstopped;
                    Navigator.of(context).pushNamed(sNine, arguments: liveReport);
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
