import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../exports_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        leading: Container(
          width: 120,
          child: Hero(
            tag: 'logo',
            child: appIcon120,
          ),
        ),
        /*leading: IconButton(
          icon: appIcon120,
          onPressed: () => Navigator.of(context).pushNamed(sIntro),
        ),*/
        title: const Text(appTitle),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (String value) {
              switch (value) {
                case 'testing':
                  myLaunchUrl('https://crsdc.github.io/badger/');
                  break;
                case 'privacy':
                  myLaunchUrl('https://crsdc.github.io/badger/privacy/');
                  break;
                default:
                  Navigator.of(context).pushNamed(value);
              }
            },
            itemBuilder: (BuildContext context) {
              if (globTestMode) {
                return const [
                  PopupMenuItem(
                    value: sHelp,
                    child: ListTile(
                      leading: Icon(MdiIcons.helpCircle, color: crimeRed),
                      title: Text('Help'),
                    ),
                  ),
                  PopupMenuItem(
                    value: sAbout,
                    child: ListTile(
                      leading: Icon(Icons.info, color: crimeRed),
                      title: Text('About'),
                    ),
                  ),
                  PopupMenuItem(
                    value: sLocationDisplay,
                    child: ListTile(
                      leading: Icon(MdiIcons.mapMarker, color: crimeRed),
                      // TODO Needs an interstitial
                      title: Text('Show my location'),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'testing',
                    child: ListTile(
                      leading: Icon(MdiIcons.testTube, color: crimeRed),
                      title: Text('Testing instructions'),
                      trailing: Icon(MdiIcons.openInNew),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'privacy',
                    child: ListTile(
                      leading: Icon(MdiIcons.fileDocument, color: crimeRed),
                      title: Text('Privacy policy'),
                      trailing: Icon(MdiIcons.openInNew),
                    ),
                  ),
                  PopupMenuItem(
                    value: sSettings,
                    child: ListTile(
                      leading: Icon(MdiIcons.cog, color: crimeRed),
                      title: Text('Settings'),
                    ),
                  ),
                  /*PopupMenuItem(
                    value: sFontTest,
                    child: ListTile(
                      leading: Icon(MdiIcons.text, color: crimeRed),
                      title: Text('FontTest\n(please ignore)'),
                    ),
                  ),
                  PopupMenuItem(
                    value: sMapp2,
                    child: ListTile(
                      leading: Icon(MdiIcons.map, color: crimeRed),
                      title: Text('MapTest\n(please ignore)'),
                    ),
                  ),
                  PopupMenuItem(
                    value: sMapp2,
                    child: ListTile(
                      leading: Icon(MdiIcons.map, color: crimeRed),
                      title: Text('Map 2\n(please ignore)'),
                    ),
                  ),*/
                ];
              } else {
                // Stable version menu
                return const [
                  PopupMenuItem(
                    value: sHelp,
                    child: ListTile(
                      leading: Icon(MdiIcons.helpCircle, color: crimeRed),
                      title: Text('Help'),
                    ),
                  ),
                  PopupMenuItem(
                    value: sAbout,
                    child: ListTile(
                      leading: Icon(Icons.info, color: crimeRed),
                      title: Text('About'),
                    ),
                  ),
                  PopupMenuItem(
                    value: sLocationDisplay,
                    child: ListTile(
                      leading: Icon(MdiIcons.mapMarker, color: crimeRed),
                      title: Text('Show my location'),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'privacy',
                    child: ListTile(
                      leading: Icon(MdiIcons.fileDocument, color: crimeRed),
                      title: Text('Privacy policy'),
                      trailing: Icon(MdiIcons.openInNew),
                    ),
                  ),
                  PopupMenuItem(
                    value: sSettings,
                    child: ListTile(
                      leading: Icon(MdiIcons.cog, color: crimeRed),
                      title: Text('Settings'),
                    ),
                  ),
                  // TODO future items gh#84
                  /*
                  const PopupMenuItem(
                    value: sAbout,
                    child: ListTile(
                      leading: Icon(Icons.message),
                      title: Text('Feedback'),
                      enabled: false,
                    ),
                  ),
                  const PopupMenuItem(
                    value: sAbout,
                    child: ListTile(
                      leading: Icon(MdiIcons.accountMultiple),
                      title: Text('Recommend to a friend'),
                      enabled: false,
                    ),
                  ),*/
                ];
              }
            }
          ),
        ],
      ),

      body: Center(
        child: ListView(
          children: <Widget>[
            Visibility(
              visible: globTestMode,
              child: const Row(
                children: [
                  Expanded (
                    child: Text(
                      '\n   Version $appVersion in testing mode   \n   You can safely submit made-up reports   ',
                      style: sTHighlight,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: outsideButtonDoubleTop,
                    child: Text(
                      'Document and report a crime or suspicious incident',
                      style: lTStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                MenuButton(
                  buttonType: MenuButtonType.highlight,
                  height: buttonHeight2,
                  buttonText: 'Sett\ninterference',
                  pressFunction: () => Navigator.of(context).pushNamed(sSettinterf),
                  // FOR TESTING
                  //pressFunction: () => Navigator.of(context).pushNamed(sMapp),
                  buttonPos: MenuButtonPos.topleft,
                ),
                MenuButton(
                  buttonType: MenuButtonType.highlight,
                  height: buttonHeight2,
                  buttonText: 'Badger\nbaiting',
                  pressFunction: () => Navigator.of(context).pushNamed(sBadgbaiting),
                  buttonPos: MenuButtonPos.topright,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                MenuButton(
                  buttonType: MenuButtonType.highlight,
                  height: buttonHeight2,
                  buttonText: 'Traps or\nsnares',
                  pressFunction: () => Navigator.of(context).pushNamed(sTrapsnare),
                  buttonPos: MenuButtonPos.midleft,
                ),
                MenuButton(
                  buttonType: MenuButtonType.highlight,
                  height: buttonHeight2,
                  buttonText: 'Shooting or\nlamping',
                  pressFunction: () => Navigator.of(context).pushNamed(sShootlamp),
                  buttonPos: MenuButtonPos.midright,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                MenuButton(
                  buttonType: MenuButtonType.highlight,
                  height: buttonHeight2,
                  buttonText: 'Poison',
                  pressFunction: () => Navigator.of(context).pushNamed(sPoison),
                  buttonPos: MenuButtonPos.bottomleft,
                ),
                MenuButton(
                  buttonType: MenuButtonType.highlight,
                  height: buttonHeight2,
                  buttonText: 'Other or\nquick report',
                  pressFunction: () => Navigator.of(context).pushNamed(sQuickReport),
                  buttonPos: MenuButtonPos.bottomright,
                ),
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(outsideButton),
                  child: Text(
                    'Other options',
                    style: lTStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight2,
                  buttonText: 'Injured\nbadger',
                  pressFunction: () => Navigator.of(context).pushNamed(sInjuredbadg),
                  buttonPos: MenuButtonPos.topleft,
                ),
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight2,
                  buttonText: 'Dog stuck\nin sett',
                  pressFunction: () => Navigator.of(context).pushNamed(sDogstuck),
                  buttonPos: MenuButtonPos.topright,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight2,
                  buttonText: 'Identify a\nbadger sett',
                  pressFunction: () => Navigator.of(context).pushNamed(sChecklistBadgeractivity),
                  buttonPos: MenuButtonPos.bottomleft,
                ),

                // a custom clone of menuButton
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(outsideButton / 2, outsideButton / 2, outsideButton, outsideButton),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: buttonHeight2 * MediaQuery.of(context).textScaleFactor,
                        maxHeight: buttonHeight2 * MediaQuery.of(context).textScaleFactor,
                      ),
                      child: ElevatedButton(
                        style: lbButton,
                        onPressed: () {
                          myLaunchUrl('https://www.badgertrust.org.uk/you#comp-krn9h83l');
                          //TapGestureRecognizer()..onTap = () async => launchURL('https://www.badgertrust.org.uk/you#comp-krn9h83l'),
                          //disabledSnackBar(context);
                          //Navigator.of(context).pushNamed(sFindgroup);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(insideButton),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Find a\nlocal group',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                ),
                              ),
                              RichText(
                                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                text: TextSpan(
                                  children: [
                                    extLinkIcon(color: Colors.white),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          //child: RichText(text:TextSpan(children:[TextSpan(text:'Find a\nlocal group', style: bodyTextWhite), extLinkIcon(),]),),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Visibility(
              visible: true,
              child: Divider(
                color: dividerShade,
                height: 25,
                thickness: 3,
                indent: 15,
                endIndent: 15,
              ),
            ),
            Visibility(
              visible: true,
              child: Row(
                children: <Widget>[
                  MenuButton(
                    buttonType: MenuButtonType.standard,
                    height: buttonHeight2,
                    buttonText: 'My locations',
                    pressFunction: () => Navigator.of(context).pushNamed(sMyLocations),
                    buttonPos: MenuButtonPos.left,
                  ),
                  MenuButton(
                    buttonType: MenuButtonType.standard,
                    height: buttonHeight2,
                    buttonText: 'My reports',
                    pressFunction: () => Navigator.of(context).pushNamed(sMyReports),
                    buttonPos: MenuButtonPos.right,
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
