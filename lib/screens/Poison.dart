import 'package:flutter/gestures.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../exports_config.dart';

class Poison extends StatefulWidget {
  @override
  State<Poison> createState() => _PoisonState();
}

class _PoisonState extends State<Poison> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {

    // Create a new livereport
    LiveReport liveReport = LiveReport.fresh();
    liveReport.activeReport.incidentType = IncidentType.poison;

    return Scaffold(
      backgroundColor: appBackground,
      appBar: appBarOneLineWithHome(
        titleText: 'Poison',
        context: context,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Image.asset(imgPoisonTins),

            // Explanatory text
            // Warning with icon, specific to the Poison tree
            Padding(
              padding: outsideButtonDoubleTop,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      MdiIcons.alert,
                      color: crimeRed,
                    ),
                    title: RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      // TODO check on A5 for font size consistency gh#24
                      text: const TextSpan(
                        style: mTStyle,
                        children: [
                          TextSpan(
                            text: 'Warning: ',
                            style: mTBold,
                          ),
                          TextSpan(text: 'Poisons pose a serious threat to health and life. Do not touch any potentially poisonous substances in the environment.'),
                        ],
                      ),
                    ),
                  ),
                  RichText(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    text: TextSpan(
                      style: mTStyle,
                      children: [
                        //halfParaBreakText(),
                        const TextSpan(text: '\nIt\'s an offence under the Protection of Badgers Act 1992 '),
                        legLink(Legislation.poba92s1, 1, context),
                        const TextSpan(text: ' to wilfully kill, injure or take a badger, or attempt to do so. Poisoning may also be an offence under the Wild Mammals (Protection) Act 1996 '),
                        legLink(Legislation.wmpa96s1, 1, context),
                        const TextSpan(text: ' or the Animal Welfare Act 2006 '),
                        legLink(Legislation.awa06s7, 7, context),
                        const TextSpan(text: ' and there may be additional offences being committed under the Control of Pesticides Regulations 1986 and the Food and Environment Protection Act 1985.'),
                        paraBreakText(),
                        const TextSpan(text: 'Any suspected poisoning incident must be reported to the Health and Safety Executive on '),
                        TextSpan(
                          text: '0800 321600',
                          style: mTLink,
                          recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('tel:0800321600'),
                        ),
                        const TextSpan(text: ' under their '),
                        TextSpan(
                          text: 'Wildlife Incident Investigation Scheme',
                          style: mTLink,
                          recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://www.hse.gov.uk/pesticides/reducing-environmental-impact/wildlife/wildlife-incident-investigation-scheme.htm'),
                        ),
                        extLinkIcon(),
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

            // TODO nicer consistent buttons gh#87
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(outsideButton),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: buttonHeight2),
                      child: ElevatedButton(
                        style: dbButton,
                        onPressed: () {
                          liveReport.activeReport.psType = PsType.badger;
                          Navigator.of(context).pushNamed(sPoisonStillalive, arguments: liveReport);
                          //liveReport.activeReport.interfLicensed = InterfLicensed.licensed;
                          //Navigator.of(context).pushNamed(sSettinterf1Licensed, arguments: liveReport);
                          //disabledSnackBar(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(insideButton),
                          child: Text(
                            'I have found a suspected\npoisoned badger',
                            textAlign: TextAlign.center
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(outsideButton),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: buttonHeight2),
                      child: ElevatedButton(
                        style: dbButton,
                        onPressed: () {
                          liveReport.activeReport.psType = PsType.substance;
                          Navigator.of(context).pushNamed(sPoisonNearsett, arguments: liveReport);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(insideButton),
                          child: Text(
                            'I have found a suspicious\nsubstance or poison',
                            textAlign: TextAlign.center
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(outsideButton),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: buttonHeight2),
                      child: ElevatedButton(
                        style: dbButton,
                        onPressed: () {
                          liveReport.activeReport.psType = PsType.otherinfo;
                          Navigator.of(context).pushNamed(sOtherinfoLocation, arguments: liveReport);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(insideButton),
                          child: Text(
                            'I have other information\nabout poisoning',
                            textAlign: TextAlign.center
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
