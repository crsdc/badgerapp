import '../exports_config.dart';

class ChecklistAnimalFormModel {
  String evidenceAnimalText = '';
  bool evidenceAnimalPhotos = false;
}

class ChecklistAnimal extends StatefulWidget {
  @override
  State<ChecklistAnimal> createState() => _ChecklistAnimalState();
}

class _ChecklistAnimalState extends State<ChecklistAnimal> {
  final GlobalKey<FormState> _formKeyChecklistAnimal = GlobalKey<FormState>();
  ChecklistAnimalFormModel model = ChecklistAnimalFormModel();

  LiveReport liveReport = LiveReport();

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      final LiveReport receivedData = ModalRoute.of(context)?.settings.arguments as LiveReport;
      liveReport = receivedData;
      // Populate form from liveReport as we could be back on this screen after being here before
      model.evidenceAnimalText = liveReport.activeReport.evidenceAnimalText;
      model.evidenceAnimalPhotos = liveReport.activeReport.evidenceAnimalPhotos;
      print('receivedData on screen ChecklistAnimal:   $receivedData');
      print('liveReport on screen ChecklistAnimal:   $liveReport');
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
          'Evidence:\nAnimal in situ',
          style: appBarTwoLine,
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Form(
          key: _formKeyChecklistAnimal,
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
                'A description of the animal in the place it was found',
                style: mTStyle,
              ),
              const SizedBox(height: paraBreak),
              TextFormField(
                //decoration: const InputDecoration(labelText: 'Your report'),
                minLines: 1,
                maxLines: 20,
                initialValue: model.evidenceAnimalText,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  liveReport.activeReport.evidenceAnimalText = value!;
                  model.evidenceAnimalText = value;
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
                style: mTBold,
              ),
              const SizedBox(height: paraBreak),
              InkWell(
                onTap: () => setState(() {
                  liveReport.activeReport.evidenceAnimalPhotos = true;
                  model.evidenceAnimalPhotos = true;
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: true,
                      groupValue: model.evidenceAnimalPhotos,
                      activeColor: appDB,
                      onChanged: (value) => setState(() {
                        liveReport.activeReport.evidenceAnimalPhotos = true;
                        model.evidenceAnimalPhotos = true;
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
                  liveReport.activeReport.evidenceAnimalPhotos = false;
                  model.evidenceAnimalPhotos = false;
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: false,
                      groupValue: model.evidenceAnimalPhotos,
                      activeColor: appDB,
                      onChanged: (value) => setState(() {
                        liveReport.activeReport.evidenceAnimalPhotos = false;
                        model.evidenceAnimalPhotos = false;
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
                            _formKeyChecklistAnimal.currentState!.save();
                            liveReport.activeReport.evidenceAnimalText = model.evidenceAnimalText;
                            liveReport.activeReport.evidenceAnimalPhotos = model.evidenceAnimalPhotos;
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
