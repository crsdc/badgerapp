import 'dart:io';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../exports_config.dart';

class EmailPreview extends StatefulWidget {
  @override
  State<EmailPreview> createState() => _EmailPreviewState();
}

class _EmailPreviewState extends State<EmailPreview> {
  bool sendAttempted = false;
  LiveReport liveReport = LiveReport();

  Future<void> _copyToClipboard() async {
    print('called _copyToClipboard function');
    await Clipboard.setData(ClipboardData(text: liveReport.generatedEmail));
    print('in     _copyToClipboard function gone past await');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email copied to clipboard')));
    print('in     _copyToClipboard function should have displayed snackbar');
  }

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      final LiveReport receivedData = ModalRoute.of(context)?.settings.arguments as LiveReport;
      liveReport = receivedData;
      print('### 8 liveReport.activeReport.userNarrative = ${liveReport.activeReport.userNarrative}');
      print(liveReport);
    } else {
      print(Error.noArgsForLiveReport);
    }
    return WillPopScope(
      onWillPop: () async {
        return true;
        /*Navigator.of(context).pushNamed(sQuickReport, arguments: liveReport);
        return false;*/
      },
      child: Scaffold(
        backgroundColor: appBackground,
        appBar: AppBar(
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: appBarColor,
          title: const Text('Send your report'),
          /*automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pushNamed(sQuickReport, arguments: liveReport)
          ),*/
        ),
        body: Padding(
          padding: const EdgeInsets.all(edgePad),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Your report has been turned into an email and is ready for you to send to $reportDestinationEmail.',
                style: sTStyle,
              ),
              const SizedBox(height: smallBreak),
              const Text(
                'Please send the text below without changing any of it. If you need to follow up to clarify something or provide further details, you can send a separate email to the same address.',
                style: sTStyle,
              ),
              const SizedBox(height: paraBreak),
              Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'Email preview',
                      style: mTBold,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      width: 160,
                      child: ElevatedButton(
                        style: pillButtonPaler,
                        onPressed: () {
                          print('copy report to clipboard');// TODO - fix, looks ok though?
                          _copyToClipboard();
                          // copy
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(insideButton),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Copy'),
                              Icon(MdiIcons.contentCopy),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: paraBreak),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Scrollbar(
                    thumbVisibility: true,
                    //isAlwaysShown: true,
                    thickness: 8.0,
                    child: SingleChildScrollView(
                      child: Container(
                        color: softBackground,
                        child: Padding(
                          padding: const EdgeInsets.all(edgePad),
                          child: SelectableText(
                            liveReport.generatedEmail,
                            style: const TextStyle(fontSize: xsTSize-1, fontFamily: 'RobotoMono'),// TODO spin this off
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: paraBreak),
              Visibility(
                visible: globTestMode,
                child: const Row(
                  children: [
                    Expanded (
                      child: Text(
                        '   Testing mode: Don\'t submit real reports   \n   You can safely submit made-up reports   ',
                        style: sTHighlight,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: globTestMode,
                child: const SizedBox(height: paraBreak),
              ),

              // Send button, shown before we try to send
              Visibility(
                visible: !sendAttempted,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          height: 40,
                          width: 160,
                          child: ElevatedButton(
                            style: pillButton,
                            onPressed: () async {
                              /*bool _emailedSuccess = await launchEmail(
                                'test@example.com',
                                subject: 'Report from $appTitle',
                                body: liveReport.generatedEmail
                              );
                              if (_emailedSuccess) {
                                // Stop the buttons changing for a split second before the email client appears
                                sleep(const Duration(milliseconds: 1000));
                                setState(() => sendAttempted = true);
                              }*/
                              if (globTestMode) {
                                await launchEmail(
                                    '$reportDestinationEmail,$testDestinationEmail',
                                    subject: 'TEST report from $appTitle',
                                    body: liveReport.generatedEmail
                                );
                              } else {
                                await launchEmail(
                                    reportDestinationEmail,
                                    subject: 'Report from $appTitle',
                                    body: liveReport.generatedEmail
                                );
                              }
                              // Stop the buttons changing in the split second before the email client appears
                              sleep(const Duration(milliseconds: 2000));
                              setState(() => sendAttempted = true);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(insideButton),
                              child: Text('Send email', textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // Yes/no buttons to ask user whether they sent, after we've attempted to call email app
              Visibility(
                visible: sendAttempted,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Were you able to send the email?',
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
                                  Navigator.of(context).pushNamed(sEmailDone, arguments: liveReport);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(insideButton),
                                  child: Text('Yes', textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              height: 40,
                              width: 90,
                              child: ElevatedButton(
                                style: pillButton,
                                onPressed: () {
                                  // TODO a copy to clipboard mechanism if passing to app fails
                                  // TODO a dialog with some explanation and a copy option
                                  // above may be sorted? gh#83
                                  setState(() => sendAttempted = false);
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please try again')));
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(insideButton),
                                  child: Text('No', textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
