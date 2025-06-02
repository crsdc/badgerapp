import 'package:flutter/gestures.dart';
import '../exports_config.dart';

class Injuredbadg extends StatefulWidget {
  @override
  State<Injuredbadg> createState() => _InjuredbadgState();
}

class _InjuredbadgState extends State<Injuredbadg> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {

    // Maintain a LiveReport if we've arrived here from the tree, not from Home
    LiveReport liveReport = LiveReport();
    if (ModalRoute.of(context)?.settings.arguments != null) {
      final LiveReport receivedData = ModalRoute.of(context)?.settings.arguments as LiveReport;
      liveReport = receivedData;
    }

    // Decide what to display in app bar based on where we've come from
    PreferredSizeWidget? appBarInjuredBadg() {
      switch (liveReport.activeReport.incidentType) {
        case IncidentType.baiting:
          return appBarTwoLineWithHome(
            titleText: 'Badger baiting:\nInjured animal',
            context: context,
          );
        case IncidentType.trapssnares:
          return appBarTwoLineWithHome(
            titleText: 'Traps or snares:\nGet help for a badger',
            context: context,
          );
        case IncidentType.shootlamp:
          return appBarTwoLineWithHome(
            titleText: 'Shooting or lamping:\nGet help for a badger',
            context: context,
          );
        case IncidentType.poison:
          return appBarTwoLineWithHome(
            // TODO do we need conditionals for poison?
            titleText: 'Poison:\nGet help for a badger',
            context: context,
          );
        case IncidentType.blank:
          // If we came from Home
          return appBarOneLineWithHome (
            titleText: 'Injured badger',
            context: context,
          );
        default:
          print(Error.arrivedScreenShouldnt);
          print('...on screen Injuredbadg');
          return appBarTwoLineWithHome(
            titleText: Error.arrivedScreenShouldnt,
            context: context
          );
      }
    }

