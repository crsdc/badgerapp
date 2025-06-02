import '../exports_config.dart';

class ShootlampStillalive extends StatefulWidget {
  @override
  State<ShootlampStillalive> createState() => _ShootlampStillaliveState();
}

class _ShootlampStillaliveState extends State<ShootlampStillalive> {
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
        titleText: 'Shooting or lamping:\nInjured badger',
        context: context,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(edgePad),
          children: <Widget>[
            const Text(
              'Is the badger still alive?',
              style: mTStyle,
            ),
            const SizedBox(height: paraBreak),
            Row(
              children: <Widget>[
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'Yes',
                  pressFunction: () {
                    liveReport.activeReport.bDeadAlive = BDeadAlive.alive;
                    Navigator.of(context).pushNamed(sShootlampNeedhelp, arguments: liveReport);
                  },
                ),
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'No',
                  pressFunction: () {
                    liveReport.activeReport.bDeadAlive = BDeadAlive.dead;
                    Navigator.of(context).pushNamed(sShootlampPerps, arguments: liveReport);
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
