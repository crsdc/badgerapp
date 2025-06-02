import 'package:flutter/gestures.dart';
import '../exports_config.dart';

class EmailDone extends StatefulWidget {
  @override
  State<EmailDone> createState() => _EmailDoneState();
}

class _EmailDoneState extends State<EmailDone> {
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
        title: const Text('Thank you'),
        actions: <Widget>[ // TODO supress back button? or should we leave it in case someone clicks by accident
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.of(context).pushNamed(sHomeScreen),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(edgePad * 3),
          children: <Widget>[
            const SizedBox(height: paraBreak * 2),
            RichText(
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              text: TextSpan(
                style: mTStyle,
                children: [
                  const TextSpan(text: 'Thank you for sending in your report.\n\nIt\'s saved under My Reports if you need to refer to it again, and depending on your settings there may be a copy in your sent emails folder.\n\nPlease keep hold of any evidence you\'ve recorded, such as photos, and don\'t alter these in any way.\n\nIf you need to follow up to clarify something in your report or provide further details, you can send a separate email to '),
                  TextSpan(
                    text: reportDestinationEmail,
                    style: mTLink,
                    recognizer: TapGestureRecognizer()..onTap = () async => launchEmail(reportDestinationEmail),
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
            const SizedBox(height: paraBreak * 2),
            Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 120,
                      child: ElevatedButton(
                        style: pillButton,
                        onPressed: () => Navigator.of(context).pushNamed(sHomeScreen),
                        child: const Padding(
                          padding: EdgeInsets.all(insideButton),
                          child: Text('Done', textAlign: TextAlign.center),
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
    );
  }
}
