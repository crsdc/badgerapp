/*
options:
      Live badger in a trap                   > TrapsnareNeedhelp
      Dead badger in a trap                   > map
      Trap on a badger run or near a sett     > map
*/

import '../exports_config.dart';

class TrapsnareCage extends StatefulWidget {
  @override
  State<TrapsnareCage> createState() => _TrapsnareCageState();
}

class _TrapsnareCageState extends State<TrapsnareCage> {
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
        titleText: 'Cage traps',
        context: context,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(edgePad),
          children: <Widget>[
            const Text(
              // TODO consistent widgets and then make months bold if outside
              'Cage traps can only legally be used to trap badgers under licence. For example, they are used in licensed badger vaccination programmes (these cages should always be clearly labelled) and for licensed badger culling.',
              style: mTStyle,
            ),
            const SizedBox(height: paraBreak),
            const Text(
              'Licenses for cage-trapping are normally only issued for the months of June to November, for culling. Trapping of badgers in the field to enable vaccination is only permitted between 1 May and 30 November inclusive in England, and between 1 May and 31 December inclusive in Wales. Traps may start to appear in the environment a few weeks before. Traps are not allowed to be placed on top of spoil heaps, dug into sett entrances or obstruct access to the sett.',
              style: mTStyle,
            ),
            const SizedBox(height: paraBreak),
            const ImageCaptioned(
              image: imgTrapCage,
              caption: 'Badger cage trap',
            ),
            const SizedBox(height: paraBreak),
            const Text(
              'Cages used to trap badgers are usually baited with peanuts, although other bait is sometimes used.',
              style: mTStyle,
            ),
            const SizedBox(height: paraBreak),
            const ImageCaptioned(
              image: imgPeanuts,
              caption: 'Peanut bait',
            ),
            const SizedBox(height: paraBreak),
            const Text(
              'Occasionally, badgers are caught in cage traps designed for foxes, stray cats or other mammals.',
              style: mTStyle,
            ),
            const SizedBox(height: paraBreak),
            const Text(
              'Cage traps are sometimes used illegally without a licence, including by badger baiters.',
              style: mTStyle,
            ),
            const SizedBox(height: paraBreak),
            const Text(
              'Setting any trap deliberately at badger sett entrances, on badger runs or in close proximity to a sett may constitute a criminal offence, regardless of whether a badger has been caught, unless it is done under licence.',
              style: mTStyle,
            ),
            const SizedBox(height: paraBreak),
            const Text(
              'Note: Do not report cage traps used for licensed vaccination or licensed badger culling.',
              style: mTStyle,
            ),
            const SizedBox(height: paraBreak),
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
