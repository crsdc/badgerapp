import '../exports_config.dart';

class Shootlamp extends StatefulWidget {
  @override
  State<Shootlamp> createState() => _ShootlampState();
}

class _ShootlampState extends State<Shootlamp> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {

    // Create a new livereport
    LiveReport liveReport = LiveReport.fresh();
    liveReport.activeReport.incidentType = IncidentType.shootlamp;

    return Scaffold(
      backgroundColor: appBackground,
      appBar: appBarOneLineWithHome(
        titleText: 'Shooting or lamping',
        context: context,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Image.asset(imgLamping),

            // Explanatory text
            Padding(
              padding: outsideButtonDoubleTop,
              child: Column(
                children: [
                  RichText(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    text: TextSpan(
                      style: mTStyle,
                      children: [
                        const TextSpan(text: 'Badgers and their setts are protected by the Protection of Badgers Act 1992.'),
                        paraBreakText(),
                        const TextSpan(text: 'It\'s an offence to wilfully kill, injure or take a badger or attempt to do so, except under licence '),
                        legLink(Legislation.poba92s1, 1, context),
                        const TextSpan(text: '. Where shooting is taking place under licence (e.g. licensed badger culling), it is also an offence to use the wrong firearm or ammunition '),
                        legLink(Legislation.poba92s2, 2, context),
                        const TextSpan(text: '.'),
                        paraBreakText(),
                        const TextSpan(text: 'Lamps are sometimes used for hunting or shooting wildlife at night (\'lamping\'). The use of artificial light to spotlight and dazzle a badger is prohibited by the Wildlife and Countryside Act 1981 '),
                        legLink(Legislation.waca81s11, 11, context),
                        const TextSpan(text: ', except under licence. Such a licence, however, would not permit the use of lamps in conjunction with dogs to track down or chase a badger.'),
                        paraBreakText(),
                        const TextSpan(
                          text: 'What would you like to report?',
                          style: mTBold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Menu of buttons, 2 each row
            Row(
              children: [
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight5,
                  buttonText: 'Someone is shooting or lamping badgers right now',
                  pressFunction: () {
                    liveReport.activeReport.slType = SlType.rightnow;
                    Navigator.of(context).pushNamed(sNine, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.topleft,
                  softWrap: true,
                ),
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight5,
                  buttonText: 'I have witnessed badger shooting or lamping',
                  pressFunction: () {
                    liveReport.activeReport.slType = SlType.past;
                    Navigator.of(context).pushNamed(sShootlampPerps, arguments: liveReport);
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
                  height: buttonHeight5,
                  buttonText: 'I have found a badger that may have been shot or lamped',
                  pressFunction: () {
                    liveReport.activeReport.slType = SlType.injured;
                    Navigator.of(context).pushNamed(sShootlampStillalive, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.bottomleft,
                  softWrap: true,
                ),
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight5,
                  buttonText: 'I have other information about badger shooting or lamping',
                  pressFunction: () {
                    liveReport.activeReport.slType = SlType.otherinfo;
                    Navigator.of(context).pushNamed(sOtherinfoLocation, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.bottomright,
                  softWrap: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
