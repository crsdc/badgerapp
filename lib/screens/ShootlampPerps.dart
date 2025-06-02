import '../exports_config.dart';

class ShootlampPerps extends StatefulWidget {
  @override
  State<ShootlampPerps> createState() => _ShootlampPerpsState();
}

class _ShootlampPerpsState extends State<ShootlampPerps> {
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
        // TODO this is not quite the same if we came from injured badger, title should reflect
        //titleText: 'Shooting or lamping:\nWitnessed',
        titleText: 'Shooting or lamping:\nPerpetrators',
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
                    liveReport.activeReport.perpsStatus = PerpsStatus.atscene;
                    Navigator.of(context).pushNamed(sNine, arguments: liveReport);
                  },
                ),
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'No',
                  pressFunction: () {
                    liveReport.activeReport.perpsStatus = PerpsStatus.gone;
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
