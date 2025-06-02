import '../exports_config.dart';

class ChecklistBadgeractivityFormModel {
  String evidenceBadgeractivityText = '';
  bool evidenceBadgeractivityPhotos = false;
  bool evidenceBadgersignEntrance = false;
  bool evidenceBadgersignSpoil = false;
  bool evidenceBadgersignBedding = false;
  bool evidenceBadgersignPawprints = false;
  bool evidenceBadgersignHair = false;
  bool evidenceBadgersignScratch = false;
  bool evidenceBadgersignLatrine = false;
  bool evidenceBadgersignRun = false;
  bool evidenceBadgersignForaging = false;
}

class ChecklistBadgeractivity extends StatefulWidget {
  @override
  State<ChecklistBadgeractivity> createState() => _ChecklistBadgeractivityState();
}

class _ChecklistBadgeractivityState extends State<ChecklistBadgeractivity> {
  final GlobalKey<FormState> _formKeyChecklistBadgeractivity = GlobalKey<FormState>();
  ChecklistBadgeractivityFormModel model = ChecklistBadgeractivityFormModel();

  LiveReport liveReport = LiveReport();

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {

    // Maintain a LiveReport if we've arrived here from the tree, not from Home
    LiveReport liveReport = LiveReport();
    if (ModalRoute.of(context)?.settings.arguments != null) {
      final LiveReport receivedData = ModalRoute.of(context)?.settings.arguments as LiveReport;
      liveReport = receivedData;
      // Populate form from liveReport as we could be back on this screen after being here before
      model.evidenceBadgeractivityText = liveReport.activeReport.evidenceBadgeractivityText;
      model.evidenceBadgeractivityPhotos = liveReport.activeReport.evidenceBadgeractivityPhotos;
      model.evidenceBadgersignEntrance = liveReport.activeReport.evidenceBadgeractivitySignEntrance;
      model.evidenceBadgersignSpoil = liveReport.activeReport.evidenceBadgeractivitySignSpoil;
      model.evidenceBadgersignBedding = liveReport.activeReport.evidenceBadgeractivitySignBedding;
      model.evidenceBadgersignPawprints = liveReport.activeReport.evidenceBadgeractivitySignPawprints;
      model.evidenceBadgersignHair = liveReport.activeReport.evidenceBadgeractivitySignHair;
      model.evidenceBadgersignScratch = liveReport.activeReport.evidenceBadgeractivitySignScratch;
      model.evidenceBadgersignLatrine = liveReport.activeReport.evidenceBadgeractivitySignLatrine;
      model.evidenceBadgersignRun = liveReport.activeReport.evidenceBadgeractivitySignRun;
      model.evidenceBadgersignForaging = liveReport.activeReport.evidenceBadgeractivitySignForaging;
      print('receivedData on screen ChecklistBadgeractivity:   $receivedData');
      print('liveReport on screen ChecklistBadgeractivity:   $liveReport');
    } else {
      print('NO LIVEREPORT, which should mean we came here direct instead of from the tree');
    }

    // Decide what to display in app bar based on where we've come from
    PreferredSizeWidget? appBarChecklistBadgeractivity() {
      // TODO probably shouldn't be a switch
      switch (liveReport.activeReport.incidentType) {
        case IncidentType.blank:
          return appBarOneLineWithHome(
                titleText: 'Identify a sett',
                context: context,
              );
            /*title: const Text(
              'Identify a\nbadger sett',
              style: appBarTwoLine,
              textAlign: TextAlign.center,
            ),*/
        default:
          return AppBar(
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: appBarColor,
            title: const Text(
              'Evidence:\nBadger activity',
              style: appBarTwoLine,
              textAlign: TextAlign.center,
            ),
          );
/*        default:
          print(Error.arrivedScreenShouldnt);
          print('...on screen Injuredbadg');
          return appBarTwoLineWithHome(
              titleText: Error.arrivedScreenShouldnt,
              context: context
          );*/
      }
    }

    return Scaffold(
      backgroundColor: appBackground,
      appBar: appBarChecklistBadgeractivity(),
      body: Center(
        child: Form(
          key: _formKeyChecklistBadgeractivity,
          child: ListView(
            children: [
              Padding(
                padding: outsideButtonAll,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [



                    // From evidence checklist
                    Visibility(
                      visible: liveReport.activeReport.incidentType != IncidentType.blank,
                      child: Column(
                        children: [
                          const Text(
                            'Where a badger sett has been interfered with, evidence that the sett was in use by badgers at the time of the offence is crucial. Such evidence of "current use" must be gathered as soon as possible.',
                            style: mTStyle,
                          ),
                          const SizedBox(height: paraBreak),
                          RichText(
                            textScaleFactor: MediaQuery.of(context).textScaleFactor,
                            text: TextSpan(
                              style: mTStyle,
                              children: [
                                const TextSpan(text: 'Badger setts are defined in the Protection of Badgers Act 1992 as "any structure or place which displays signs indicating current use by a badger" '),
                                legLink(Legislation.poba92s14, 14, context),
                                const TextSpan(text: '. Human interference may have already damaged part of the sett. However, if any part of the sett displays signs indicating current use, the sett may be considered in current use.'),
                              ],
                            ),
                          ),
                          const SizedBox(height: paraBreak),
                          const Text(
                            'If possible and only if safe to do so, look for and document as many of these badger field signs as possible.\n',
                            style: mTBold,
                          ),
                          const SizedBox(height: paraBreak),
                          const Text(
                            'Tap each field sign that\'s present.\n',
                            style: mTStyle,
                          ),
                        ],
                      ),
                    ),

                    // Identify a badger sett, from home page
                    Visibility(
                      visible: liveReport.activeReport.incidentType == IncidentType.blank,
                      child: RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          style: mTStyle,
                          children: [
                            const TextSpan(text: 'These field signs of badger activity can help you identify an active sett.'),
                            paraBreakText(),
                            const TextSpan(text: 'Tap for more information:\n'),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: liveReport.activeReport.incidentType == IncidentType.blank,
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: insideButton,
                        mainAxisSpacing: insideButton,
                        children: [
                          badgerSignInfoTile(BadgerSign.entrance, imgSignsEntrance, 'Open sett entrance', context),
                          badgerSignInfoTile(BadgerSign.spoil, imgSignsSpoil, 'Fresh spoil heap', context),
                          badgerSignInfoTile(BadgerSign.bedding, imgSignsBedding, 'Bedding', context),
                          badgerSignInfoTile(BadgerSign.pawprints, imgSignsPawprint, 'Pawprint', context),
                          badgerSignInfoTile(BadgerSign.hair, imgSignsHair, 'Hair', context),
                          badgerSignInfoTile(BadgerSign.scratch, imgSignsScratch, 'Scratch marks', context),
                          badgerSignInfoTile(BadgerSign.latrine, imgSignsLatrine, 'Latrine', context),
                          badgerSignInfoTile(BadgerSign.run, imgSignsRun, 'Well-used run', context),
                          badgerSignInfoTile(BadgerSign.foraging, imgSignsForaging, 'Foraging signs', context),
                        ],
                      ),
                    ),

                    Visibility(
                      visible: liveReport.activeReport.incidentType != IncidentType.blank,
                      child: Column(
                        //shrinkWrap: true,
                        //crossAxisCount: 3,
                        //crossAxisSpacing: insideButton,
                        //mainAxisSpacing: insideButton,
                        children: [
                          BadgerSignListTile(BadgerSign.entrance, imgSignsEntrance, 'Open sett entrance', model, model.evidenceBadgersignEntrance, key: const ValueKey(BadgerSign.entrance)),
                          BadgerSignListTile(BadgerSign.spoil, imgSignsSpoil, 'Fresh spoil heap', model, model.evidenceBadgersignSpoil, key: const ValueKey(BadgerSign.spoil)),
                          BadgerSignListTile(BadgerSign.bedding, imgSignsBedding, 'Bedding', model, model.evidenceBadgersignBedding, key: const ValueKey(BadgerSign.bedding)),
                          BadgerSignListTile(BadgerSign.pawprints, imgSignsPawprint, 'Pawprint', model, model.evidenceBadgersignPawprints, key: const ValueKey(BadgerSign.pawprints)),
                          BadgerSignListTile(BadgerSign.hair, imgSignsHair, 'Hair', model, model.evidenceBadgersignHair, key: const ValueKey(BadgerSign.hair)),
                          BadgerSignListTile(BadgerSign.scratch, imgSignsScratch, 'Scratch marks', model, model.evidenceBadgersignHair, key: const ValueKey(BadgerSign.scratch)),
                          BadgerSignListTile(BadgerSign.latrine, imgSignsLatrine, 'Latrine', model, model.evidenceBadgersignLatrine, key: const ValueKey(BadgerSign.latrine)),
                          BadgerSignListTile(BadgerSign.run, imgSignsRun, 'Well-used run', model, model.evidenceBadgersignRun, key: const ValueKey(BadgerSign.run)),
                          BadgerSignListTile(BadgerSign.foraging, imgSignsForaging, 'Foraging signs', model, model.evidenceBadgersignForaging, key: const ValueKey(BadgerSign.foraging)),
                        ],
                      ),
                    ),

                    // From evidence checklist only
                    Visibility(
                      visible: liveReport.activeReport.incidentType != IncidentType.blank,
                      child: Column(
                        children: [
                          const SizedBox(height: paraBreak),
                          const Text(
                            'Take photos or videos using:',
                            style: mTStyle,
                          ),
                          const SizedBox(height: paraBreak),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(outsideButton),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(minHeight: buttonHeight2),
                                    child: ElevatedButton(
                                      style: dbButton,
                                      onPressed: () {
                                        liveReport.vidphotoType = VidphotoType.ownphone;
                                        Navigator.of(context).pushNamed(sVidphoto, arguments: liveReport);
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(insideButton),
                                        child: Text('My\nphone', textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(outsideButton),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(minHeight: buttonHeight2),
                                    child: ElevatedButton(
                                      style: dbButton,
                                      onPressed: () {
                                        liveReport.vidphotoType = VidphotoType.otherdevice;
                                        Navigator.of(context).pushNamed(sVidphoto, arguments: liveReport);
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(insideButton),
                                        child: Text('Another\ndevice', textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: paraBreak),
                          const Text(
                            'Do you have photos or videos?',
                            style: mTStyle,
                          ),
                          const SizedBox(height: paraBreak),
                          InkWell(
                            onTap: () => setState(() {
                              liveReport.activeReport.evidenceBadgeractivityPhotos = true;
                              model.evidenceBadgeractivityPhotos = true;
                            }),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                  value: true,
                                  groupValue: model.evidenceBadgeractivityPhotos,
                                  activeColor: appDB,
                                  onChanged: (value) => setState(() {
                                    liveReport.activeReport.evidenceBadgeractivityPhotos = true;
                                    model.evidenceBadgeractivityPhotos = true;
                                  }),
                                ),
                                const Text(
                                  'Yes',
                                  style: sTStyle,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => setState(() {
                              liveReport.activeReport.evidenceBadgeractivityPhotos = false;
                              model.evidenceBadgeractivityPhotos = false;
                            }),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                  value: false,
                                  groupValue: model.evidenceBadgeractivityPhotos,
                                  activeColor: appDB,
                                  onChanged: (value) => setState(() {
                                    liveReport.activeReport.evidenceBadgeractivityPhotos = false;
                                    model.evidenceBadgeractivityPhotos = false;
                                  }),
                                ),
                                const Text(
                                  'No',
                                  style: sTStyle,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: paraBreak),
                          const Text(
                            'Is there anything else you\'re aware of that demonstrates the sett is in current use, or anything you\'d like to note about the sett?',
                            //'Add notes (optional):',
                            style: mTStyle,
                          ),
                          const SizedBox(height: paraBreak),
                          TextFormField(
                            initialValue: model.evidenceBadgeractivityText,
                            onSaved: (value) {
                              liveReport.activeReport.evidenceBadgeractivityText = value!;
                              model.evidenceBadgeractivityText = value;
                            },
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
                                        _formKeyChecklistBadgeractivity.currentState!.save();
                                        print('ENTRANNNNNNNNCE ${model.evidenceBadgersignEntrance}');
                                        liveReport.activeReport.evidenceBadgeractivityPhotos = model.evidenceBadgeractivityPhotos;
                                        liveReport.activeReport.evidenceBadgeractivityText = model.evidenceBadgeractivityText;
                                        liveReport.activeReport.evidenceBadgeractivitySignEntrance = model.evidenceBadgersignEntrance;
                                        liveReport.activeReport.evidenceBadgeractivitySignSpoil = model.evidenceBadgersignSpoil;
                                        liveReport.activeReport.evidenceBadgeractivitySignBedding = model.evidenceBadgersignBedding;
                                        liveReport.activeReport.evidenceBadgeractivitySignPawprints = model.evidenceBadgersignPawprints;
                                        liveReport.activeReport.evidenceBadgeractivitySignHair = model.evidenceBadgersignHair;
                                        liveReport.activeReport.evidenceBadgeractivitySignScratch = model.evidenceBadgersignScratch;
                                        liveReport.activeReport.evidenceBadgeractivitySignLatrine = model.evidenceBadgersignLatrine;
                                        liveReport.activeReport.evidenceBadgeractivitySignRun = model.evidenceBadgersignRun;
                                        liveReport.activeReport.evidenceBadgeractivitySignForaging = model.evidenceBadgersignForaging;
                                        Navigator.pop(context, liveReport);
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(insideButton),
                                        child: Text('Save', textAlign: TextAlign.center),
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

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
