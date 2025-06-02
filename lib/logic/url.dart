import 'package:url_launcher/url_launcher.dart';

import '../config/errors.dart';

Future<bool> myLaunchUrl(String url) async {
  print('URL launcher called');
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    print('Launching $url');
    await launchUrl(uri); // TODO external app not webview
    return true;
  } else {
    print(Error.launchURLfailed);
    print(url);
    return false;
  }
}

Future<bool> launchEmail(String emailAddress, {String? subject, String? body}) async {
  print('launchEmail called');
  String url = 'mailto:$emailAddress';
  String urlEncodedBody = '';
  String urlEncodedSubject = '';

  if (subject != null) {
    print(subject);
    urlEncodedSubject = Uri.encodeComponent(subject);
    //urlEncodedBody = Uri.encodeQueryComponent(body);
  }

  if (body != null) {
    print(body);
    urlEncodedBody = Uri.encodeComponent(body);
    //urlEncodedBody = Uri.encodeQueryComponent(body);
  }
  // Assemble mailto URL in different ways depending on which parameters we have
  if (subject != null && body != null) {
    print('we have a subject and a body');
    url += '?subject=$urlEncodedSubject&body=$urlEncodedBody';
  } else if (subject != null) {
    print('we have a subject only');
    url += '?subject=$urlEncodedSubject';
  } else if (body != null) {
    print('we have a body only');
    url += '?body=$urlEncodedBody';
  } else {
    print('we have neither a subject nor a body');
  }

  print('full url worked out as $url');

  // Needed after plugin upgrade
  //final Uri urlParsed = Uri.parse(url);

  // See if we can send to the mailto URL, then launch mailer
  // TODO sequence needs better documenting
  print('Launching email to $emailAddress');
  bool success = await myLaunchUrl(url);

  if (success) {
    print('myLaunchUrl came back true');
    return true;
  } else {
    print(Error.launchEmailFailed);
    print(emailAddress);
    return false;
  }
}
