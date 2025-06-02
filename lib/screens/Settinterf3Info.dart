/*
versions for:
  other causes
  cause unknown

options:
  Happening now       >
  Not happening now   >
*/

import '../exports_config.dart';

class Settinterf3Info extends StatefulWidget {
  @override
  State<Settinterf3Info> createState() => _Settinterf3InfoState();
}

class _Settinterf3InfoState extends State<Settinterf3Info> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {

    // Set up LiveReport
    LiveReport liveReport = LiveReport();
    if (ModalRoute.of(context)?.settings.arguments != null) {
      final LiveReport receivedData = ModalRoute.of(context)?.settings.arguments as LiveReport;
      liveReport = receivedData;
      // Based on type of sett interference, set interfTypeString and themeImage that will persist for next few screens
      liveReport.interfTypeFleshOut();
    } else {
      print(Error.noArgsForLiveReport);
    }

    return Scaffold(
      backgroundColor: appBackground,
      appBar: appBarTwoLineWithHome(
        titleText: 'Sett interference:\n${liveReport.interfTypeString}',
        context: context,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            // No theme image in this one, unlike the other SettInterf*Info
            // but there is one listed on the photos spreadsheet

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
                        const TextSpan(text: 'Badger setts are protected under the Protection of Badgers Act 1992. It\'s an offence to intentionally or recklessly interfere with a badger sett or to knowingly cause or permit a badger sett to be interfered with '),
                        legLink(Legislation.poba92s3, 3, context),
                        const TextSpan(text: '.'),
                        paraBreakText(),
                        const TextSpan(text: 'It is also an offence to dig for a badger '),
                        legLink(Legislation.poba92s2, 2, context),
                        const TextSpan(text: ' or to wilfully kill, injure or take a badger, or attempt to do so '),
                        legLink(Legislation.poba92s1, 1, context),
                        const TextSpan(text: '.'),
                        paraBreakText(),
                        const TextSpan(text: 'Interference could include:\n'),
                      ],
                    ),
                  ),
                  const UnorderedList([
                    'Blocking or obstruction of sett entrances',
                    'Damage to tunnels or chambers from digging or machinery',
                    'Complete destruction of the sett',
                    'Disturbance of a badger in the sett, even if there is no damage to the sett itself',
                  ]),
                  RichText(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    text: const TextSpan(
                      style: mTStyle,
                      children: [
                        TextSpan(
                          text: '\nIs someone interfering with the sett right now?',
                          style: mTBold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Row of simple yes/no buttons
            Row(
              children: <Widget>[
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'Yes',
                  pressFunction: () {
                    liveReport.activeReport.interfHappening = InterfHappening.hapnow;
                    Navigator.of(context).pushNamed(sNine, arguments: liveReport);
                  },
                ),
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'No',
                  pressFunction: () {
                    liveReport.activeReport.interfHappening = InterfHappening.nothapnow;
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
