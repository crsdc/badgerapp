import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'exports_config.dart';

/// BADGER WATCH: A free and open-source cross-platform mobile app
///
/// Concept, design and text content COPYRIGHT Badger Watch partnership team 2021-25
/// Source code COPYRIGHT Chris Calvert 2021-25
///
///     This program is free software: you can redistribute it and/or modify
///     it under the terms of the GNU General Public License as published by
///     the Free Software Foundation, either version 3 of the License, or
///     (at your option) any later version.
///
///     This program is distributed in the hope that it will be useful,
///     but WITHOUT ANY WARRANTY; without even the implied warranty of
///     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
///     GNU General Public License for more details.
///
///     You should have received a copy of the GNU General Public License
///     along with this program.  If not, see <https://www.gnu.org/licenses/>.
///
/// See COPYING file in the root of the source tree for the full licence.
///
/// Photos bundled with the app are COPYRIGHT their individual owners (see photo
/// credits in About screen) and are used with permission. All rights reserved.
///
/// See the About screen for details of the partnership team and contributors.

Future<void> main() async {
  print('main()');

  // We do operations in main() that need Flutter things to be ready before runApp()
  WidgetsFlutterBinding.ensureInitialized();
  print('WidgetsFlutterBinding.ensureInitialized() has run');

  // Consult saved prefs to decide whether to skip onboarding screens
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  print('SharedPreferences requested');

  final bool hideIntroScreen = prefs.getBool('hideIntroScreen') ?? false;
  print('hideIntroScreen $hideIntroScreen');

  // Dev constants can override user prefs to enforce or disable testing mode
  if (testingVariant) {
    globTestMode = true;
  } else if (nontestingVariant) {
    globTestMode = false;
  } else {
    globTestMode = prefs.getBool('testModePref') ?? false;
  }
  print('globTestMode $globTestMode');

  // Initialise singleton for map caching
  FlutterMapTileCaching.initialise(await RootDirectory.normalCache);
  FlutterMapTileCaching.instance;

  final StoreDirectory mapTileCache = FMTC.instance('TF-OSM-landscape');
  await mapTileCache.manage.createAsync();
  await mapTileCache.metadata.addAsync(
    key: 'sourceURL',
    value: mapTemplateUrl + mapKeyApi,
  );
  await mapTileCache.metadata.addAsync(
    key: 'validDuration',
    value: '90',
  );
  await mapTileCache.metadata.addAsync(
    key: 'behaviour',
    value: 'cacheFirst',
  );

  runApp(BadgerApp(hideIntroScreen: hideIntroScreen));
}

class BadgerApp extends StatefulWidget {
  final bool hideIntroScreen;

  const BadgerApp({
    Key? key,
    required this.hideIntroScreen,
  }) : super(key: key);

  @override
  State<BadgerApp> createState() => _BadgerAppState();
}

class _BadgerAppState extends State<BadgerApp> {

  // For initialising the sembast database
  final Future _init = Init.initialize();

  // For loading shared preferences to decide whether to begin with HomeScreen or Intro
  //bool prefsLoaded = false;
  //bool? hideIntroScreen;
  //final Future _prefsReady = _retrievePrefs();

  /*Future<void> _retrievePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    // Check whether the stored pref exists and give it a default value if not
    hideIntroScreen = prefs.getBool('hideIntroScreen') ?? false;
    //setState(() => hideIntroScreen = prefs.getBool('hideIntroScreen') ?? false);
  }*/

  /*@override
  void initState() {
    super.initState();
    _retrievePrefs()){
    }
  }*/

  @override
  Widget build(BuildContext context) {
    print('Build the top widget MaterialApp');
    return KeyboardVisibilityProvider(
      child: GetMaterialApp(
        title: appTitle,
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          highlightColor: highlightScrollbar,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              // TODO is this being used?
              fontSize: 14.0,
              color: textBlack,
            ),
          ),
          primaryColor: crimeRed,
          hintColor: appDB,
          dividerColor: Colors.transparent
          // TODO look at theme properly as part of dark mode
        ),

