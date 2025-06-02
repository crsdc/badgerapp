import 'package:flutter/gestures.dart';
import '../exports_config.dart';

class Dogstuck extends StatefulWidget {
  @override
  State<Dogstuck> createState() => _DogstuckState();
}

class _DogstuckState extends State<Dogstuck> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: appBarOneLineWithHome(
        titleText: 'Dog stuck in sett',
        context: context
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Image.asset(imgSettWithSpoil),

            // Explantory text
            Padding(
              padding: outsideButtonAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor, // this seems to work??
                    text: TextSpan(
                      style: mTStyle,
                      children: [
                        const TextSpan(text: 'Badgers and their setts are protected by the Protection of Badgers Act 1992. Interfering with a sett without a licence is an offence '),
                        legLink(Legislation.poba92s3, 3, context),
                        const TextSpan(text: '.'),
                        paraBreakText(),
                        const TextSpan(text: 'If you are concerned about a dog that has entered or become trapped in a badger sett, do not attempt to extract the dog by digging or otherwise interfering with the sett. Digging into a sett can cause tunnels and chambers to collapse, posing a serious threat to the dog and any badgers in the sett.'),
                        paraBreakText(),
                        const TextSpan(text: 'In most cases dogs will leave the sett of their own accord after a while.'),
                        paraBreakText(),
                        const TextSpan(text: 'A period of 48 hours would have to pass before a licence from Natural England could be considered. Contact the Natural England Wildlife Licensing Unit ('),
                        TextSpan(
                          text: '0845 6014523',
                          style: mTLink,
                          recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('tel://1234567890'),
                        ),
                        const TextSpan(text: ') or Natural Resources Wales ('),
                        TextSpan(
                          text: '0300 0653000',
                          style: mTLink,
                          recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('tel://1234567890'),
                        ),
                        const TextSpan(text: ') for more information.'),
                        paraBreakText(),
                        const TextSpan(text: 'If you are unable to get hold of them, contact the RSPCA on '),
                        TextSpan(
                          text: '0300 1234999',
                          style: mTLink,
                          recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('tel://1234567890'),
                        ),
                        const TextSpan(text: '. You can also check for a local badger group in your area to contact for advice and possible assistance. See the '),
                        TextSpan(
                          text: 'map of local groups',
                          style: mTLink,
                          recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://www.badgertrust.org.uk/you#comp-krn9h83l'),
                        ),
                        extLinkIcon(),
                        const TextSpan(text: '.'),
                        paraBreakText(),
                        const TextSpan(text: 'Please note that police and other emergency services do not have powers to interfere with badger setts.'),
                        paraBreakText(),
                        const TextSpan(text: 'If you have found a dog in or at a sett and you suspect illegal sett interference, please report this as sett interference.'),
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
