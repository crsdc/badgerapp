import 'package:flutter/gestures.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../exports_config.dart';

class Help extends StatefulWidget {
  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: appBarColor,
        title: const Text('Help'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              //padding: const EdgeInsets.fromLTRB(edgePad * 2, edgePad * 2, edgePad * 2, 0.0),
              padding: const EdgeInsets.all(edgePad * 3),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(
                      MdiIcons.cellphoneText,
                      color: crimeRed,
                    ),
                    title: const Text(
                      'Introduction',
                      style: mTStyle,
                    ),
                    subtitle: const Text(
                      '\nShow the screens that appear when you first install $appTitle',
                      style: sTStyle,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(sIntro);
                    },
                  ),
                  const SizedBox(height: paraBreak),
                  customDivider(),
                  const SizedBox(height: paraBreak),
                  ListTile(
                    leading: const Icon(
                      MdiIcons.frequentlyAskedQuestions,
                      color: crimeRed,
                    ),
                    title: const Text(
                      'Frequently asked questions',
                      style: mTStyle,
                    ),
                    subtitle: const Text(
                      '\nRead about $appTitle on the project website',
                      style: sTStyle,
                    ),
                    onTap: () async => myLaunchUrl('https://crsdc.github.io/badger/qanda/'),
                    //onTap: () async => launchEmail('crime@badgertrust.org.uk'),
                  ),
                  const SizedBox(height: paraBreak),
                  customDivider(),
                  const SizedBox(height: paraBreak),
                  ListTile(
                    leading: const Icon(
                      MdiIcons.email,
                      color: crimeRed,
                    ),
                    title: const Text(
                      'Contact',
                      style: mTStyle,
                    ),
                    subtitle: RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        style: sTStyle,
                        children: [
                          const TextSpan(text: '\nIf you have any problems reporting an incident with $appTitle, please email '),
                          TextSpan(
                            text: 'crime@badgertrust.org.uk',
                            style: sTLink,
                            recognizer: TapGestureRecognizer()..onTap = () async => launchEmail('crime@badgertrust.org.uk'),
                          ),
                        ],
                      ),
                    ),
                    //onTap: () async => launchEmail('crime@badgertrust.org.uk'), // Makes whole ListTile tappable to send email
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