        routes: {
          // Opening screens
          sIntro: (context) => Intro(),
          sHomeScreen: (context) => HomeScreen(),

          // Top level screens
          sQuickReport: (context) => QuickReport(),
          sInjuredbadg: (context) => Injuredbadg(),
          sDogstuck: (context) => Dogstuck(),
          //sFindGroup: (context) => FindGroup(),
          sMyLocations: (context) => MyLocations(),
          sMyReports: (context) => MyReports(),

          // Decision tree screens

          // under Settinterf
          sSettinterf: (context) => Settinterf(),
          sSettinterf1: (context) => Settinterf1Info(),
          sSettinterf1Happening: (context) => Settinterf1HappeningWhatLicence(),
          sSettinterf1HapnowUnlicensed: (context) => Settinterf1HapnowUnlicensed(),
          sSettinterf1Licensed: (context) => Settinterf1Licensed(),
          sSettinterf2: (context) => Settinterf2Info(),
          sSettinterf3: (context) => Settinterf3Info(),

          // under Badgbaiting
          sBadgbaiting: (context) => Badgbaiting(),
          sBadgbaitingPerps: (context) => BadgbaitingPerps(),
          sBadgbaitingStillalive: (context) => BadgbaitingStillalive(),
          sBadgbaitingNeedhelp: (context) => BadgbaitingNeedhelp(),

          // under Trapsnare
          sTrapsnare: (context) => Trapsnare(),
          sTrapsnareSnare: (context) => TrapsnareSnare(),
          sTrapsnareLeghold: (context) => TrapsnareLeghold(),
          sTrapsnareCage: (context) => TrapsnareCage(),
          sTrapsnareOther: (context) => TrapsnareOther(),
          sTrapsnareNeedhelp: (context) => TrapsnareNeedhelp(),

          // under Shootlamp
          sShootlamp: (context) => Shootlamp(),
          sShootlampPerps: (context) => ShootlampPerps(),
          sShootlampStillalive: (context) => ShootlampStillalive(),
          sShootlampNeedhelp: (context) => ShootlampNeedhelp(),

          // under Poison
          sPoison: (context) => Poison(),
          sPoisonStillalive: (context) => PoisonStillalive(),
          sPoisonNeedhelp: (context) => PoisonNeedhelp(),
          sPoisonNearsett: (context) => PoisonNearsett(),

          // Screens we meet in the course of navigating the tree
          sLocationDisplay: (context) => LocationDisplay(),
          sOtherinfoLocation: (context) => OtherinfoLocation(),
          sMapp: (context) => Mapp(),
          //sMapp2: (context) => Mapp2(),
          sNine: (context) => Nine(),
          sChecklist: (context) => Checklist(),
          sChecklistAnimal: (context) => ChecklistAnimal(),
          sChecklistPoison: (context) => ChecklistPoison(),
          sChecklistTrapsnare: (context) => ChecklistTrapsnare(),
          sChecklistHuman: (context) => ChecklistHuman(),
          sChecklistAftermath: (context) => ChecklistAftermath(),
          sChecklistBadgeractivity: (context) => ChecklistBadgeractivity(),
          sVidphoto: (context) => Vidphoto(),
          sEmailPreview: (context) => EmailPreview(),
          sEmailDone: (context) => EmailDone(),

          // Miscellaneous screens
          sAbout: (context) => About(),
          sHelp: (context) => Help(),
          sSettings: (context) => Settings(),
          sFontTest: (context) => FontTest(),
        },

        // Skip onboarding if we retrieved a shared pref to say we should
        home: widget.hideIntroScreen ? HomeScreen() : Intro(),
        //home: Mapp2(),

        /*home: FutureBuilder(
          future: _init,
          builder: (context, snapshot) {
            _retrievePrefs();
            if (snapshot.connectionState == ConnectionState.done) {
              _retrievePrefs();
              // Give prefs a chance to load
              sleep(const Duration(milliseconds: 100));
              if (hideIntroScreen == true) {
                return HomeScreen();
                // Testing mode options
                //return Nine();
                //return Checklist();
                //return ChecklistBadgeractivity();
                //return Mapp();
                //return MyLocations();
                //return QuickReport();
              } else {
                return Intro();
                //return Checklist();
              }
            } else {
              _retrievePrefs();
              return const Material(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),*/
      ),
    );
  }
}

// TODO Dark theme gh#17
/*theme: ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.orange,
  ).copyWith(
    secondary: Colors.lightGreenAccent,
  ),
  textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.purple)),
  primaryColor: appDarkGreyColor,
  primarySwatch: Colors.blue,
  primaryColor: Colors.deepPurple,
),*/
