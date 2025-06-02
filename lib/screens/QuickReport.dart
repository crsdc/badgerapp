import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
//import 'package:latlong2/latlong.dart';
import 'package:latlong_to_osgrid/latlong_to_osgrid.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exports_config.dart';

class QuickReportFormModel {
  // Similar to but doesn't quite mirror the database model for Reports

  String mnemonicLabel = '';

  IncidentType incidentType = IncidentType.blank;
  // TODO implement sub checklists that come up if you select via quickreport

  String userNarrative = '';
  bool policeReport = false; // radio buttons
  String crimeReference = ''; // text field that appears conditional on policeReport = true

  DateTime? incidentDate;
  //DateTime incidentDate = DateTime.now();
  //Timestamp incidentDateTS;
  //DateTime incidentDate = DateTime.now(); // if we want it to default to today's date

  //double latitude; not currently implemented
  //double longitude; not currently implemented
  String gridRefText = ''; // crude way of handling it for now
  //String what3Words; not currently implemented
  String nearestTown = '';
  String county = '';

  String firstName = '';
  String lastName = '';
  String emailAddress = '';
  String phoneNumber = '';

  bool permission = false;
}

class QuickReport extends StatefulWidget {
  @override
  State<QuickReport> createState() => _QuickReportState();
}

class _QuickReportState extends State<QuickReport> {
  final ReportRepository _reportRepository = GetIt.I.get();

  final GlobalKey<FormState> _formKeyQuickReport = GlobalKey<FormState>();
  QuickReportFormModel model = QuickReportFormModel();

  bool? _dropdownValid;
  bool _dropdownError = false;
  bool saveAttempted = false;
  String _dateDisplay = 'Select date';

  LatLongConverter converter = LatLongConverter();

  // Controllers so prefs code can read the text fields
  final TextEditingController _mnemonicLabelController = TextEditingController();
  final TextEditingController _userNarrativeController = TextEditingController();
  final TextEditingController _crimeReferenceController = TextEditingController();
  final TextEditingController _gridRefTextController = TextEditingController();
  final TextEditingController _nearestTownController = TextEditingController();
  final TextEditingController _countyController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  // Fill in personal details fields from stored preferences
  Future<void> _retrievePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // TODO only paste these in if we aren't getting them from the live report, e.g. when loading a draft
      model.firstName = prefs.getString('firstName') ?? '';
      _firstNameController.text = model.firstName;
      model.lastName = prefs.getString('lastName') ?? '';
      _lastNameController.text = model.lastName;
      model.emailAddress = prefs.getString('emailAddress') ?? '';
      _emailAddressController.text = model.emailAddress;
      model.phoneNumber = prefs.getString('phoneNumber') ?? '';
      _phoneNumberController.text = model.phoneNumber;
      model.county = prefs.getString('county') ?? '';
      _countyController.text = model.county;

