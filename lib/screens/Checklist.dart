import '../exports_config.dart';

class ChecklistFormModel {
  bool evidenceDeadbadger = false;
  bool evidenceDeadother = false;
  bool evidenceSettbefore = false;
  bool evidenceTrailcam = false;
  bool evidenceDrone = false;
  bool evidenceSketchmap = false;
  String evidenceOtherText = '';
}

class Checklist extends StatefulWidget {
  @override
  State<Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  final GlobalKey<FormState> _formKeyChecklist = GlobalKey<FormState>();
  ChecklistFormModel model = ChecklistFormModel();

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    LiveReport liveReport = LiveReport();
    if (ModalRoute.of(context)?.settings.arguments != null) {
      final LiveReport receivedData = ModalRoute.of(context)?.settings.arguments as LiveReport;
      liveReport = receivedData;

      // Wording of "people, vehicles, actions" checklist varies so determine which it should be
      liveReport.decidePvaChecklistWording();

      // Align our form fields to the liveReport, since we may have arrived here from a subchecklist and these were already filled
      model.evidenceDeadbadger = liveReport.activeReport.evidenceDeadbadger;
      model.evidenceDeadother = liveReport.activeReport.evidenceDeadother;
      model.evidenceSettbefore = liveReport.activeReport.evidenceSettbefore;
      model.evidenceTrailcam = liveReport.activeReport.evidenceTrailcam;
      model.evidenceDrone = liveReport.activeReport.evidenceDrone;
      model.evidenceSketchmap = liveReport.activeReport.evidenceSketchmap;
      model.evidenceOtherText = liveReport.activeReport.evidenceOtherText;
      print('receivedData on screen Checklist:   $receivedData');
      print('liveReport on screen Checklist:   $liveReport');
    } else {
      print(Error.noArgsForLiveReport);
    }
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: appBarColor,
        title: const Text('Evidence checklist'),
      ),
      body: Center(
        child: Form(
          key: _formKeyChecklist,
          child: ListView(
            padding: const EdgeInsets.all(edgePad),
            children: <Widget>[
              const SizedBox(height: paraBreak),
              const Text(
                'Listed below are the important things to document.',
                style: mTStyle,
              ),
              const SizedBox(height: paraBreak),
              const Text(
                'If possible and only if safe to do so, tap to document:',
                style: mTStyle,
              ),
              const SizedBox(height: smallBreak),
              Visibility(
                // Animal in situ
                // visible when coming from:
                //  Baiting > Injured badger
                //  Traps/snares > All except on run/sett
                //  Shooting/lamping > Shot/lamped badger
                //  Poison > badger
                visible: (liveReport.activeReport.incidentType == IncidentType.baiting &&
                          liveReport.activeReport.bbType == BbType.injured) ||
                         (liveReport.activeReport.incidentType == IncidentType.trapssnares &&
                          liveReport.activeReport.tsCircs != TsCircs.onrunsett) ||
                         (liveReport.activeReport.incidentType == IncidentType.shootlamp &&
                          liveReport.activeReport.slType == SlType.injured) ||
                         (liveReport.activeReport.incidentType == IncidentType.poison &&
                          liveReport.activeReport.psType == PsType.badger),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(outsideButton),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: buttonHeight2),
                          child: ElevatedButton(
                            style: lbButton,
                            onPressed: () async {
                              var returnedSubChecklistLiveReport = await Navigator.of(context).pushNamed(sChecklistAnimal, arguments: liveReport);
                              // Using BuildContext from a StatefulWidget so check mounted property after an async gap
                              if (!mounted) return;
                              // pushNamed returns dynamic type even though we know it should be a LiveReport here, so we either need to cast or check
                              if(returnedSubChecklistLiveReport is LiveReport) {
                                liveReport = returnedSubChecklistLiveReport;
                              } else {
                                print('ERROR with returnedSubChecklistLiveReport\n$returnedSubChecklistLiveReport');
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(insideButton),
                              child: Text('The animal in situ', textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                // Poison
                // visible when coming from:
                //  Poison
                visible: liveReport.activeReport.incidentType == IncidentType.poison,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(outsideButton),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: buttonHeight2),
                          child: ElevatedButton(
                            style: lbButton,
                            onPressed: () async {
                              var returnedSubChecklistLiveReport = await Navigator.of(context).pushNamed(sChecklistPoison, arguments: liveReport);
                              // Using BuildContext from a StatefulWidget so check mounted property after an async gap
                              if (!mounted) return;
                              // pushNamed returns dynamic type even though we know it should be a LiveReport here, so we either need to cast or check
                              if(returnedSubChecklistLiveReport is LiveReport) {
                                liveReport = returnedSubChecklistLiveReport;
                              } else {
                                print('ERROR with returnedSubChecklistLiveReport\n$returnedSubChecklistLiveReport');
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(insideButton),
                              child: Text(
                                liveReport.activeReport.psType == PsType.badger
                                    ? 'The substance in situ (where appliciable)'
                                    : 'The substance in situ',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                // Trap or snare in situ
                // visible when coming from:
                //  Traps/snares
                visible: liveReport.activeReport.incidentType == IncidentType.trapssnares,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(outsideButton),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: buttonHeight2),
                          child: ElevatedButton(
                            style: lbButton,
                            onPressed: () async {
                              var returnedSubChecklistLiveReport = await Navigator.of(context).pushNamed(sChecklistTrapsnare, arguments: liveReport);
                              // Using BuildContext from a StatefulWidget so check mounted property after an async gap
                              if (!mounted) return;
                              // pushNamed returns dynamic type even though we know it should be a LiveReport here, so we either need to cast or check
                              if(returnedSubChecklistLiveReport is LiveReport) {
                                liveReport = returnedSubChecklistLiveReport;
                              } else {
                                print('ERROR with returnedSubChecklistLiveReport\n$returnedSubChecklistLiveReport');
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(insideButton),
                              child: Text('Traps or snares in situ', textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                // People, vehicles and actions
                // visible when coming from:
                //  Sett interference (+ where applicable)
                //  Badger baiting
                //  Traps/snares (y2)
                //  Shooting/lamping
                //  Poison (y2)
                visible: liveReport.activeReport.incidentType == IncidentType.settinterf
                      || liveReport.activeReport.incidentType == IncidentType.baiting
                      || liveReport.activeReport.incidentType == IncidentType.trapssnares
                      || liveReport.activeReport.incidentType == IncidentType.shootlamp
                      || liveReport.activeReport.incidentType == IncidentType.poison,
                // Wording of the button for this checklist is decided by a
                // method in LiveReport that sets a field pvaChecklistWording
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(outsideButton),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: buttonHeight2),
                          child: ElevatedButton(
                            style: lbButton,
                            onPressed: () async {
                              var returnedSubChecklistLiveReport = await Navigator.of(context).pushNamed(sChecklistHuman, arguments: liveReport);
                              // Using BuildContext from a StatefulWidget so check mounted property after an async gap
                              if (!mounted) return;
                              // pushNamed returns dynamic type even though we know it should be a LiveReport here, so we either need to cast or check
                              if(returnedSubChecklistLiveReport is LiveReport) {
                                liveReport = returnedSubChecklistLiveReport;
                              } else {
                                print('ERROR with returnedSubChecklistLiveReport\n$returnedSubChecklistLiveReport');
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(insideButton),
                              // Title of this button differs according to flags, so is set in the liveReport
                              // when this screen builds
                              child: Text(liveReport.pvaChecklistWording, textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                // Aftermath of sett interference
                // visible when coming from:
                //  Sett interference
                //  Badger baiting
                visible: liveReport.activeReport.incidentType == IncidentType.settinterf
                      || liveReport.activeReport.incidentType == IncidentType.baiting,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(outsideButton),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: buttonHeight2),
                          child: ElevatedButton(
                            style: lbButton,
                            onPressed: () async {
                              var returnedSubChecklistLiveReport = await Navigator.of(context).pushNamed(sChecklistAftermath, arguments: liveReport);
                              // Using BuildContext from a StatefulWidget so check mounted property after an async gap
                              if (!mounted) return;
                              // pushNamed returns dynamic type even though we know it should be a LiveReport here, so we either need to cast or check
                              if(returnedSubChecklistLiveReport is LiveReport) {
                                liveReport = returnedSubChecklistLiveReport;
                              } else {
                                print('ERROR with returnedSubChecklistLiveReport\n$returnedSubChecklistLiveReport');
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(insideButton),
                              child: Text(
                                liveReport.activeReport.incidentType == IncidentType.baiting
                                    ? 'The aftermath of sett interference (where applicable)'
                                    : 'The aftermath of sett interference',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                // TODO Badger activity at the sett
                // visible when coming from:
                //  Sett interference
                //  Badger baiting
                //  Traps/snares
                visible: liveReport.activeReport.incidentType == IncidentType.settinterf
                      || liveReport.activeReport.incidentType == IncidentType.baiting
                      || liveReport.activeReport.incidentType == IncidentType.trapssnares,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(outsideButton),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: buttonHeight2),
                          child: ElevatedButton(
                            style: lbButton,
                            onPressed: () async {
                              var returnedSubChecklistLiveReport = await Navigator.of(context).pushNamed(sChecklistBadgeractivity, arguments: liveReport);
                              // Using BuildContext from a StatefulWidget so check mounted property after an async gap
                              if (!mounted) return;
                              // pushNamed returns dynamic type even though we know it should be a LiveReport here, so we either need to cast or check
                              if(returnedSubChecklistLiveReport is LiveReport) {
                                liveReport = returnedSubChecklistLiveReport;
                              } else {
                                print('ERROR with returnedSubChecklistLiveReport\n$returnedSubChecklistLiveReport');
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(insideButton),
                              child: Text(
                                liveReport.activeReport.incidentType == IncidentType.settinterf
                                    ? 'Evidence of badger\nactivity at the sett'
                                    : 'Evidence of badger\nactivity at the sett\n(where applicable)',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: paraBreak),
              const Text(
                'Do you have any additional types of evidence? Tick all that apply:',
                style: mTBold,
              ),
              const SizedBox(height: paraBreak),

              // visible when coming from:
              //  Sett interference
              //  Badger baiting > right now / in the past
              //  Traps and snares > on run/sett
              //  Shooting or lamping > right now / have witnessed
              //  Poison > substance not at/near sett
              Visibility(
                visible: liveReport.activeReport.incidentType == IncidentType.settinterf ||
                        (liveReport.activeReport.incidentType == IncidentType.baiting &&
                         liveReport.activeReport.bbType == BbType.rightnow) ||
                        (liveReport.activeReport.incidentType == IncidentType.trapssnares &&
                         liveReport.activeReport.tsCircs == TsCircs.onrunsett) ||
                        (liveReport.activeReport.incidentType == IncidentType.shootlamp &&
                          (liveReport.activeReport.slType == SlType.rightnow ||
                           liveReport.activeReport.slType == SlType.past)
                        ) ||
                        (liveReport.activeReport.incidentType == IncidentType.poison ||
                         liveReport.activeReport.psType == PsType.substance),
                child: CheckboxListTile(
                  title: const Text('Photos or videos of a dead or injured badger'),
                  value: model.evidenceDeadbadger,
                  onChanged: (value) => setState(() {
                    model.evidenceDeadbadger = value!;
                    liveReport.activeReport.evidenceDeadbadger = model.evidenceDeadbadger;
                  }),
                ),
              ),

              // visible for all
              CheckboxListTile(
                title: const Text('Photos or videos of another dead or injured animal'),
                value: model.evidenceDeadother,
                onChanged: (value) => setState(() {
                  model.evidenceDeadother = value!;
                  liveReport.activeReport.evidenceDeadother = model.evidenceDeadother;
                }),
              ),

              // Two sett-releated options
              // visible when coming from:
              //  Sett interference
              //  Badger baiting
              Visibility(
                visible: liveReport.activeReport.incidentType == IncidentType.settinterf ||
                         liveReport.activeReport.incidentType == IncidentType.baiting,
                child: CheckboxListTile(
                  title: const Text('Photos or videos of the sett taken before sett interference'),
                  value: model.evidenceSettbefore,
                  onChanged: (value) => setState(() {
                    model.evidenceSettbefore = value!;
                    liveReport.activeReport.evidenceSettbefore = model.evidenceSettbefore;
                  }),
                ),
              ),
              Visibility(
                visible: liveReport.activeReport.incidentType == IncidentType.settinterf ||
                         liveReport.activeReport.incidentType == IncidentType.baiting,
                child: CheckboxListTile(
                  title: const Text('Trail camera footage of badgers at the sett taken before sett interference'),
                  value: model.evidenceTrailcam,
                  onChanged: (value) => setState(() {
                    model.evidenceTrailcam = value!;
                    liveReport.activeReport.evidenceTrailcam = model.evidenceTrailcam;
                  }),
                ),
              ),

              CheckboxListTile(
                title: const Text('Aerial or drone footage'),
                value: model.evidenceDrone,
                onChanged: (value) => setState(() {
                  model.evidenceDrone = value!;
                  liveReport.activeReport.evidenceDrone = model.evidenceDrone;
                }),
              ),
              CheckboxListTile(
                title: const Text('Sketch map'),
                value: model.evidenceSketchmap,
                onChanged: (value) => setState(() {
                  model.evidenceSketchmap = value!;
                  liveReport.activeReport.evidenceSketchmap = model.evidenceSketchmap;
                }),
              ),
              const SizedBox(height: paraBreak),
              const Text(
                'Other: please specify',
                style: mTStyle,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(),
                  ),
                ),
                initialValue: '',
                onSaved: (value) => model.evidenceOtherText = value!
              ),
              const SizedBox(height: paraBreak),
              const Text(
                'Store your photos and videos securely. Do not edit or alter them in any way.',
                style: mTStyle,
              ),
              const SizedBox(height: paraBreak),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        width: 90,
                        child: ElevatedButton(
                          style: pillButton,
                          onPressed: () {
                            _formKeyChecklist.currentState!.save();
                            liveReport.activeReport.evidenceDeadbadger = model.evidenceDeadbadger;
                            liveReport.activeReport.evidenceDeadother = model.evidenceDeadother;
                            liveReport.activeReport.evidenceSettbefore = model.evidenceSettbefore;
                            liveReport.activeReport.evidenceTrailcam = model.evidenceTrailcam;
                            liveReport.activeReport.evidenceDrone = model.evidenceDrone;
                            liveReport.activeReport.evidenceSketchmap = model.evidenceSketchmap;
                            liveReport.activeReport.evidenceOtherText = model.evidenceOtherText;
                            Navigator.of(context).pushNamed(sQuickReport, arguments: liveReport);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(insideButton),
                            child: Text('Next', textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
