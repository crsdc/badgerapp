/*
options:
    right now               > Nine                      dangerous flag
    in the past             > BadgbaitingPerps
    injured badger          > BadgbaitingStillalive
    sett interfered with    > Settinterf
    photos/videos           > QuickReport
    other info              > QuickReport
*/

import '../exports_config.dart';

class Badgbaiting extends StatefulWidget {
  @override
  State<Badgbaiting> createState() => _BadgbaitingState();
}

class _BadgbaitingState extends State<Badgbaiting> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {

    // Create a new LiveReport
    LiveReport liveReport = LiveReport.fresh();
    liveReport.activeReport.incidentType = IncidentType.baiting;
    print(liveReport);

    return Scaffold(
      backgroundColor: appBackground,
      appBar: appBarOneLineWithHome(
        titleText: 'Badger baiting',
        context: context,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Image.asset(imgBaiting),

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
                        const TextSpan(text: 'Badger baiting is a cruel bloodsport in which badgers and dogs are made to fight. It usually results in the death of the badger, as well as causing horrific injuries to the dogs.',),
                        paraBreakText(),
                        const TextSpan(text: 'Dogs commonly used include Patterdale terriers, Staffordshire bull terriers, and bull terrier\u2013lurcher crossbreeds.',),
                        paraBreakText(),
                        const TextSpan(text: 'Badger setts are protected under the Protection of Badgers Act 1992. It\'s an offence to wilfully kill, injure or take a badger, or attempt to do so '),
                        legLink(Legislation.poba92s1, 1, context),
                        const TextSpan(text: '. It is also an offence to dig for a badger or to cruelly ill-treat a badger '),
                        legLink(Legislation.poba92s2, 2, context),
                        const TextSpan(text: '.'),
                        paraBreakText(),
                        const TextSpan(text: 'Badger baiting often takes place at or near a badger sett. It is an offence to intentionally or recklessly interfere with a badger sett or to knowingly cause or permit a badger sett to be interfered with, including by obstructing the sett, digging into it, or entering a dog into the sett '),
                        legLink(Legislation.poba92s3, 3, context),
                        const TextSpan(text: '. It is also an offence to disturb a badger while it is occupying its sett '),
                        legLink(Legislation.poba92s3, 3, context),
                        const TextSpan(text: '.'),
                        paraBreakText(),
                        const TextSpan(text: 'Some badger baiters create artificial setts to hold a badger prior to fighting. Badgers are held captive and traded on the black market for the purpose of fighting. This may constitute an offence under the Protection of Badgers Act 1992 '),
                        legLink(Legislation.poba92s4, 4, context),
                        const TextSpan(text: '.'),
                        paraBreakText(),
                        const TextSpan(text: 'Badger baiting may also involve offences under the Animal Welfare Act 2006 of causing unnecessary suffering '),
                        legLink(Legislation.awa06s4, 4, context),
                        const TextSpan(text: ' or fighting '),
                        legLink(Legislation.awa06s8, 8, context),
                        const TextSpan(text: ', which also applies to keeping or training animals for fighting, and permitting, publicising, profiting from or betting on an animal fight. It also prohibits supplying, publishing or showing another a video recording of an animal fight.'),
                        paraBreakText(),
                        const TextSpan(
                          text: 'What would you like to report?',
                          style: mTBold,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),

            // Menu of buttons, 2 each row
            Row(
              children: [
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight5,
                  buttonText: 'I am witnessing badger baiting right now',
                  pressFunction: () {
                    print('ooooo 1');
                    liveReport.dangerFlag = true;
                    print('ooooo 2');
                    liveReport.activeReport.bbType = BbType.rightnow;
                    print('ooooo 3');
                    Navigator.of(context).pushNamed(sNine, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.topleft,
                  softWrap: true,
                ),
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight5,
                  buttonText: 'I have witnessed badger baiting',
                  pressFunction: () {
                    liveReport.activeReport.bbType = BbType.past;
                    Navigator.of(context).pushNamed(sBadgbaitingPerps, arguments: liveReport);
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
                  buttonText: 'I have found a badger or dog with injuries consistent with fighting',
                  pressFunction: () {
                    liveReport.activeReport.bbType = BbType.injured;
                    Navigator.of(context).pushNamed(sBadgbaitingStillalive, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.midleft,
                  softWrap: true,
                ),
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight5,
                  buttonText: 'I have found a badger sett that has been interfered with',
                  // Currently this starts the livereport again
                  // TODO should this go straight to badger diggers rather than ask people 1st sett interf question?
                  pressFunction: () => Navigator.of(context).pushNamed(sSettinterf),
                  buttonPos: MenuButtonPos.midright,
                  softWrap: true,
                ),
              ],
            ),
            Row(
              children: [
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight5,
                  buttonText: 'I have seen photos or videos of badger baiting',
                  pressFunction: () {
                    liveReport.activeReport.bbType = BbType.photovideo;
                    Navigator.of(context).pushNamed(sQuickReport, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.bottomleft,
                  softWrap: true,
                ),
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight5,
                  buttonText: 'I have other information about badger baiting',
                  pressFunction: () {
                    liveReport.activeReport.bbType = BbType.otherinfo;
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
