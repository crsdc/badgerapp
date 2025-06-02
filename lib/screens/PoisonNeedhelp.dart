import '../exports_config.dart';

class PoisonNeedhelp extends StatefulWidget {
  @override
  State<PoisonNeedhelp> createState() => _PoisonNeedhelpState();
}

class _PoisonNeedhelpState extends State<PoisonNeedhelp> {
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
        titleText: 'Poison:\nFound badger',
        context: context,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(edgePad),
          children: <Widget>[
            const Text(
              'Do you need advice on how to get help for the suspected poisoned badger?',
              style: mTStyle,
            ),
            const SizedBox(height: paraBreak),
            Row(
              children: <Widget>[
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'Yes',
                  pressFunction: () {
                    Navigator.of(context).pushNamed(sInjuredbadg, arguments: liveReport);
                  },
                ),
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'No',
                  pressFunction: () {
                    // Shootlamp equivalent of this goes to perps
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
