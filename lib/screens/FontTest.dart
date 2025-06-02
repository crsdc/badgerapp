import 'package:flutter/gestures.dart';
import '../exports_config.dart';

class FontTest extends StatefulWidget {
  @override
  State<FontTest> createState() => _FontTestState();
}

class _FontTestState extends State<FontTest> {
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
        title: const Text('Font test'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.of(context).pushNamed(sHomeScreen),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(edgePad * 3),
          //padding: const EdgeInsets.all(edgePad * 3),
          children: <Widget>[

            Text(
                'Body text 1 - please ignore this odd screen - it\'s here for testing',
                style: Theme.of(context).textTheme.bodyLarge
            ),
            const SizedBox(height: smallBreak),
            Text(
                'Body text 2',
                style: Theme.of(context).textTheme.bodyMedium
            ),
            const SizedBox(height: smallBreak),
            const Text('Body text 2? Default text not specified'),
            const SizedBox(height: smallBreak),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan (text: 'Default text in RichText'),
                  TextSpan (text: 'Body text 2 in RichText', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const SizedBox(height: smallBreak),
            RichText(
              text: const TextSpan(
                style: mTStyle,
                children: [
                  TextSpan (text: 'bodyText in outer TextSpan'),
                ],
              ),
            ),
            const SizedBox(height: smallBreak),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan (text: 'bodyText in inner TextSpan', style: mTStyle,),
                ],
              ),
            ),
            const SizedBox(height: smallBreak),
            RichText(
              text: TextSpan(
                style: mTStyle,
                children: [
                  const TextSpan(text: 'Was showing bigger on A5 '),
                  TextSpan(
                    text: 'link example',
                    style: mTLink,
                    recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://example.com'),
                  ),
                  extLinkIcon(),
                  const TextSpan(text: ' more text - this is all styled with bodyText in the outer TextSpan'),
                ],
              ),
            ),
            const SizedBox(height: smallBreak),
            RichText(
              text: TextSpan(
                style: mTStyle,
                children: [
                  ScalableTextSpan(context, text: 'Trial with ScalableTextSpan '),
                  ScalableTextSpan(
                    context,
                    text: 'link example',
                    style: mTLink,
                    recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://example.com'),
                  ),
                  extLinkIcon(),
                  const TextSpan(text: ' this one\'s a normal Text Span'),
                ],
              ),
            ),
            const SizedBox(height: smallBreak),
            RichText(
              text: TextSpan(
                style: mTStyle,
                children: [
                  const TextSpan(text: 'With styling on inner TextSpan as well ', style: mTStyle),
                  TextSpan(
                    text: 'link example',
                    style: mTLink,
                    recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://example.com'),
                  ),
                  extLinkIcon(),
                  const TextSpan(text: ' more text', style: mTStyle),
                ],
              ),
            ),
            const SizedBox(height: smallBreak),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: 'With styling on inner TextSpan ONLY ', style: mTStyle),
                  TextSpan(
                    text: 'link example',
                    style: mTLink,
                    recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://example.com'),
                  ),
                  extLinkIcon(),
                  const TextSpan(text: ' more text', style: mTStyle),
                ],
              ),
            ),
            const SizedBox(height: smallBreak),
            RichText(
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              text: TextSpan(
                style: mTStyle,
                children: [
                  const TextSpan(text: 'Outer only with RichText scale factor'),
                  TextSpan(
                    text: 'link example',
                    style: mTLink,
                    recognizer: TapGestureRecognizer()..onTap = () async => myLaunchUrl('https://example.com'),
                  ),
                  extLinkIcon(),
                  const TextSpan(text: ' more text'),
                ],
              ),
            ),


            ElevatedButton(
              style: pillButton,
              onPressed: () async {
                await launchEmail(
                    testDestinationEmail,
                    subject: 'subjectline',
                    body: 'bodytext'
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(insideButton),
                child: Text('Email test', textAlign: TextAlign.center),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