    return Scaffold(
      backgroundColor: appBackground,
      appBar: appBarInjuredBadg(),
      body: Center(
        child: ListView(
          children: <Widget>[
            Image.asset(imgInjuredBadgerCage),

            // Explanatory text, which varies according to where we've come from
            Padding(
              padding: outsideButtonAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: liveReport.activeReport.incidentType != IncidentType.trapssnares,
                    child: const Text(
                      'If you\'ve found an injured animal, call for help.',
                      style: mTStyle,
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.incidentType == IncidentType.trapssnares,
                    child: const Text(
                      'If you\'ve found an injured or trapped badger, call for help.',
                      style: mTStyle,
                    ),
                  ),
                  const SizedBox(height: paraBreak),
                  Visibility(
                    visible: liveReport.activeReport.incidentType == IncidentType.trapssnares,
                    child: RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor, // this seems to work??
                      text: TextSpan(
                        style: mTStyle,
                        children: [
                          const TextSpan(text: 'Many local badger groups have trained rescuers who can be called out in an emergency to an injured badger, or can advise what to do if you find a badger in a trap. Use the '),
                          TextSpan(
                            text: 'map on the Badger Trust website',
                            style: mTLink,
                            recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://www.badgertrust.org.uk/you#comp-krn9h83l'),
                          ),
                          extLinkIcon(),
                          const TextSpan(text: ', find your local group and call their emergency number.'),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.incidentType == IncidentType.shootlamp,
                    child: RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor, // this seems to work??
                      text: TextSpan(
                        style: mTStyle,
                        children: [
                          const TextSpan(text: 'Many local badger groups have trained rescuers who can be called out in an emergency to an injured badger. Use the '),
                          TextSpan(
                            text: 'map on the Badger Trust website',
                            style: mTLink,
                            recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://www.badgertrust.org.uk/you#comp-krn9h83l'),
                          ),
                          extLinkIcon(),
                          const TextSpan(text: ', find your local group and call their emergency number.'),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.incidentType != IncidentType.trapssnares && liveReport.activeReport.incidentType != IncidentType.shootlamp,
                    child: RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor, // this seems to work??
                      text: TextSpan(
                        style: mTStyle,
                        children: [
                          const TextSpan(text: 'Many local badger groups have trained rescuers who can be called out in an emergency to an '),
                          const TextSpan(
                            text: 'injured badger',
                            style: mTBold,
                          ),
                          const TextSpan(text: '. Use the '),
                          TextSpan(
                            text: 'map on the Badger Trust website',
                            style: mTLink,
                            recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://www.badgertrust.org.uk/you#comp-krn9h83l'),
                          ),
                          extLinkIcon(),
                          const TextSpan(text: ', find your local group and call their emergency number.'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: paraBreak),

                  // If not from trap/snare tree
                  Visibility(
                    visible: liveReport.activeReport.incidentType != IncidentType.trapssnares,
                    child: const Text(
                      'Unless specifically asked to do so by an experienced rescuer, do not approach the badger but observe from a safe distance.',
                      style: mTStyle,
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.incidentType != IncidentType.trapssnares,
                    child: const SizedBox(height: paraBreak),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.incidentType != IncidentType.trapssnares,
                    child: const Text(
                      'If the badger is on the road, carefully warn other road users but don\'t put yourself at risk while doing so.',
                      style: mTStyle,
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.incidentType != IncidentType.trapssnares,
                    child: const SizedBox(height: paraBreak),
                  ),

                  Visibility(
                    visible: liveReport.activeReport.incidentType != IncidentType.shootlamp,
                    child: const Text(
                      'If the badger is caught in a snare or is injured in a trap, do not attempt to release it as it may need veterinary treatment. Do not attempt to handle the badger as it may cause you injury.',
                      style: mTStyle,
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.incidentType != IncidentType.shootlamp,
                    child: const SizedBox(height: paraBreak),
                  ),

                  Visibility(
                    visible: liveReport.activeReport.incidentType != IncidentType.trapssnares,
                    child: RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor, // this seems to work??
                      text: TextSpan(
                        style: mTStyle,
                        children: [
                          const TextSpan(text: 'If your local badger group does not have an emergency number, or if you need help for an '),
                          const TextSpan(
                            text: 'injured dog or other animal',
                            style: mTBold,
                          ),
                          const TextSpan(text: ', call the RSCPA on '),
                          TextSpan(
                            text: '0300 1234999',
                            style: mTLink,
                            recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('tel://1234567890'),
                          ),
                          const TextSpan(text: ' or contact a local animal rescue.'),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.incidentType == IncidentType.trapssnares,
                    child: RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor, // this seems to work??
                      text: TextSpan(
                        style: mTStyle,
                        children: [
                          const TextSpan(text: 'If your local badger group does not have an emergency number, call the RSCPA on '),
                          TextSpan(
                            text: '0300 1234999',
                            style: mTLink,
                            recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('tel://1234567890'),
                          ),
                          const TextSpan(text: ' or contact a local animal rescue.'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: paraBreak),
                  const Text(
                    'Next steps',
                    style: mTBold,
                  ),
                  const SizedBox(height: paraBreak),
                  const Text(
                    'If at all possible, remain nearby so you can show rescuers to the location. If you are unable to stay, leave a marker (e.g. a string attached to a tree) to help rescuers identify the location.',
                    style: mTStyle,
                  ),
                  const SizedBox(height: paraBreak),

                  // Lactating sow conditionals
                  Visibility(
                    visible: DateTime.now().month < 7 && liveReport.activeReport.incidentType != IncidentType.shootlamp,
                    child: const Text(
                      'If you have found a dead or injured lactating sow between the months of January and June, please let your local badger group know as soon as possible. They may be able to help locate dependent cubs. Lactating sows have prominent teats.',
                      style: mTStyle,
                    ),
                  ),
                  Visibility(
                    visible: DateTime.now().month < 7 && liveReport.activeReport.incidentType == IncidentType.shootlamp,
                    child: const Text(
                      'If you have found an injured lactating sow between the months of January and June, please let your local badger group know as soon as possible. They may be able to help locate dependent cubs. Lactating sows have prominent teats.',
                      style: mTStyle,
                    ),
                  ),
                  Visibility(
                    visible: DateTime.now().month < 7,
                    child: const SizedBox(height: paraBreak),
                  ),
                  Visibility(
                    visible: DateTime.now().month < 7,
                    child: const ImageCaptioned(
                      image: imgLactating,
                      caption: 'Lactating sow',
                    ),
                  ),
                  //const SizedBox(height: paraBreak),

                  // If not from trap/snare or shoot/lamp tree
                  Visibility(
                    visible: liveReport.activeReport.incidentType != IncidentType.trapssnares && liveReport.activeReport.incidentType != IncidentType.shootlamp,
                    child: const Text(
                      'Suspicious circumstances?',
                      style: mTBold,
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.incidentType != IncidentType.trapssnares && liveReport.activeReport.incidentType != IncidentType.shootlamp,
                    child: const SizedBox(height: paraBreak),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.incidentType != IncidentType.trapssnares && liveReport.activeReport.incidentType != IncidentType.shootlamp,
                    child: const Text(
                      'If the injured animal was found in suspicious circumstances, and only after calling for help, go back to the home screen and select the relevant incident category. ',
                      style: mTStyle,
                    ),
                  ),
                  Visibility(
                    visible: liveReport.activeReport.incidentType == IncidentType.trapssnares,
                    child: const Text(
                      'After calling for help, please continue documenting the incident.',
                      style: mTStyle,
                    ),
                  ),

                  // NEXT BUTTON for now
                  Visibility(
                    visible: liveReport.activeReport.incidentType != IncidentType.blank,
                    child: Row(
                      children: [
                        PillButton(
                          buttonType: PillButtonType.standard,
                          // TODO should probably be a standard material arrow gh#87
                          buttonText: 'Next',
                          pressFunction: () {
                            Navigator.of(context).pushNamed(sMapp, arguments: liveReport);
                          },
                        ),
                      ],
                    ),
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
