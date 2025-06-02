import 'package:flutter/gestures.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:package_info_plus/package_info_plus.dart';
import '../exports_config.dart';

class About extends StatefulWidget {
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  /*PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }*/

  int eEggCount = 0;

  void eEgg() {
    eEggCount++;
    if (eEggCount % 11 == 0) {
      toastCustom('\u{1f344} \u{1f344}');
    }
  }

  @override
  void initState() {
    super.initState();
    //_initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light, // TODO dark theme
        backgroundColor: appBarColor,
        title: const Text('About'),
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
              padding: const EdgeInsets.all(edgePad * 3),
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => eEgg(),
                            child: Hero(
                              tag: 'logo',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: appIcon120,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: RichText(
                            textScaleFactor: MediaQuery.of(context).textScaleFactor,
                            text: const TextSpan(
                              style: mTStyle,
                              children: [
                                TextSpan(
                                  text: appTitle,
                                  style: lTBold,
                                ),
                                TextSpan(
                                  text: '\n\n$appVersion',
                                  //text: '\n\n${_packageInfo.version}',
                                  style: mTStyle,
                                ),
                                TextSpan(
                                  text: ' ($appBuild)',
                                  //text: ' (${_packageInfo.buildNumber})',
                                  style: TextStyle(
                                    fontSize: mTSize,
                                    color: Colors.grey,// TODO spin off as a faded, deactivated colour
                                  ), // greyer
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: paraBreak),
                  customDivider(),
                  const SizedBox(height: paraBreak),
                  const Text(
                    '$appTitle helps you recognise, record and report badger persecution in England and Wales.',
                    style: lTStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: paraBreak),
                  customDivider(),
                  const SizedBox(height: paraBreak),

                  const ExpansionTile(
                    leading: Icon(
                      MdiIcons.accountGroup,
                      color: crimeRed,
                    ),
                    title: Text(
                      'App credits',
                      style: mTStyle,
                    ),
                    children: [
                      Text(
                        '$appTitle was created by a partnership between the University of Exeter and Badger Trust, with the support of funding from the Economic & Social Research Council and the Institute of Coding, software development by Chris Calvert, the assistance of Devon and Somerset Badger Groups, and feedback by many helpful users. At the University of Exeter: Dr Jessica Groling, Dr Rudy Arthur, Jacob Box, Dr Steve North, Prof Brian Rappert.',
                        style: sTStyle,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: paraBreak),
                    ],
                  ),

                  const ExpansionTile(
                    leading: Icon(
                      MdiIcons.copyright,
                      color: crimeRed,
                    ),
                    title: Text(
                      'Copyright and licence',
                      style: mTStyle,
                    ),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$appTitle is free and open-source software, available to all under the terms of the GNU General Public License version 3.',
                        style: sTStyle,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: paraBreak),
                      Text(
                        'Concept, design and text content\n\u{a9} 2021\u{2013}25, $appTitle partnership team',
                        style: sTStyle,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: smallBreak),
                      Text(
                        'Source code\n\u{a9} 2021\u{2013}25, Chris Calvert',
                        style: sTStyle,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: paraBreak),
                      Text(
                        'Photos \u{a9} their individual owners. All rights reserved.',
                        style: sTStyle,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),

                  const ExpansionTile(
                    leading: Icon(
                      MdiIcons.camera,
                      color: crimeRed,
                    ),
                    title: Text(
                      'Photo credits',
                      style: mTStyle,
                    ),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thanks to Badger Trust, Craig Fellowes, Naturewatch Foundation, Jessica Groling, Steve Hawkes, Tris Pearce.',
                        style: sTStyle,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: paraBreak),
                    ],
                  ),

                  ExpansionTile(
                    leading: const Icon(
                      MdiIcons.codeBraces,
                      color: crimeRed,
                    ),
                    title: const Text(
                      'Source code',
                      style: mTStyle,
                    ),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          style: sTStyle,
                          children: [
                            const TextSpan(text: 'Source code for $appTitle is available on '),
                            TextSpan(
                              text: 'GitHub',
                              style: sTLink,
                              recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://github.com/crsdc/badgerapp'),
                            ),
                            const TextSpan(text: '.'),
                          ],
                        ),
                      ),
                      const SizedBox(height: paraBreak),
                    ],
                  ),

                  ExpansionTile(
                    leading: const Icon(
                      MdiIcons.fileTreeOutline,
                      color: crimeRed,
                    ),
                    title: const Text(
                      'Third-party software',
                      style: mTStyle,
                    ),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '$appTitle uses software libraries developed by third parties, available under the following licences:',
                        style: sTStyle,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: paraBreak),
                      Row(
                        children: <Widget>[
                          PillButton(
                            buttonType: PillButtonType.deemphasised,
                            buttonText: 'Show',
                            pressFunction: () {
                              showLicensePage(
                                // TODO is it possible to tidy this up?
                                context: context,
                                applicationIcon: appIcon216,
                                applicationName: '$appTitle\n',
                                applicationVersion: '\n$appVersion',
                                //applicationName: '${_packageInfo.appName}\n',
                                //applicationVersion: '\n${_packageInfo.version}',
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: paraBreak),
                    ],
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
