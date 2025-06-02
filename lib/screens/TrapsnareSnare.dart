/*
options:
      Live badger in a snare                  > TrapsnareNeedhelp
      Dead badger in a snare                  > map
      Snare on a badger run or near a sett    > map
*/

import '../exports_config.dart';

class TrapsnareSnare extends StatefulWidget {
  @override
  State<TrapsnareSnare> createState() => _TrapsnareSnareState();
}

class _TrapsnareSnareState extends State<TrapsnareSnare> {
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
        titleText: 'Snares',
        context: context,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            //Image.asset(imgSnareLocking),

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
                        const TextSpan(text:'Snares are legal to use in some circumstances, depending on the design, but never to trap a badger or other animal listed in Schedule 6 of the Wildlife and Countryside Act 1981 '),
                        legLinkSched(Legislation.waca81sch6, 6, context),
                        const TextSpan(text: '.'),
                        paraBreakText(),
                        const TextSpan(text: 'Setting snares deliberately at badger sett entrances, on badger runs or in close proximity to a sett may constitute a criminal offence, regardless of whether a badger is caught.'),
                        paraBreakText(),
                        const TextSpan(text: 'Free-running snares are designed to loosen when the animal stops struggling. Self-locking snares, which continue to tighten around the animal and risk causing serious injury or death, are illegal in all circumstances. It is also illegal to modify free-running snares in such a way that they continuously tighten. Discovery of self-locking snares, whether in relation to badgers or not, should be reported to the police.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: paraBreak),
                  const ImageCaptioned(
                    image: imgSnareTypes,
                    caption: 'Snare types',
                  ),
                  const SizedBox(height: paraBreak),
                  const ImageCaptioned(
                    image: imgSnareLocking,
                    caption: 'Self-locking snare',
                  ),
                  const SizedBox(height: paraBreak),
                  RichText(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    text: const TextSpan(
                      style: mTBold,
                      text:'What have you found?',
                    ),
                  ),
                  const SizedBox(height: paraBreak),
                  ElevatedButton(
                    style: dbButtonFullWidth,
                    onPressed: () {
                      liveReport.activeReport.tsCircs = TsCircs.live;
                      Navigator.of(context).pushNamed(sTrapsnareNeedhelp, arguments: liveReport);
                    },
                    child: const Text('Live badger in a snare'),
                  ),
                  const SizedBox(height: smallBreak),
                  ElevatedButton(
                    style: dbButtonFullWidth,
                    onPressed: () {
                      liveReport.activeReport.tsCircs = TsCircs.dead;
                      Navigator.of(context).pushNamed(sMapp, arguments: liveReport);
                    },
                    child: const Text('Dead badger in a snare'),
                  ),
                  const SizedBox(height: smallBreak),
                  ElevatedButton(
                    style: dbButtonFullWidth,
                    onPressed: () {
                      liveReport.activeReport.tsCircs = TsCircs.onrunsett;
                      Navigator.of(context).pushNamed(sMapp, arguments: liveReport);
                    }, // TODO check font sizes and make consistent with other trapsnape screens
                    child: const Text('Snare on a badger run or near a sett'),
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
