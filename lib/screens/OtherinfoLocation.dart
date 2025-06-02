import '../exports_config.dart';

class OtherinfoLocation extends StatefulWidget {
  @override
  State<OtherinfoLocation> createState() => _OtherinfoLocationState();
}

class _OtherinfoLocationState extends State<OtherinfoLocation> {
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
      appBar: appBarOneLineWithHome(
        // TODO should be conditional and display each incident type
        // we can get here from poison, shootlamp, baiting
        titleText: 'Location',
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
                        const TextSpan(
                          text: 'Does what you want to report relate to a specific geographic location?',
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
                    Navigator.of(context).pushNamed(sMapp, arguments: liveReport);
                  },
                ),
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'No',
                  pressFunction: () {
                    Navigator.of(context).pushNamed(sQuickReport, arguments: liveReport);
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
