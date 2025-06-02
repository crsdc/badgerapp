import '../exports_config.dart';

class Vidphoto extends StatefulWidget {
  @override
  State<Vidphoto> createState() => _VidphotoState();
}

class _VidphotoState extends State<Vidphoto> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    LiveReport liveReport = LiveReport();
    String whichDevice = Error.whichDeviceInvalid;
    String whichDeviceButtonText = Error.whichDeviceInvalid;
    if (ModalRoute.of(context)?.settings.arguments != null) {
      final LiveReport receivedData = ModalRoute.of(context)?.settings.arguments as LiveReport;
      liveReport = receivedData;
    }
    if (liveReport.vidphotoType == VidphotoType.ownphone) {
      whichDevice = 'your phone';
      whichDeviceButtonText = 'Take photos or videos';
    } else if (liveReport.vidphotoType == VidphotoType.otherdevice) {
      whichDevice = 'another device';
      whichDeviceButtonText = 'Show time, date and location';
    }
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: appBarColor,
        title: Text(
          'Take photos or videos\nusing $whichDevice',
          style: appBarTwoLine,
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(edgePad),
          children: <Widget>[
            const SizedBox(height: paraBreak),
            const Text(
              'When and where',
              style: mTBold,
            ),
            const SizedBox(height: paraBreak),
            Visibility(
              visible: liveReport.vidphotoType == VidphotoType.ownphone,
              child: const Text(
                //'If location settings are turned on, this information will be saved in the image metadata. When using video, pan to a distinct feature in the environment to provide further evidence of your location.',
                'If you have location turned on and your phone\'s camera app is set to tag your photos with a location, this information will be saved in the image metadata to help show where the evidence you\'re recording is. When using video, pan to a distinct feature in the environment to provide further evidence of your location.',
                style: mTStyle,
              ),
            ),
            Visibility(
              visible: liveReport.vidphotoType == VidphotoType.otherdevice,
              child: const Text(
                'Tap \'Show time, date and location\' below and hold your phone screen up to the camera. Alternatively, use a GPS device if you have one. When using video, pan to a distinct feature in the environment to provide further evidence of your location.',
                style: mTStyle,
              ),
            ),
            const SizedBox(height: paraBreak),
            Visibility(
              visible: liveReport.vidphotoType == VidphotoType.otherdevice,
              child: Image.asset(imgShowGPS),
            ),
            Visibility(
              visible: liveReport.vidphotoType == VidphotoType.otherdevice,
              child: const SizedBox(height: paraBreak),
            ),
            const Text(
              'Narrate objectively',
              style: mTBold,
            ),
            const SizedBox(height: paraBreak),
            const Text(
              'When using video, tell the camera what you can see, but limit narration to objective information.',
              style: mTStyle,
            ),
            const SizedBox(height: paraBreak),
            const Text(
              'Demonstrate scale',
              style: mTBold,
            ),
            const SizedBox(height: paraBreak),
            const Text(
              'If you are taking close-ups, consider placing a standard object (e.g. a coin or shoe) into the shot to demonstrate scale. Better still, use a ruler or tape-measure.',
              style: mTStyle,
            ),
            const SizedBox(height: paraBreak),
            Image.asset(imgShowScale),
            const SizedBox(height: paraBreak),
            const Text(
              'Label the evidence',
              style: mTBold,
            ),
            const SizedBox(height: paraBreak),
            const Text(
              'If you are documenting multiple similar-looking items, consider numbering them to help you distinguish them later. You could use numbered pieces of paper or fingers.',
              style: mTStyle,
            ),
            const SizedBox(height: paraBreak),
            Image.asset(imgLabel),
            const SizedBox(height: paraBreak),
            // Toggle what shows up here depending on own or different device
            Visibility(
              visible: liveReport.vidphotoType == VidphotoType.otherdevice,
              child: ElevatedButton(
                style: dbButton,
                onPressed: () => Navigator.of(context).pushNamed(sLocationDisplay),
                child: Text(whichDeviceButtonText, textAlign: TextAlign.center),
              ),
            ),
            Visibility(
              visible: liveReport.vidphotoType == VidphotoType.ownphone,
              child: const Text(
                'Avoid editing your photos, and look after them in case they are needed after you\'ve sent your report.',
                style: mTStyle,
              ),
            ),
            /*ElevatedButton(
              style: dbButton,
              onPressed: () {
                if (liveReport.vidphotoType == VidphotoType.ownphone) {
                  // TODO camera integration gh#53
                  disabledSnackBar(context);
                } else if (liveReport.vidphotoType == VidphotoType.otherdevice) { // another device
                  Navigator.of(context).pushNamed(sLocationDisplay);
                }
              },
              child: Text(whichDeviceButtonText, textAlign: TextAlign.center),
            ),*/
          ],
        ),
      ),
    );
  }
}
