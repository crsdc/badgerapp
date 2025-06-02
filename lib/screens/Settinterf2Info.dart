/*
versions for:
  hunt-related
  badger diggers
  poisoning/gassing

options:
  Happening now       > Nine (dangerous)
  Not happening now   > map
*/

import '../exports_config.dart';

class Settinterf2Info extends StatefulWidget {
  @override
  State<Settinterf2Info> createState() => _Settinterf2InfoState();
}

class _Settinterf2InfoState extends State<Settinterf2Info> {
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
            Image.asset(liveReport.themeImage),

            // Explanatory text, which varies according to interfType
            Padding(
              padding: outsideButtonAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.poisoning,
                    child: const Text(
                      // TODO warning triangle and match Poisons route
                      'If you suspect sett gassing or poisoning, do not touch anything. Do not unblock any blocked sett entrances. Gases and poisons pose a serious threat to life and health.',
                      style: mTStyle,
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.poisoning,
                    child: const SizedBox(height: paraBreak),
                  ),
                  RichText(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    text: TextSpan(
                      style: mTStyle,
                      children: [
                        const TextSpan(text: 'Badger setts are protected under the Protection of Badgers Act 1992. It\'s an offence to intentionally or recklessly interfere with a badger sett or to knowingly cause or permit a badger sett to be interfered with '),
                        legLink(Legislation.poba92s3, 3, context),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: paraBreak),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.hunt || liveReport.activeReport.interfType == InterfType.diggers,
                    child: RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        style: mTStyle,
                        children: [
                          const TextSpan(text: 'It is also an offence to dig for a badger '),
                          legLink(Legislation.poba92s2, 2, context),
                          const TextSpan(text: ' or to wilfully kill, injure or take a badger, or attempt to do so '),
                          legLink(Legislation.poba92s1, 1, context),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.poisoning,
                    child: RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        style: mTStyle,
                        children: [
                          const TextSpan(text: 'It is also an offence to wilfully kill, injure or take a badger, or attempt to do so '),
                          legLink(Legislation.poba92s1, 1, context),
                          const TextSpan(text: '. Sett gassing may be an offence under the Wildlife and Countryside Act 1981 '),
                          legLink(Legislation.waca81s11, 11, context),
                          const TextSpan(text: ' and the Animal Welfare Act 2006 '),
                          legLink(Legislation.awa06s7, 7, context),
                          const TextSpan(text: '. Poisoning may be an offence under the Wild Mammals (Protection) Act 1996 '),
                          legLink(Legislation.wmpa96s1, 1, context),
                          const TextSpan(text: '. There may be additional offences under the Control of Pesticides Regulations 1986 and the Food and Environment Protection Act 1985.'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: paraBreak),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.hunt,
                    child: const Text(
                      'There is no exemption that allows hunts to block, dig or otherwise interfere with a sett, and there may be additional offences being committed under the Hunting Act 2004 or other legislation.',
                      style: mTStyle,
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.hunt,
                    child: const SizedBox(height: paraBreak),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.hunt || liveReport.activeReport.interfType == InterfType.diggers,
                    child: const Text(
                      'Interference could include:',
                      style: mTStyle,
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.poisoning,
                    child: const Text(
                      'Signs of possible sett gassing include:',
                      style: mTStyle,
                    ),
                  ),
                  const SizedBox(height: paraBreak),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.hunt || liveReport.activeReport.interfType == InterfType.diggers,
                    child: const UnorderedList([
                      'Blocking or obstruction of sett entrances (e.g. with soil, rubble, nets, etc.)',
                      'Damage to tunnels or chambers from digging',
                      'Complete destruction of the sett',
                      'Disturbance of a badger in the sett, e.g. by entering a dog into the sett',
                    ]),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.poisoning,
                    child: const UnorderedList([
                      'White floury powder in the sett entrances',
                      'Spherical garlic-smelling grey pellets in the sett entrances',
                      'Blocked sett entrance holes',
                      'Discarded canisters or containers',
                      'Dead badgers',
                    ]),
                  ),
                  const SizedBox(height: paraBreak),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.hunt || liveReport.activeReport.interfType == InterfType.diggers,
                    child: const Text(
                      'You may see people with spades, nets and terrier-type dogs being used. These dogs may be wearing transmitter collars around their necks.',
                      style: mTStyle,
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.poisoning,
                    child: const Text(
                      'Signs of possible poisoning include:',
                      style: mTStyle,
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.poisoning,
                    child: const SizedBox(height: paraBreak),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.poisoning,
                    child: const UnorderedList([
                      'Poison bait (e.g. food items filled with drugs, poisons or pesticides)',
                      'Dead badgers',
                    ]),
                  ),
                  const SizedBox(height: paraBreak),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.hunt || liveReport.activeReport.interfType == InterfType.diggers,
                    child: const Text(
                      'Is someone interfering with the sett right now?',
                      style: mTBold,
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.poisoning,
                    child: const Text(
                      'Are the perpetrators still at the scene?',
                      style: mTBold,
                    ),
                  ),
                ],
              ),
            ),

            // Row of simple yes/no buttons for all versions
            Row(
              children: <Widget>[
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'Yes',
                  pressFunction: () {
                    liveReport.dangerFlag = true;
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
