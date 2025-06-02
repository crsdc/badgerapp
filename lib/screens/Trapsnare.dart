import '../exports_config.dart';

class Trapsnare extends StatefulWidget {
  @override
  State<Trapsnare> createState() => _TrapsnareState();
}

class _TrapsnareState extends State<Trapsnare> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {

    // Create a new livereport
    LiveReport liveReport = LiveReport.fresh();
    liveReport.activeReport.incidentType = IncidentType.trapssnares;

    return Scaffold(
      backgroundColor: appBackground,
      appBar: appBarOneLineWithHome(
        titleText: 'Traps and snares', // TODO consistency
        context: context,
      ),
      body: Center(
        child: ListView(
          //padding: const EdgeInsets.all(edgePad),
          children: <Widget>[
            // do we want an image here?
            //Image.asset(imgPLACEHOLDER),
            //const SizedBox(height: paraBreak),

            // Explanatory text
            Padding(
              padding: outsideButtonDoubleTop,
              child: Column(
                children: [
                  /*const Text(
                    'Badgers and their setts are protected by the Protection of Badgers Act 1992.',
                    style: bodyText,
                  ),
                  const SizedBox(height: paraBreak),*/
                  RichText(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    text: TextSpan(
                      style: mTStyle,
                      children: [
                        const TextSpan(text: 'Badgers and their setts are protected by the Protection of Badgers Act 1992.'),
                        paraBreakText(),
                        //const TextSpan(text: '\n\n', style: ),
                        const TextSpan(text: 'It\'s an offence to wilfully kill, injure or take a badger or attempt to do so, except under licence '),
                        legLink(Legislation.poba92s1, 1, context),
                        const TextSpan(text: '. Trapping and snaring of badgers may also constitute an offence under the Wildlife and Countryside Act 1981 '),
                        legLink(Legislation.waca81s11, 11, context),
                        const TextSpan(text: '.'),
                        paraBreakText(),
                        const TextSpan(
                          text: 'What have you found?',
                          style: mTBold,
                        ),
                      ],
                    ),
                  ),
                  /*const SizedBox(height: paraBreak),
                  Expanded(
                    child: const Text(
                      'What have you found?',
                      style: bodyTextBold,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: paraBreak),*/
                ],
              )
            ),

            // Menu of buttons, 2 each row
            Row(
              children: [
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight3,
                  buttonText: 'Snare',
                  pressFunction: () {
                    liveReport.activeReport.tsType = TsType.snare;
                    Navigator.of(context).pushNamed(sTrapsnareSnare, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.topleft,
                ),
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight3,
                  buttonText: 'Leghold or\nbodygrip trap',
                  pressFunction: () {
                    liveReport.activeReport.tsType = TsType.legbody;
                    Navigator.of(context).pushNamed(sTrapsnareLeghold, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.topright,
                  softWrap: true,
                ),
              ],
            ),
            Row(
              children: [
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight3,
                  buttonText: 'Cage\ntrap',
                  pressFunction: () {
                    liveReport.activeReport.tsType = TsType.cage;
                    Navigator.of(context).pushNamed(sTrapsnareCage, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.bottomleft,
                ),
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight3,
                  buttonText: 'Other',
                  pressFunction: () {
                    liveReport.activeReport.tsType = TsType.othertrap;
                    Navigator.of(context).pushNamed(sTrapsnareOther, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.bottomright,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
