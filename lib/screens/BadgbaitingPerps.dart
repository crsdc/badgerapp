/*
options:
    Still at scene          > Nine              dangerous flag
    No longer at scene      > CL B1A            if from rightnow/inthepast
    No longer at scene      > CL B2             if from injuredbadger
*/

import '../exports_config.dart';

class BadgbaitingPerps extends StatefulWidget {
  @override
  State<BadgbaitingPerps> createState() => _BadgbaitingPerpsState();
}

class _BadgbaitingPerpsState extends State<BadgbaitingPerps> {
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
        titleText: 'Badger baiting:\nWitnessed',
        context: context,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(edgePad),
          children: <Widget>[
            const Text(
              'Are the perpetrators still at the scene?',
              style: mTStyle,
            ),
            const SizedBox(height: paraBreak),
            Row(
              children: <Widget>[
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'Yes',
                  pressFunction: () {
                    liveReport.dangerFlag = true;
                    Navigator.of(context).pushNamed(sNine, arguments: liveReport);
                  },
                ),
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'No',
                  pressFunction: () {
                    Navigator.of(context).pushNamed(sChecklist, arguments: liveReport);
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
