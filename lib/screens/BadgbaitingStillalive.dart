/*
options:
    Still alive       > BadgbaitingNeedhelp
    Not still alive   > BadgbaitingPerps
*/

import '../exports_config.dart';

class BadgbaitingStillalive extends StatefulWidget {
  @override
  State<BadgbaitingStillalive> createState() => _BadgbaitingStillaliveState();
}

class _BadgbaitingStillaliveState extends State<BadgbaitingStillalive> {
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
        titleText: 'Badger baiting:\nInjured animal',
        context: context,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(edgePad),
          children: <Widget>[
            const Text(
              'Is the animal still alive?',
              style: mTStyle,
            ),
            const SizedBox(height: paraBreak),
            Row(
              children: <Widget>[
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'Yes',
                  pressFunction: () {
                    Navigator.of(context).pushNamed(sBadgbaitingNeedhelp, arguments: liveReport);
                  },
                ),
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'No',
                  pressFunction: () {
                    Navigator.of(context).pushNamed(sBadgbaitingPerps, arguments: liveReport);
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
