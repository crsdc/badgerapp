import '../exports_config.dart';

class ChecklistTrapsnareFormModel {
  String evidenceTrapsnareText = '';
  bool evidenceTrapsnarePhotos = false;
}

class ChecklistTrapsnare extends StatefulWidget {
  @override
  State<ChecklistTrapsnare> createState() => _ChecklistTrapsnareState();
}

class _ChecklistTrapsnareState extends State<ChecklistTrapsnare> {
  final GlobalKey<FormState> _formKeyChecklistTrapsnare = GlobalKey<FormState>();
  ChecklistTrapsnareFormModel model = ChecklistTrapsnareFormModel();

  LiveReport liveReport = LiveReport();

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      final LiveReport receivedData = ModalRoute.of(context)?.settings.arguments as LiveReport;
      liveReport = receivedData;
      // Populate form from liveReport as we could be back on this screen after being here before
      model.evidenceTrapsnareText = liveReport.activeReport.evidenceTrapsnareText;
      model.evidenceTrapsnarePhotos = liveReport.activeReport.evidenceTrapsnarePhotos;
      print('receivedData on screen ChecklistTrapsnare:   $receivedData');
      print('liveReport on screen ChecklistTrapsnare:   $liveReport');
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
          'Evidence:\nTrap or snare in situ',
          style: appBarTwoLine,
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Form(
          key: _formKeyChecklistTrapsnare,
          child: ListView(
            padding: const EdgeInsets.all(edgePad),
            children: <Widget>[
              const SizedBox(height: paraBreak),
              const Text(
                'If you disable a trap or snare, consider notifying the police that you have done so in order to prevent a crime.',
                style: mTStyle,
              ),
              const SizedBox(height: paraBreak),
              const Text(
                'If possible and only if safe to do so, document:',
                style: mTBold,
              ),
              const SizedBox(height: paraBreak),
              const Text(
                'A description of the trap or snare in the place it was found',
                style: mTStyle,
              ),
              const SizedBox(height: paraBreak),
              TextFormField(
                //decoration: const InputDecoration(labelText: 'Your report'),
                minLines: 1,
                maxLines: 20,
                initialValue: model.evidenceTrapsnareText,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  liveReport.activeReport.evidenceTrapsnareText = value!;
                  model.evidenceTrapsnareText = value;
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
                  liveReport.activeReport.evidenceTrapsnarePhotos = true;
                  model.evidenceTrapsnarePhotos = true;
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: true,
                      groupValue: model.evidenceTrapsnarePhotos,
                      activeColor: appDB,
                      onChanged: (value) => setState(() {
                        liveReport.activeReport.evidenceTrapsnarePhotos = true;
                        model.evidenceTrapsnarePhotos = true;
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
                  liveReport.activeReport.evidenceTrapsnarePhotos = false;
                  model.evidenceTrapsnarePhotos = false;
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: false,
                      groupValue: model.evidenceTrapsnarePhotos,
                      activeColor: appDB,
                      onChanged: (value) => setState(() {
                        liveReport.activeReport.evidenceTrapsnarePhotos = false;
                        model.evidenceTrapsnarePhotos = false;
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
                            _formKeyChecklistTrapsnare.currentState!.save();
                            liveReport.activeReport.evidenceTrapsnareText = model.evidenceTrapsnareText;
                            liveReport.activeReport.evidenceTrapsnarePhotos = model.evidenceTrapsnarePhotos;
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
