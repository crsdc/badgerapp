import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exports_config.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<FormState> _formKeySettings = GlobalKey<FormState>();
  /*final GlobalKey<FormState> _firstNameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _lastNameKey = GlobalKey<FormState>();*/
  //final GlobalKey<FormState> _emailAddressKey = GlobalKey<FormState>();
  /*final GlobalKey<FormState> _phoneNumberKey = GlobalKey<FormState>();*/
  // TODO figure out keys and why we need them

  // Initialise values so not null when screen renders before prefs load
  String firstName = '';
  String lastName = '';
  String emailAddress = '';
  String phoneNumber = '';
  String county = '';
  //bool nightMode = false;
  //bool hideIntroScreen = false;
  bool testModePref = false;

  // To track whether we need to save when leaving screen
  bool didPrefsChange = false;

  // Controllers so prefs code can read and write the text fields
  // TODO is there an abbreviated syntax?
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController countyController = TextEditingController();

  bool firstNameShowClearButton = false;
  bool lastNameShowClearButton = false;
  bool emailAddressShowClearButton = false;
  bool phoneNumberShowClearButton = false;
  bool countyShowClearButton = false;

  Future<void> retrievePrefs() async {
    print ('_retreivePrefs');
    print ('3 lastName is $lastName');//shd be default
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // For each pref, check database, and if missing use a default value
      print ('setting state in _retreivePrefs');
      print ('4 lastName is $lastName');
      //nightMode = prefs.getBool('nightMode') ?? false;
      //hideIntroScreen = prefs.getBool('hideIntroScreen') ?? false;
      testModePref = prefs.getBool('testModePref') ?? false;
      firstName = prefs.getString('firstName') ?? '';
      firstNameController.text = firstName;
      lastName = prefs.getString('lastName') ?? '';
      lastNameController.text = lastName;
      emailAddress = prefs.getString('emailAddress') ?? '';
      emailAddressController.text = emailAddress;
      phoneNumber = prefs.getString('phoneNumber') ?? '';
      phoneNumberController.text = phoneNumber;
      county = prefs.getString('county') ?? '';
      countyController.text = county;
    });
  }

  Future<bool> savePrefs() async {
    final prefs = await SharedPreferences.getInstance();

    // Save prefs if they've changed, and set flag to show snackbar
    if(firstNameController.text != firstName) {
      prefs.setString('firstName', firstNameController.text);
      didPrefsChange = true;
    }
    if(lastNameController.text != lastName) {
      prefs.setString('lastName', lastNameController.text);
      didPrefsChange = true;
    }
    if(emailAddressController.text != emailAddress) {
      prefs.setString('emailAddress', emailAddressController.text);
      didPrefsChange = true;
    }
    if(phoneNumberController.text != phoneNumber) {
      prefs.setString('phoneNumber', phoneNumberController.text);
      didPrefsChange = true;
    }
    if(countyController.text != county) {
      prefs.setString('county', countyController.text);
      didPrefsChange = true;
    }

    if(didPrefsChange) {
      savedSnackBar(context);
    }

    //Navigator.pop(context);
    //Navigator.of(context).pushNamed(sHomeScreen);

    // onWillPop needs to hear that we are happy to pop the navigator stack
    return true;
  }

  Future<void> saveBools() async {
    final prefs = await SharedPreferences.getInstance();
    //prefs.setBool('nightMode', nightMode);
    //prefs.setBool('hideIntroScreen', hideIntroScreen);
    prefs.setBool('testModePref', testModePref);
  }

  // TODO spin this off
  Widget? _firstNameGetClearButton() {
    if (!firstNameShowClearButton) {
      return null;
    } else {
      return IconButton(
        onPressed: () => firstNameController.clear(),
        icon: const Icon(Icons.clear),
      );
    }
  }
  Widget? _lastNameGetClearButton() {
    if (!lastNameShowClearButton) {
      return null;
    } else {
      return IconButton(
        onPressed: () => lastNameController.clear(),
        icon: const Icon(Icons.clear),
      );
    }
  }
  Widget? _emailAddressGetClearButton() {
    if (!emailAddressShowClearButton) {
      return null;
    } else {
      return IconButton(
        onPressed: () => emailAddressController.clear(),
        icon: const Icon(Icons.clear),
      );
    }
  }
  Widget? _phoneNumberGetClearButton() {
    if (!phoneNumberShowClearButton) {
      return null;
    } else {
      return IconButton(
        onPressed: () => phoneNumberController.clear(),
        icon: const Icon(Icons.clear),
      );
    }
  }
  Widget? _countyGetClearButton() {
    if (!countyShowClearButton) {
      return null;
    } else {
      return IconButton(
        onPressed: () => countyController.clear(),
        icon: const Icon(Icons.clear),
      );
    }
  }

  @override
  void initState() {
    print('initState');
    print('1 lastName is $lastName');
    super.initState();
    retrievePrefs();
    print('2 lastName is $lastName');
    firstNameController.addListener(() => setState(() => firstNameShowClearButton = firstNameController.text.isNotEmpty));
    lastNameController.addListener(() => setState(() => lastNameShowClearButton = lastNameController.text.isNotEmpty));
    emailAddressController.addListener(() => setState(() => emailAddressShowClearButton = emailAddressController.text.isNotEmpty));
    phoneNumberController.addListener(() => setState(() => phoneNumberShowClearButton = phoneNumberController.text.isNotEmpty));
    countyController.addListener(() => setState(() => countyShowClearButton = countyController.text.isNotEmpty));
  }

  @override
  Widget build(BuildContext context) {
    //print(KeyboardVisibilityProvider.isKeyboardVisible(context));
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
    return WillPopScope(
      onWillPop: savePrefs,
      child: Scaffold(
        backgroundColor: appBackground,
        appBar: AppBar(
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: appBarColor,
          // Custom back button here to save prefs instead of just popping navigator stack
          leading: BackButton(onPressed: () {
            savePrefs();
            Navigator.pop(context);
          }),
          title: const Text('Settings'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                savePrefs();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(edgePad * 2, edgePad * 2, edgePad * 2, 0.0),
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    // TODO dark mode, switchlisttile
                    /*ListTile(
                      leading: const Icon(MdiIcons.eye),
                      title: const Text('Night mode'),
                      trailing: Switch(
                        value: nightMode,
                        onChanged: (value) {
                          setState(() {
                            nightMode = value;
                          });
                          _saveBools();
                        },
                      ),
                    ),
                    const SizedBox(height: paraBreak),*/

                    // Personal details
                    const Text(
                      'You can save your personal details here so you don\'t have to enter them each time you make a report.',
                      style: mTStyle,
                    ),
                    const SizedBox(height: paraBreak),
                    const Text(
                      'This information stays on your phone and is only transmitted if you email a report that includes it.',
                      style: mTStyle,
                    ),
                    const SizedBox(height: paraBreak * 2),


                    customTextFormField(
                      controller: firstNameController,
                      icon: MdiIcons.account,
                      hintText: 'First name',
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: paraBreak),
                    customTextFormField(
                      controller: lastNameController,
                      icon: MdiIcons.account,
                      hintText: 'Last name',
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: paraBreak),
                    customTextFormField(
                      controller: phoneNumberController,
                      icon: MdiIcons.phone,
                      hintText: 'Phone number',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: paraBreak),
                    customTextFormField(
                      controller: emailAddressController,
                      icon: MdiIcons.at,
                      hintText: 'Email address',
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                    ),
                    const SizedBox(height: paraBreak),
                    customTextFormField(
                      controller: countyController,
                      icon: MdiIcons.mapMarker,
                      hintText: 'County',
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: paraBreak),
                    Visibility(
                      // Only allow user toggle if dev constant not set to enforce or disable testing mode
                      visible: testingVariant || !nontestingVariant,
                      child: Column(
                        children: [
                          customDivider(),
                          const SizedBox(height: paraBreak),
                          SwitchListTile(
                            secondary: const Icon(
                              MdiIcons.testTube,
                              color: crimeRed,
                            ),
                            title: const Text(
                              'Testing mode',
                              style: mTStyle,
                            ),
                            subtitle: const Text(
                              '\nAllows you to submit made-up reports for testing purposes, and enables app features in development',
                              style: xsTStyle,
                            ),
                            activeColor: crimeRed,
                            activeTrackColor: crimeRed.withOpacity(0.5),
                            value: globTestMode,
                            onChanged: (value) {
                              setState(() {
                                globTestMode = value;
                                testModePref = value;
                                didPrefsChange = true;
                              });
                              saveBools();
                            },
                          ),
                          const SizedBox(height: paraBreak),
                        ],
                      ),
                    ),


                    /*ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: crimeRed,
                      ),
                      title: Column(
                        children: [
                          const Text(
                            'First name',
                            style: compactText,
                            textAlign: TextAlign.left,
                          ),
                          TextFormField(
                            controller: firstNameController,
                            // .name seems to disable non-ASCII chars on iOS.
                            // TODO resolve implications for bug gh#72 and maybe gh#42
                            //keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              suffixIcon: _firstNameGetClearButton(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: paraBreak),
                    const Text(
                      'Last name',
                      style: compactText,
                    ),
                    TextFormField(
                      controller: lastNameController,
                      // .name seems to disable non-ASCII chars on iOS.
                      //keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        suffixIcon: _lastNameGetClearButton(),
                      ),
                    ),

                    const SizedBox(height: paraBreak),
                    const Text(
                      'Email address',
                      style: compactText,
                    ),
                    TextFormField(
                      //key: _emailAddressKey,
                      controller: emailAddressController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        suffixIcon: _emailAddressGetClearButton(),
                      ),
                      // TODO decide about email validation here and quickreport
                      /* This was broken and not that useful, so scrapped
                      validator: (value) {
                        if (!emailRegExp.hasMatch(_emailAddressController.text)) {
                          return 'Please use a valid email address';
                        } else {
                          return null;
                        }
                      }*/
                    ),
                    const SizedBox(height: paraBreak),

                    const Text(
                      'Phone number',
                      style: compactText,
                    ),
                    TextFormField(
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        suffixIcon: _phoneNumberGetClearButton(),
                      ),
                    ),
                    const SizedBox(height: paraBreak),
                    const Text(
                      'County',
                      style: compactText,
                    ),
                    TextFormField(
                      controller: countyController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        suffixIcon: _countyGetClearButton(),
                      ),
                    ),
                    const SizedBox(height: paraBreak),*/

                    /*SwitchListTile(
                      secondary: const Icon(MdiIcons.cellphoneInformation),
                      title: const Text(
                        'Skip introduction screen on launch',
                        style: smallerText,
                      ),
                      value: hideIntroScreen,
                      onChanged: (value) {
                        setState(() {
                          hideIntroScreen = value;
                        });
                        _saveBools();
                      },
                    ),*/
                  ],
                ),
              ),
            ),

            // Non-scrolling bottom sheet
            // TODO spin off if using on tree screens
            Visibility(
              visible: !isKeyboardVisible,
              child: Container(
                //color: Colors.white,
                child: Row(
                  children: <Widget>[
                    PillButton(
                      buttonType: PillButtonType.highlight,
                      buttonText: 'Save',
                      pressFunction: () {
                        savePrefs();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('DISPOSE Settings');

    // Dispose of controllers
    try {
      firstNameController.dispose();
      lastNameController.dispose();
      emailAddressController.dispose();
      phoneNumberController.dispose();
      countyController.dispose();
    } catch (e) {
      print('ERROR disposing of controllers on Settings: $e');
    }

    super.dispose();
  }
}
