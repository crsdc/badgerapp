/*
options:
      Live badger in a trap                   > TrapsnareNeedhelp
      Dead badger in a trap                   > map
      Trap on a badger run or near a sett     > map
*/

import '../exports_config.dart';

class TrapsnareOther extends StatefulWidget {
  @override
  State<TrapsnareOther> createState() => _TrapsnareOtherState();
}

class _TrapsnareOtherState extends State<TrapsnareOther> {
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
        titleText: 'Traps or snares:\nOther traps',
        context: context,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(edgePad),
          children: <Widget>[
            const Text(
              'What have you found?',
              style: mTBold,
            ),
            const SizedBox(height: paraBreak),
            ElevatedButton(
              style: dbButton,
              onPressed: () {
                liveReport.activeReport.tsCircs = TsCircs.live;
                Navigator.of(context).pushNamed(sTrapsnareNeedhelp, arguments: liveReport);
              },
              child: const Text('Live badger in a trap'),
            ),
            const SizedBox(height: smallBreak),
            ElevatedButton(
              style: dbButton,
              onPressed: () {
                liveReport.activeReport.tsCircs = TsCircs.dead;
                Navigator.of(context).pushNamed(sMapp, arguments: liveReport);
              },
              child: const Text('Dead badger in a trap'),
            ),
            const SizedBox(height: smallBreak),
            ElevatedButton(
              style: dbButton,
              onPressed: () {
                liveReport.activeReport.tsCircs = TsCircs.onrunsett;
                Navigator.of(context).pushNamed(sMapp, arguments: liveReport);
              },
              child: const Text('Trap on a badger run or near a sett'),
            ),
          ],
        ),
      ),
    );
  }
}