      // TODO harmonise this with the way the map handles grid ref text
      model.gridRefText = latLongToOSNumeric(liveReport.activeReport.latitude, liveReport.activeReport.longitude);
      _gridRefTextController.text = model.gridRefText;
    });
  }

  // For this screen we need to have our liveReport accessible outside widget build
  LiveReport liveReport = LiveReport();

  // TODO spin this off and make consistent with everywhere else
  String latLongToOSNumeric(double lat, double long) {
    if (lat < 49.85 || lat > 56 || long < -6.5 || long > 2) {
      return '';
    } else {
      var result = converter.getOSGBfromDec(lat, long);
      //return "${result.easting} ${result.northing}";
      return result.letterRef;
    }
  }

  @override
  void initState() {
    super.initState();
    _retrievePrefs();
  }

  @override
  Widget build(BuildContext context) {
    print('begin building QuickReport');
    if (ModalRoute.of(context)?.settings.arguments != null) {
      // If we came from the tree (or back from EmailPreview after QuickReport) we should have a report to load up
      final LiveReport receivedData = ModalRoute.of(context)?.settings.arguments as LiveReport;
      liveReport = receivedData;
      print(liveReport);
      model.incidentType = liveReport.activeReport.incidentType;
      print('### 1 liveReport.activeReport.userNarrative = ${liveReport.activeReport.userNarrative}');
      if (liveReport.activeReport.userNarrative != '') {
        model.userNarrative = liveReport.activeReport.userNarrative;
        _userNarrativeController.text = model.userNarrative;
      }
      print('### 1 liveReport.activeReport.incidentDateStr = ${liveReport.activeReport.incidentDateStr}');
      if (liveReport.activeReport.incidentDateStr != '') {
        print('A $_dateDisplay');
        _dateDisplay = liveReport.activeReport.incidentDateStr;
        // TODO SPIN OFF THE BIT IN REPORTS THAT MAKES THIS NICE - where else is it used though?
        String niceDate = _dateDisplay.substring(8,10);
        niceDate += ' ';
        niceDate += intToMMM(int.parse(_dateDisplay.substring(5,7)));
        niceDate += ' ';
        niceDate += _dateDisplay.substring(0,4);

        // This may be where date clipping was happening
        // Trim leading zero on date, if present      - gh#76 ???
        //niceDate[0] == '1' ? _dateDisplay = niceDate: _dateDisplay = niceDate.substring(1);
        if (niceDate[0] == '0') {
          _dateDisplay = niceDate.substring(1);
        } else {
          _dateDisplay = niceDate;
        }

        print('B $_dateDisplay');
        print('### 2 liveReport.activeReport.incidentDateStr = ${liveReport.activeReport.incidentDateStr}');
        model.incidentDate = DateTime.parse(liveReport.activeReport.incidentDateStr);
        print('### 3 liveReport.activeReport.incidentDateStr = ${liveReport.activeReport.incidentDateStr}');
      }
      if (liveReport.activeReport.gridRefText != '') {
        model.gridRefText = liveReport.activeReport.gridRefText;
        _gridRefTextController.text = model.gridRefText;
      }
      if (liveReport.activeReport.nearestTown != '') {
        model.nearestTown = liveReport.activeReport.nearestTown;
        _nearestTownController.text = model.nearestTown;
      }
      if (liveReport.activeReport.county != '') {
        model.county = liveReport.activeReport.county;
        _countyController.text = model.county;
      }
      if (liveReport.activeReport.crimeReference != '') {
        // If we've been passed a crime reference or police incident number from 999 screen
        // set police report flag true and display crime ref field on the form
        liveReport.activeReport.policeReport = true;
        model.policeReport = true;
        model.crimeReference = liveReport.activeReport.crimeReference;
        _crimeReferenceController.text = model.crimeReference;
      }
      if (liveReport.activeReport.firstName != '') {
        model.firstName = liveReport.activeReport.firstName;
        _firstNameController.text = model.firstName;
      }
      if (liveReport.activeReport.lastName != '') {
        model.lastName = liveReport.activeReport.lastName;
        _lastNameController.text = model.lastName;
      }
      if (liveReport.activeReport.emailAddress != '') {
        model.emailAddress = liveReport.activeReport.emailAddress;
        _emailAddressController.text = model.emailAddress;
      }
      if (liveReport.activeReport.phoneNumber != '') {
        model.phoneNumber = liveReport.activeReport.phoneNumber;
        _phoneNumberController.text = model.phoneNumber;
      }
      if (liveReport.activeReport.mnemonicLabel != '') {
        model.mnemonicLabel = liveReport.activeReport.mnemonicLabel;
        _mnemonicLabelController.text = model.mnemonicLabel;
      }

      // Assemble the generated text by looking at the flags and variables we've accumulated
      liveReport.genSummary();
      liveReport.genEvidencePara();
      liveReport.genEvidenceList();
      //print('From QuickReport widget builder, our liveReport.generatedSummary is\n${liveReport.generatedSummary}');

      // If we've been passed an incident type we won't be showing the dropdown for this and can skip its validation
      if (liveReport.activeReport.incidentType != IncidentType.blank) {
        _dropdownValid = true;
      }
      //print('receivedData on screen QuickReport:   $receivedData');
      //print('liveReport on screen QuickReport:   $liveReport');
    } else {
      // If we came from the home screen we're unable to populate our liveReport but we'll start building it here
      print('QUICKREPORT: No liveReport passed so begin a new one');
      liveReport = LiveReport.fresh();
      //liveReport.activeReport.whenCreated = DateTime.now().toString();
      //liveReport.activeReport.appVersionCreated = appVersion;
      liveReport.quickReportFlag = true;
    }
    //model.policeReport ? print('model.policeReport TRUE') : print('model.policeReport FALSE');

    return WillPopScope(
      // TODO be sure back button is intercepted to save draft
      onWillPop: () async {
        return true;
        /*if (liveReport.quickReportFlag) {
          Navigator.of(context).pushNamed(sHomeScreen);
        } else {
          Navigator.of(context).pushNamed(sChecklist, arguments: liveReport);
        }
        return false;*/
      },
      child: Scaffold(
        backgroundColor: appBackground,
        appBar: AppBar(
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: appBarColor,
          title: const Text('Incident report'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // TODO spin this off
                // Prompt to save draft if press home button
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Unfinished report'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            const Text(
                                'Would you like to save this report as a draft so you can finish it later?'),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, outsideButton, 0.0, 0.0),
                              child: SizedBox(
                                height: 36,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                        MdiIcons.bookMarker),
                                    hintText: 'Report name',
                                    fillColor: Colors.white,
                                    filled: true,
                                    //suffixIcon: _clearButton(), FIXME reinstate
                                    //contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: outsideButton),
                                  ),
                                  controller: _mnemonicLabelController,
                                  onSaved: (value) => model.mnemonicLabel = value!,
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        /*TextButton(
                          child: Text('CANCEL'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),*/
                        TextButton(
                          child: const Text('NO'),
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(sHomeScreen, (route) => false);
                          },
                        ),
                        TextButton(
                          // TODO can't save if nothing written, and should disable button
                          child: const Text('YES'),
                          onPressed: () {
                            if (_mnemonicLabelController.text != '') {
                              print('save the location');
                              _formKeyQuickReport.currentState!.save();
                              _saveReport(suppressSnackbar: false);
                              Navigator.of(context).pushNamedAndRemoveUntil(sHomeScreen, (route) => false);
                            }
                          },
                        ),

                      ],
                    );
                  },
                );
              },
            ),
          ],
          /*automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (liveReport.quickReportFlag) {
                Navigator.of(context).pushNamed(sHomeScreen);
              } else {
                Navigator.of(context).pushNamed(sChecklist, arguments: liveReport);
              }
            }
          ),*/
        ),
        body: Center(
          child: Form(
            key: _formKeyQuickReport,
            child: Scrollbar(
              thumbVisibility: true,
              //isAlwaysShown: true,
              child: ListView(
                //padding: const EdgeInsets.all(edgePad),
                padding: const EdgeInsets.fromLTRB(edgePad, edgePad, edgePad + 4, edgePad), // +4 on right because of permanent scrollbar
                children: <Widget>[
                  const SizedBox(height: smallBreak),

                  // Type of incident dropdown if we didn't arrive from the tree
                  Visibility(
                    visible: liveReport.quickReportFlag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Type of incident',
                          style: mTBold,
                        ),
                        const SizedBox(height: smallBreak),

                        DropdownButton<IncidentType>(
                          //value: liveReport.activeReport.incidentType.index,
                          value: model.incidentType,
                          //isExpanded: true, // this makes it span the width of the screen
                          icon: const Icon(Icons.keyboard_arrow_down, size: 24.0),
                          underline: const SizedBox(),
                          items: const <DropdownMenuItem<IncidentType>>[
                            DropdownMenuItem(
                              value: IncidentType.blank,
                              child: Text('Choose an option'),
                            ),
                            DropdownMenuItem(
                              value: IncidentType.settinterf,
                              child: Text('Sett interference'),
                            ),
                            DropdownMenuItem(
                              value: IncidentType.baiting,
                              child: Text('Badger baiting'),
                            ),
                            DropdownMenuItem(
                              value: IncidentType.trapssnares,
                              child: Text('Traps or snares'),
                            ),
                            DropdownMenuItem(
                              value: IncidentType.shootlamp,
                              child: Text('Shooting or lamping'),
                            ),
                            DropdownMenuItem(
                              value: IncidentType.poison,
                              child: Text('Poison'),
                            ),
                            DropdownMenuItem(
                              value: IncidentType.other,
                              child: Text('Other'),
                            ),
                          ],
                          onChanged: (IncidentType? value) {
                            print('onChanged, dropdownValid is $_dropdownValid');
                            print('type option changed from ${liveReport.activeReport.incidentType} to $value');
                            setState(() {
                              liveReport.activeReport.incidentType = value!;
                              model.incidentType = liveReport.activeReport.incidentType;
                              // When coming from tree, we only generate summary text once on getting to this screen, but in quick mode, we'll need to do it on change
                              liveReport.genSummary();
                              print ('type option now ${liveReport.activeReport.incidentType}');
                              print('setting state 1, dropdownValid is $_dropdownValid');
                              if (value != IncidentType.blank) {
                                _dropdownError = false;
                                _dropdownValid = true;
                                }
                              print('setting state 2, dropdownValid is $_dropdownValid');
                            });
                          },
                        ),
                        Visibility (
                          visible: _dropdownError,
                          child: const Text(
                            'Required',
                            style: TextStyle(fontSize: xsTSize, color: crimeRed),// TODO spin this off
                          ),
                        ),
                        const SizedBox(height: paraBreak),
                      ],
                    ),
                  ),

                  // Generated summary text if we arrived from the tree
                  Visibility(
                    visible: !liveReport.quickReportFlag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'We\'d like to send Badger Trust a report about this.',
                          style: sTStyle,
                        ),
                        const SizedBox(height: paraBreak),
                        const Text(
                          'Please check the information below and fill in some more details.',
                          style: sTStyle,
                        ),
                        const SizedBox(height: paraBreak),
                        const Text(
                          'Information you\'ve provided so far',
                          style: mTBold,
                        ),
                        const SizedBox(height: paraBreak),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: double.infinity,
                            color: softBackground,
                            child: Padding(
                              padding: const EdgeInsets.all(edgePad),
                              child: Text(
                                liveReport.generatedSummary,
                                style: xsTStyle,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: paraBreak),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: liveReport.generatedEvidencePara != '',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your notes',
                          style: sTBold,
                        ),
                        const SizedBox(height: smallBreak),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: double.infinity,
                            color: softBackground,
                            child: Padding(
                              padding: const EdgeInsets.all(edgePad),
                              child: Text(
                                liveReport.generatedEvidencePara,
                                style: xsTStyle,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: paraBreak),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: liveReport.generatedEvidenceList != '',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Evidence you have',
                          style: sTBold,
                        ),
                        const SizedBox(height: smallBreak),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: double.infinity,
                            color: softBackground,
                            child: Padding(
                              padding: const EdgeInsets.all(edgePad),
                              child: Text(
                                liveReport.generatedEvidenceList,
                                style: xsTStyle,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: paraBreak),
                      ],
                    ),
                  ),

                  // User narrative
                  Visibility(
                    visible: liveReport.quickReportFlag,
                    child: const Text(
                      // If we didn't come from the tree, dropdown above will be the only info, so we definitely want to prompt user for details
                      'Tell us more about what you\'d like to report',
                      style: sTStyle,
                    ),
                  ),
                  Visibility(
                    visible: !liveReport.quickReportFlag,
                    child: const Text(
                      // If we came from the tree
                      'Are there any more details you\'d like to include?',
                      style: sTStyle,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Further details'),
                    minLines: 1,
                    maxLines: 20,
                    controller: _userNarrativeController,
                    //initialValue: model.userNarrative,
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) => model.userNarrative = value!,
                  ),
                  const SizedBox(height: paraBreak),

                  // Date and location
                  const Text(
                    'When and where',
                    style: mTBold,
                  ),
                  const SizedBox(height: smallBreak),
                  const Text(
                    'We\'ll need the date and location of the incident. If it\'s not clear when it took place, use the date you are reporting it.',
                    style: xsTStyle,
                  ),
                  const SizedBox(height: smallBreak),
                  ListTile(
                    leading: const Icon(Icons.date_range),
                    title: Text(_dateDisplay),
                    onTap: () => _selectDate(context),
                  ),
                  /*Row(        // TODO make this an inkwell or something so we can click on the whole area
                    children:[
                      IconButton(
                        icon: const Icon(Icons.date_range),
                        iconSize: 28,
                        onPressed: () => _selectDate(context),
                      ),
                      Text(
                        "${model.incidentDate != null ? model.incidentDate?.toLocal() : 'Date'}".split(' ')[0],
                        style: const TextStyle(fontSize: bodyTextSize),
                      ),
                    ],
                  ),*/
                  const SizedBox(height: smallBreak),
                  TextFormField(
                    controller: _gridRefTextController,
                    //initialValue: 'AA 12345 54321 [default for testing]', // for testing
                    decoration: const InputDecoration(labelText: 'OS grid reference'),
                    validator: (value) { // Do we want to require this for every kind of incident??
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => model.gridRefText = value!,
                  ),
                  const SizedBox(height: smallBreak),
                  TextFormField(
                    controller: _nearestTownController,
                    //initialValue: model.nearestTown,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(labelText: 'Nearest town'),
                    onSaved: (value) => model.nearestTown = value!,
                  ),
                  const SizedBox(height: smallBreak),
                  TextFormField(
                    controller: _countyController,
                    //initialValue: 'Devon [default for testing]', // for testing
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(labelText: 'County'),
                    validator: (value) { // Do we want to require this for every kind of incident??
                      // TODO should not be required
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => model.county = value!,
                  ),
                  const SizedBox(height: paraBreak),

                  // Police
                  const Text(
                    'Have you reported the incident to the police?',
                    style: sTStyle,
                  ),
                  const SizedBox(height: smallBreak),
                  InkWell(
                    onTap: () => setState(() => model.policeReport = false),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: false,
                          groupValue: model.policeReport,
                          activeColor: appDB,
                          onChanged: (value) => setState(() => model.policeReport = false),
                        ),
                        const Text(
                          'No, or not yet',
                          style: sTStyle,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() => model.policeReport = true),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: true,
                          groupValue: model.policeReport,
                          activeColor: appDB,
                          onChanged: (value) => setState(() => model.policeReport = true),
                        ),
                        const Text(
                          'Yes',
                          style: sTStyle,
                        ),
                      ],
                    ),
                  ),
                  /*
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Yes',
                        style: compactText,
                      ),
                      Radio(
                        value: true,
                        groupValue: model.policeReport,
                        activeColor: appRed,
                        onChanged: (value) => setState(() => model.policeReport = true),
                      ),
                      const Text(
                        '     No or not yet',
                        style: compactText,
                      ),
                      Radio(
                        value: false,
                        groupValue: model.policeReport,
                        activeColor: appRed,
                        onChanged: (value) => setState(() => model.policeReport = false),
                      ),
                    ],
                  ),
                  */
                  Visibility(
                    visible: model.policeReport,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Do you have a crime reference number, or a police incident or log number?',
                          style: sTStyle,
                        ),
                        const SizedBox(height: smallBreak),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Police log or crime reference number'),
                          controller: _crimeReferenceController,
                          //initialValue: liveReport.activeReport.crimeReference,
                          onSaved: (value) => model.crimeReference = value!,
                        ),
                        const SizedBox(height: smallBreak),
                      ],
                    ),
                  ),
                  const SizedBox(height: paraBreak),

                  // Personal details
                  const Text(
                    'Your details',
                    style: mTBold,
                  ),
                  const SizedBox(height: smallBreak),
                  const Text(
                    'To follow up incidents, Badger Trust needs some contact information for you. We\'re unable to accept anonymous reports.',
                    // ADD IN IDEALLY WITH LINK Your details will be treated confidentially in accordance with Badger Trust\'s privacy policy.
                    style: xsTStyle,
                  ),
                  const SizedBox(height: smallBreak),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'First name'),
                    controller: _firstNameController,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => model.firstName = value!,
                  ),
                  const SizedBox(height: smallBreak),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Last name'),
                    controller: _lastNameController,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => model.lastName = value!,
                  ),
                  const SizedBox(height: smallBreak),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email address'),
                    controller: _emailAddressController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      } else if (!emailRegExp.hasMatch(value)) {
                        return 'Please provide a valid email address';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => model.emailAddress = value!,
                  ),
                  const SizedBox(height: smallBreak),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Phone number'),
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => model.phoneNumber = value!,
                  ),
                  const SizedBox(height: paraBreak),
                  const Text(
                    'Do you give permission for Badger Trust to pass on your information to the relevant contacts and authorities for follow-up?',
                    style: sTStyle,
                  ),
                  Visibility(
                    visible: !model.permission && saveAttempted,
                    child: const Text('\nRequired', style:TextStyle(color:crimeRed, fontSize: xsTSize)),
                  ),
                  const SizedBox(height: smallBreak),
                  // TODO either need a required to answer system, or default to yes
                  InkWell(
                    onTap: () => setState(() => model.permission = !model.permission),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: model.permission,
                          activeColor: appDB,
                          onChanged: (value) => setState(() => model.permission = !model.permission),
                        ),
                        const Text(
                          'Yes',
                          style: sTStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: paraBreak),

                  // Mnemonic
                  const Text(
                    'Report name',
                    style: mTBold,
                  ),
                  const SizedBox(height: smallBreak),
                  const Text(
                    'Would you like to save this report with a memorable name or description? This is for your use and won\'t be shared when you send your report.',
                    style: xsTStyle,
                  ),
                  const SizedBox(height: smallBreak),
                  TextFormField(
                    controller: _mnemonicLabelController,
                    decoration: const InputDecoration(labelText: 'Report name'),
                    onSaved: (value) => model.mnemonicLabel = value!,
                  ),
                  const SizedBox(height: paraBreak),

                  // Buttons
                  Row(
                    children: [
                      MenuButton(
                        buttonType: MenuButtonType.standard,
                        height: buttonHeight2,
                        buttonText: 'Save draft\nfor later',
                        pressFunction: () {
                          // let user save a draft without going through validation
                          //if (_formKeyQuickReport.currentState!.validate()) {
                          _formKeyQuickReport.currentState!.save();
                          _saveReport(suppressSnackbar: false);
                          //}
                        },
                        buttonPos: MenuButtonPos.left,
                        softWrap: true,
                      ),
                      MenuButton(
                        buttonType: MenuButtonType.highlight,
                        height: buttonHeight2,
                        buttonText: 'Next',
                        pressFunction: () {
                          print('next pressed...');
                          print('### 3 liveReport.activeReport.userNarrative = ${liveReport.activeReport.userNarrative}');
                          if (_formKeyQuickReport.currentState!.validate() && _dropdownValid == true && model.permission) {
                            print('dropdownValid was true and the form validated');
                            _formKeyQuickReport.currentState!.save();
                            // Assemble the full Report, save it to database and generate email
                            _prepareReport();
                            // Navigate to the screen where we show user preview of the email
                            print('### 7 liveReport.activeReport.userNarrative = ${liveReport.activeReport.userNarrative}');
                            print('QuickReport just before we go to email preview');
                            print(liveReport);
                            Navigator.of(context).pushNamed(sEmailPreview, arguments: liveReport);
                          } else {
                            // Either the form hasn't validated or the custom check for the dropdown hasn't
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please check you\'ve filled in the required information')));
                            setState(() {
                              saveAttempted = true;
                              if (_dropdownValid != true) {
                                // If the dropdown was part of the problem, manually show this
                                print('dropdownValid was false or null');
                                _dropdownError = true;
                              }
                            });
                          }
                        },
                        buttonPos: MenuButtonPos.right,
                        softWrap: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('DISPOSE Mapp');

    // Dispose of controllers
    try {
      _mnemonicLabelController.dispose();
      _userNarrativeController.dispose();
      _crimeReferenceController.dispose();
      _gridRefTextController.dispose();
      _nearestTownController.dispose();
      _countyController.dispose();
      _firstNameController.dispose();
      _lastNameController.dispose();
      _emailAddressController.dispose();
      _phoneNumberController.dispose();
    } catch (e) {
    print('ERROR disposing of controllers on QuickReport: $e');
    }

    super.dispose();
  }

  void _saveReport({required bool suppressSnackbar}) async {
    print('saveReport started for a report created ${liveReport.activeReport.whenCreated}');

    // convert our DateTime to a Timestamp the database can handle
    //model.incidentDateTS = Timestamp.fromDate(model.incidentDate);
    //print(model.incidentDate);
    //print(model.incidentDateTS);

    // TODO save the incidentType if we did the dropdown manually
    if (model.incidentType != IncidentType.blank) {
      liveReport.activeReport.incidentType = model.incidentType;
    }

    // assemble the rest of the Report by gathering fields from the form
    liveReport.activeReport.firstName = _firstNameController.text;
    liveReport.activeReport.lastName = _lastNameController.text;
    liveReport.activeReport.emailAddress = _emailAddressController.text;
    liveReport.activeReport.phoneNumber = _phoneNumberController.text;
    /*liveReport.activeReport.firstName = model.firstName;
    liveReport.activeReport.lastName = model.lastName;
    liveReport.activeReport.emailAddress = model.emailAddress;
    liveReport.activeReport.phoneNumber = model.phoneNumber;*/

    // Date needs to handle draft saving where nothing has been entered
    if (model.incidentDate == null) {
      liveReport.activeReport.incidentDateStr = '';
      print('incidentDate found to be null during draft saving');
    } else {
      // We only want to store date so generate ISO 8601 string and truncate it
      liveReport.activeReport.incidentDateStr = model.incidentDate.toString().substring(0, 10);
      print('incidentDate string during saving = ${liveReport.activeReport.incidentDateStr}');
    }

    // TODO fix location logic so we can save actual locations      - gh #59 ???
    //liveReport.activeReport.gridRefText = model.gridRefText;
    liveReport.activeReport.gridRefText = _gridRefTextController.text;
    liveReport.activeReport.latitude = 0.0;
    liveReport.activeReport.longitude = 0.0;
    //liveReport.activeReport.gridRefE = 11111;
    //liveReport.activeReport.gridRefN = 11111;
    // w3w
    //liveReport.activeReport.nearestTown = model.nearestTown;
    liveReport.activeReport.nearestTown = _nearestTownController.text;
    //liveReport.activeReport.county = model.county;
    liveReport.activeReport.county = _countyController.text;

    liveReport.activeReport.policeReport = model.policeReport;
    //liveReport.activeReport.crimeReference = model.crimeReference;
    liveReport.activeReport.crimeReference = _crimeReferenceController.text;

    liveReport.activeReport.permission = model.permission;

    print('### 4 liveReport.activeReport.userNarrative = ${liveReport.activeReport.userNarrative}');
    //liveReport.activeReport.userNarrative = model.userNarrative;
    liveReport.activeReport.userNarrative = _userNarrativeController.text;
    print('### 5 liveReport.activeReport.usernarrative = ${liveReport.activeReport.userNarrative}');
    //liveReport.activeReport.mnemonicLabel = model.mnemonicLabel;
    liveReport.activeReport.mnemonicLabel = _mnemonicLabelController.text;

    liveReport.activeReport.lastModified = DateTime.now().toString();
    liveReport.activeReport.appVersionLastMod = appVersion;

    // ID setting
    liveReport.activeReport.id = DateTime.parse(liveReport.activeReport.whenCreated).millisecondsSinceEpoch + 1;
    print('report ID just before we save is ${liveReport.activeReport.id}');

    // Send it to the database logic
    int saveResult = await _reportRepository.insertReport(liveReport.activeReport);
    saveResult == 0 ? print('DATABASE SAVE FAILED') : print('database saved ID $saveResult');
    if (!suppressSnackbar) {
      // Don't show snackbar if we are proceeding to email preview screen instead of just saving a draft
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Draft saved in My Reports')));
    }
    print('insertReport done');
  }

  void _prepareReport() {
    print('prepareReport started');
    // Set the flag to say this Report is complete and no longer a draft
    liveReport.activeReport.reportCompleted = true;
    // Save the report to database but don't show confirmation snackbar since we're moving to a new screen
    _saveReport(suppressSnackbar: true);
    // Before we generate the email, we need to generate summary if we don't have one, i.e. if dropdown used to specify incidentType
    if (liveReport.generatedSummary == '') {
      print('In _prepareReport, we are running genSummary before we generate the email.');
      liveReport.genSummary();
    }
    // Call the getter that generates the text of our email from the entire Report
    liveReport.generatedEmail = liveReport.genEmail;
    //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Report would send now')));
    print('### 6 liveReport.activeReport.userNarrative = ${liveReport.activeReport.userNarrative}');
  }

  // Date picker function, which should be generalised for use in other places
  _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    //assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        // Disabled cupertino picker for now. If restored, check it behaves same as Material.
        return buildMaterialDatePicker(context);
        //return buildCupertinoDatePicker(context);
    }
  }
  // Android
  buildMaterialDatePicker(BuildContext context) async {
    // if we've picked a date already, show that in the picker, otherwise default to today
    final DateTime pickedDate = model.incidentDate ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      // Previously, the picker went to today's date even when one already chosen
      //initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    if (picked != null && picked != model.incidentDate) {
      setState(() {
        model.incidentDate = picked;
        liveReport.activeReport.incidentDateStr = model.incidentDate.toString().substring(0, 10);
        _dateDisplay = '${picked.day} ${intToMMM(picked.month)} ${picked.year}';
      });
    }
  }
  //iOS
  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery
                .of(context)
                .copyWith()
                .size
                .height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != model.incidentDate) {
                  setState(() {
                    model.incidentDate = picked;
                    liveReport.activeReport.incidentDateStr = model.incidentDate.toString().substring(0, 10);
                    _dateDisplay = '${picked.day} ${intToMMM(picked.month)} ${picked.year}';
                  });
                }
              },
              initialDateTime: model.incidentDate,
              minimumYear: 2022,
              maximumYear: DateTime.now().year,
            ),
          );
        }
    );
  }

}
