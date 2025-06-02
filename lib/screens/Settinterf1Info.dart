import 'package:flutter/gestures.dart';
import '../exports_config.dart';

class Settinterf1Info extends StatefulWidget {
  @override
  State<Settinterf1Info> createState() => _Settinterf1InfoState();
}

class _Settinterf1InfoState extends State<Settinterf1Info> {
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
                        const TextSpan(text: ', unless done under licence and in full compliance with licence conditions.'),
                        paraBreakText(),
                        const TextSpan(text: 'Interference could include:\n'),
                      ],
                    ),
                  ),

                  // Conditional text that varies according to interfType
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.forestry,
                    child: const UnorderedList([
                      'Blocking or obstruction of sett entrances (e.g. with debris from felled trees)',
                      'Damage to tunnels or chambers from digging or heavy machinery',
                      'Complete destruction of the sett',
                      'Disturbance of a badger in the sett, even if there\'s no damage to the sett itself',
                    ]),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.farming,
                    child: const UnorderedList([
                      'Blocking or obstruction of sett entrances (e.g. with soil or other debris)',
                      'Damage to tunnels or chambers from ploughing, harvesting or use of heavy machinery',
                      'Complete destruction of the sett',
                      'Disturbance of a badger in the sett, even if there\'s no damage to the sett itself',
                    ]),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.development,
                    child: const UnorderedList([
                      'Blocking or obstruction of sett entrances',
                      'Damage to tunnels or chambers from digging or heavy machinery',
                      'Complete destruction of the sett',
                      'Disturbance of a badger in the sett, even if there\'s no damage to the sett itself',
                    ]),
                  ),
                  Visibility(
                    visible: (liveReport.activeReport.interfType == InterfType.farming || liveReport.activeReport.interfType == InterfType.development),
                    child: const SizedBox(height: paraBreak),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.farming,
                    child: const Text(
                      'A protection zone of 30\u{2009}m from the nearest sett entrance is usually suggested as a guideline to avoid damage or disturbance to the badgers and their sett.',
                      style: mTStyle,
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.forestry || liveReport.activeReport.interfType == InterfType.farming,
                    child: const SizedBox(height: paraBreak),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.forestry,
                    child: RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        style: mTStyle,
                        children: [
                          const TextSpan(text: 'Where compliance with official guidance on forestry work in the vicinity of badger setts is not feasible or practicable, a licence is required from '),
                          TextSpan(
                            text: 'Natural England',
                            style: mTLink,
                            recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://www.gov.uk/government/collections/badger-licences'),
                          ),
                          extLinkIcon(),
                          const TextSpan(text: ' or the '),
                          TextSpan(
                            text: 'Welsh Government',
                            style: mTLink,
                            recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://gov.wales/badger-licences-7'),
                          ),
                          extLinkIcon(),
                          const TextSpan(text: '. A licence will usually require commitment to specified mitigation measures, such as marking out exclusion zones and protecting sett entrances from obstruction through fallen debris. Sett interference without a licence, or where work doesn\'t comply with the strict terms of the licence, may be a criminal offence.'),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.farming,
                    child: RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        style: mTStyle,
                        children: [
                          const TextSpan(text: 'Agricultural operations carried out in the vicinity of a badger sett which may impact on that sett may require a licence from '),
                          TextSpan(
                            text: 'Natural England',
                            style: mTLink,
                            recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://www.gov.uk/government/collections/badger-licences'),
                          ),
                          extLinkIcon(),
                          const TextSpan(text: ' or the '),
                          TextSpan(
                            text: 'Welsh Government',
                            style: mTLink,
                            recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://gov.wales/badger-licences-7'),
                          ),
                          extLinkIcon(),
                          const TextSpan(text: '. Sett interference without a licence, or where work doesn\'t comply with the strict terms of the licence, may be a criminal offence.'),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.interfType == InterfType.development,
                    child: RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        style: mTStyle,
                        children: [
                          const TextSpan(text: 'A licence is required from '),
                          TextSpan(
                            text: 'Natural England',
                            style: mTLink,
                            recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://www.gov.uk/government/collections/badger-licences'),
                          ),
                          extLinkIcon(),
                          const TextSpan(text: ', '),
                          TextSpan(
                            text: 'Natural Resources Wales',
                            style: mTLink,
                            recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://naturalresources.wales/permits-and-permissions/species-licensing/apply-for-a-protected-species-licence/badger-licences/?lang=en'),
                          ),
                          extLinkIcon(),
                          const TextSpan(text: ' or the '),
                          TextSpan(
                            text: 'Welsh Government',
                            style: mTLink,
                            recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://gov.wales/badger-licences-7'),
                          ),
                          extLinkIcon(),
                          const TextSpan(text: ' to interfere with a sett for development or road construction. Sett interference without a licence, or where work doesn\'t comply with the strict terms of the licence, may be a criminal offence.'),
                        ],
                      ),
                    ),
                  ),

                  // Displayed on all versions
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
                    Navigator.of(context).pushNamed(sSettinterf1Happening, arguments: liveReport);
                  },
                ),
                PillButton(
                  buttonType: PillButtonType.standard,
                  buttonText: 'No',
                  pressFunction: () {
                    liveReport.activeReport.interfHappening = InterfHappening.nothapnow;
                    Navigator.of(context).pushNamed(sSettinterf1Happening, arguments: liveReport);
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
