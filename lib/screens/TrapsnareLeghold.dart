/*
options:
      Live badger in a trap                   > TrapsnareNeedhelp
      Dead badger in a trap                   > map
      Trap on a badger run or near a sett     > map
*/

import '../exports_config.dart';

class TrapsnareLeghold extends StatefulWidget {
  @override
  State<TrapsnareLeghold> createState() => _TrapsnareLegholdState();
}

class _TrapsnareLegholdState extends State<TrapsnareLeghold> {
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
        titleText: 'Leghold or\nbodygrip traps',
        context: context,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            
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
                        const TextSpan(text: 'Some leghold or bodygrip traps are legal to use in some circumstances, depending on the design and target animal, but never to trap a badger or other mammal listed in Schedule 6 of the Wildlife and Countryside Act 1981 '),
                        legLinkSched(Legislation.waca81sch6, 6, context),
                        const TextSpan(text: '.'),
                        paraBreakText(),
                        const TextSpan(text: 'Fenn traps are legal for use to trap certain species, but they must be placed in a suitable tunnel to exclude non-target species. Setting traps deliberately at badger sett entrances, on badger runs or in close proximity to a sett may constitute a criminal offence, regardless of whether a badger is caught.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: paraBreak),
                  const ImageCaptioned(
                    image: imgTrapFenn,
                    caption: 'Fenn trap',
                  ),
                  const SizedBox(height: paraBreak),
                  RichText(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    text: const TextSpan(
                      style: mTStyle,
                      text: 'Gin traps were completely banned in 1954 and any discovery of such a trap, whether in relation to badgers or not, should be reported to the police.',
                    ),
                  ),
                  const SizedBox(height: paraBreak),
                  const ImageCaptioned(
                    image: imgTrapGin,
                    caption: 'Gin trap',
                  ),
                  const SizedBox(height: paraBreak),
                  RichText(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    text: const TextSpan(
                      style: mTBold,
                      text: 'What have you found?',
                    ),
                  ),
                  const SizedBox(height: paraBreak),
                  ElevatedButton(
                    style: dbButtonFullWidth,
                    onPressed: () {
                      liveReport.activeReport.tsCircs = TsCircs.live;
                      Navigator.of(context).pushNamed(sTrapsnareNeedhelp, arguments: liveReport);
                    },
                    child: const Text('Live badger in a trap'),
                  ),
                  const SizedBox(height: smallBreak),
                  ElevatedButton(
                    style: dbButtonFullWidth,
                    onPressed: () {
                      liveReport.activeReport.tsCircs = TsCircs.dead;
                      Navigator.of(context).pushNamed(sMapp, arguments: liveReport);
                    },
                    child: const Text('Dead badger in a trap'),
                  ),
                  const SizedBox(height: smallBreak),
                  ElevatedButton(
                    style: dbButtonFullWidth,
                    onPressed: () {
                      liveReport.activeReport.tsCircs = TsCircs.onrunsett;
                      Navigator.of(context).pushNamed(sMapp, arguments: liveReport);
                    },
                    child: const Text('Trap on a badger\nrun or near a sett'), // TODO check font sizes and make consistent with other trapsnape screens
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
