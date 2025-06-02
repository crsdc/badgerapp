import '../exports_config.dart';

class ChecklistHumanFormModel {
  String evidenceHumanText = '';
  bool evidenceHumanPhotos = false;
}

class ChecklistHuman extends StatefulWidget {
  @override
  State<ChecklistHuman> createState() => _ChecklistHumanState();
}

class _ChecklistHumanState extends State<ChecklistHuman> {
  final GlobalKey<FormState> _formKeyChecklistHuman = GlobalKey<FormState>();
  ChecklistHumanFormModel model = ChecklistHumanFormModel();

  LiveReport liveReport = LiveReport();

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      final LiveReport receivedData = ModalRoute.of(context)?.settings.arguments as LiveReport;
      liveReport = receivedData;
      // Populate form from liveReport as we could be back on this screen after being here before
      print('on build before setting.... ');
      print('liveReport.activeReport.evidenceHumanPhotos is ${liveReport.activeReport.evidenceHumanPhotos}');
      print('model.evidenceHumanPhotos is ${model.evidenceHumanPhotos}');
      print('liveReport.activeReport.evidenceHumanText is ${liveReport.activeReport.evidenceHumanText}');
      print('model.evidenceHumanText is ${model.evidenceHumanText}');
      model.evidenceHumanText = liveReport.activeReport.evidenceHumanText;
      model.evidenceHumanPhotos = liveReport.activeReport.evidenceHumanPhotos;
      print('on build after setting....');
      print('liveReport.activeReport.evidenceHumanPhotos is ${liveReport.activeReport.evidenceHumanPhotos}');
      print('model.evidenceHumanPhotos is ${model.evidenceHumanPhotos}');
      print('liveReport.activeReport.evidenceHumanText is ${liveReport.activeReport.evidenceHumanText}');
      print('model.evidenceHumanText is ${model.evidenceHumanText}');
      //print('receivedData on screen ChecklistHuman:   $receivedData');
      //print('liveReport on screen ChecklistHuman:   $liveReport');
    } else {
      print(Error.noArgsForLiveReport);
    }

    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: appBarColor,
        title: const Text(
          'Evidence:\nWho and what',
          style: appBarTwoLine,
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Form(
          key: _formKeyChecklistHuman,
          child: ListView(
            padding: const EdgeInsets.all(edgePad),
            children: <Widget>[
              const SizedBox(height: paraBreak),
              const Text(
                'If possible and only if safe to do so, document:',
                style: mTBold,
              ),
              const SizedBox(height: paraBreak),
              const Text(
                'Who can/did you see and what are/were they doing? Include descriptions of people and vehicles at the scene.',
                style: mTStyle,
              ),
              const SizedBox(height: paraBreak),
              const Text(
                'If the perpetrators are no longer at the scene or you didn\'t see them, are there any other signs of human activity (e.g. vehicle tracks, footprints, dogs, spent cartridges, cigarette stubs, clothing items etc.)?',
                style: mTStyle, // Check this is same size as above
              ),
              const SizedBox(height: paraBreak),
              TextFormField(
                //decoration: const InputDecoration(labelText: 'Your report'),
                minLines: 1,
                maxLines: 20,
                initialValue: model.evidenceHumanText,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  liveReport.activeReport.evidenceHumanText = value!;
                  model.evidenceHumanText = value;
                },
              ),
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
                          style: lbButton,
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
                          style: lbButton,
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
                style: mTBold,
              ),
              const SizedBox(height: paraBreak),
              InkWell(
                onTap: () => setState(() {
                  liveReport.activeReport.evidenceHumanPhotos = true;
                  model.evidenceHumanPhotos = true;
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: true,
                      groupValue: model.evidenceHumanPhotos,
                      activeColor: appDB,
                      onChanged: (value) => setState(() {
                        liveReport.activeReport.evidenceHumanPhotos = true;
                        model.evidenceHumanPhotos = true;
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
                  liveReport.activeReport.evidenceHumanPhotos = false;
                  model.evidenceHumanPhotos = false;
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: false,
                      groupValue: model.evidenceHumanPhotos,
                      activeColor: appDB,
                      onChanged: (value) => setState(() {
                        liveReport.activeReport.evidenceHumanPhotos = false;
                        model.evidenceHumanPhotos = false;
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
                            _formKeyChecklistHuman.currentState!.save();
                            print('save pressed.......');
                            print('before setting..');
                            print('liveReport.activeReport.evidenceHumanPhotos is ${liveReport.activeReport.evidenceHumanPhotos}');
                            print('model.evidenceHumanPhotos is ${model.evidenceHumanPhotos}');
                            print('liveReport.activeReport.evidenceHumanText is ${liveReport.activeReport.evidenceHumanText}');
                            print('model.evidenceHumanText is ${model.evidenceHumanText}');
                            liveReport.activeReport.evidenceHumanText = model.evidenceHumanText;
                            liveReport.activeReport.evidenceHumanPhotos = model.evidenceHumanPhotos;
                            print('after setting..');
                            print('liveReport.activeReport.evidenceHumanText is ${liveReport.activeReport.evidenceHumanText}');
                            print('model.evidenceHumanText is ${model.evidenceHumanText}');
                            Navigator.of(context).pushReplacementNamed(sChecklist, arguments: liveReport);
                            //Navigator.of(context).popAndPushNamed(sChecklist, arguments: liveReport);
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
      ),
    );
  }
}
