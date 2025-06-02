import 'package:flutter/gestures.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../exports_config.dart';

class Intro extends StatefulWidget {
  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  //final GlobalKey<FormState> _formKeyIntro = GlobalKey<FormState>();

  // Load preferences for the skip intro switch
  //bool hideIntroScreen = false;
  /*Future<void> _retrievePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    // Check whether stored pref exists and give it a default value if not
    setState(() => hideIntroScreen = prefs.getBool('hideIntroScreen') ?? false);
  }*/

  /*Future<void> _saveBools() async {
    final prefs = await SharedPreferences.getInstance();
    // Store our switch value
    prefs.setBool('hideIntroScreen', hideIntroScreen);
  }*/

  final PageController pageController = PageController();
  bool isLastPage = false;

  double logoOpacity = 0.0;

  // TODO need a dispose

  @override
  void initState() {
    // Delay to avoid it displaying before we switch to HomeScreen if async loaded prefs say so
    //sleep(const Duration(milliseconds: 50));
    super.initState();
    //_retrievePrefs();
    Future.delayed(const Duration(milliseconds: 1), () {
      logoOpacity = 1.0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: appBackground,
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    if (index == 6) {
                      isLastPage = true;
                    } else {
                      isLastPage = false;
                    }
                  });
                },
                children: [

                  // 1. logo and title at top then Intro text
                  Padding(
                    padding: const EdgeInsets.all(edgePad * 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: AnimatedOpacity(
                                opacity: logoOpacity,
                                duration: const Duration(milliseconds: 500),
                                child: Image.asset(
                                  'assets/icons/appicon120.png',
                                  // SBC 648x693 image. Was 120x120 when square.
                                  width: 120,
                                  height: 120,
                                  //fit: BoxFit.fill, // not sure if needed
                                ),
                              ),
                            ),
                            Center(
                              child: AnimatedOpacity(
                                opacity: logoOpacity,
                                duration: const Duration(milliseconds: 750),
                                child: const Text(
                                  'Badger\nWatch',
                                  style: TextStyle(
                                    fontSize: xxlTSize,
                                    fontWeight: FontWeight.bold,
                                  ),// TODO spin this off? is it the same as leg popup titles, are they also bold?
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: paraBreak * 5),
                        AnimatedOpacity(
                          opacity: logoOpacity,
                          duration: const Duration(milliseconds: 1000),
                          child: RichText(
                            // TODO can probably just have text, but might need a photo here
                            textAlign: TextAlign.center,
                            textScaleFactor: MediaQuery.of(context).textScaleFactor,
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: '$appTitle helps you recognise, record and report badger persecution in England and Wales.',
                                  style: xlTStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 3. advice - snares screen
                  introPage([
                    shadowedScreenshot(imgSsSnares),
                    const Row(
                      children: [
                        Expanded(
                          child:Text('Understand different kinds of badger persecution',
                            style: lTStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ]),

                  // 4. map
                  introPage([
                    shadowedScreenshot(imgSsMap),
                    const Row(
                      children: [
                        Expanded(
                          child: Text('Accurately locate incidents so they can be followed up',
                            style: lTStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ]),

                  // 5. evidence checklist for sett activity
                  introPage([
                    shadowedScreenshot(imgSsEvidence),
                    const Row(
                      children: [
                        Expanded(
                          child:Text('Help document evidence crucial to prosecuting wildlife crime',
                            style: lTStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ]),

                  // 6. it prepares a report to be emailed to Badger Trust specialists
                  introPage([
                    shadowedScreenshot(imgSsReport),
                    const Row(
                      children: [
                        Expanded(
                          child: Text('$appTitle uses the information you provide to prepare a report for Badger Trust specialists',
                            style: lTStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ]),

                  // 7. privacy: no data is collected until you email a report - and you can see exactly what you're sending
                  introPage([
                    const Icon(
                      MdiIcons.cloudOffOutline,
                      size: 80.0,
                      color: crimeRed,
                    ),
                    const SizedBox(height: paraBreak * 2),
                    RichText(
                      textAlign: TextAlign.center,
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        style: mTStyle,
                        children: [
                          const TextSpan(
                            text: 'You\'re in control',
                            style: lTBold,
                          ),
                          paraBreakText(),
                          const TextSpan(text: '$appTitle respects your privacy and the sensitivity of information about badger habitats.'),
                          paraBreakText(),
                          const TextSpan(text: 'No data leaves your phone until you send your report. It\'s a simple email and you can see exactly what you\'re sending and where it\'s going.'),
                        ],
                      ),
                    ),
                  ]),

                  // 8. legal -
                  introPage([
                    const Icon(
                      MdiIcons.scaleBalance,
                      size: 80.0,
                      color: crimeRed,
                    ),
                    const SizedBox(height: paraBreak * 2),
                    RichText(
                      textAlign: TextAlign.center,
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        style: mTStyle,
                        children: [
                          const TextSpan(
                            text: '$appTitle is intended for use in England and Wales only',
                            style: lTBold,
                          ),
                          paraBreakText(),
                          const TextSpan(
                            text: 'Statements about the law only apply there, and reports can only be accepted for incidents in England and Wales.'
                          ),
                          paraBreakText(),
                          const TextSpan(
                              text: 'To report badger crime in Scotland please contact '
                          ),
                          TextSpan(
                            text: 'Scottish Badgers',
                            style: mTLink,
                            recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://www.scottishbadgers.org.uk/be-involved/report/'),
                          ),
                          extLinkIcon(),
                        ],
                      ),
                    ),
                  ]),

                ],
              ),
            ),
            Center(
              child:
                SmoothPageIndicator(
                  controller: pageController,
                  count: 7,
                  effect: const ScaleEffect(
                    dotColor: Colors.grey,
                    activeDotColor: crimeRed,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    scale: 1.6,
                    spacing: 12.0,
                  ),
                  onDotClicked: (index) => pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  ),
                ),
            ),
            buttonRow(isLastPage, pageController, context),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

Widget introPage(List<Widget> widgetList) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(edgePad * 3, edgePad * 3, edgePad * 3, edgePad * 2),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgetList,
    ),
  );
}

Widget shadowedScreenshot(String imgAsset) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.only(top: 10, bottom: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: appDB.withOpacity(0.5),
            spreadRadius: 10,
            blurRadius: 15,
            //offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      //height: double.infinity,
      //width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imgAsset,
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}

Widget buttonRow (bool isLastPage, PageController pageController, BuildContext context) {
  if (!isLastPage) {
    return Padding(
      padding: const EdgeInsets.only(top: edgePad, bottom: edgePad),
      child: Row(
        children: [
          PillButton(
            buttonType: PillButtonType.deemphasised,
            buttonText: 'Skip',
            pressFunction: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('hideIntroScreen', true);
              Navigator.of(context).pushNamed(sHomeScreen);
            },
          ),
          PillButton(
            buttonType: PillButtonType.standard,
            buttonText: 'Next',
            pressFunction: () => pageController.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            ),
          ),
        ],
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.only(top: edgePad, bottom: edgePad),
      child: Row(
        children: [
          const PillButton(
            buttonType: PillButtonType.highlight,
            buttonText: 'Skip',
          ),
          PillButton(
            buttonType: PillButtonType.highlight,
            buttonText: 'Start',
            pressFunction: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('hideIntroScreen', true);
              Navigator.of(context).pushNamed(sHomeScreen);
            },
          ),
        ],
      ),
    );
  }
}
