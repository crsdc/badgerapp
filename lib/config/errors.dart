// Error messages

abstract class Error {
  static const userMessageTellDev =        'Please report this to the app developer quoting the error number.';
  static const noArgsForLiveReport =       'ERROR 001: We weren\'t passed arguments from the route, so are unable to populate our liveReport.';
  static const legPopupInvalid =           'ERROR 002: Legislation popup has not been passed a valid value.';
  static const interfTypeInvalid =         'ERROR 003: InterfType isn\'t one of forestry, farming or development, so how have we ended up on this screen?';
  static const interfHappeningInvalid =    'ERROR 004: InterfHappening has an invalid value during genSummary, so we can\'t generate summary text.';
  static const interfLicensedInvalid =     'ERROR 005: InterfLicensed has an invalid value during genSummary.';
  static const incidentTypeInvalid =       'ERROR 006: InterfType is blank during genSummary.';
  static const interfHappeningNotPassed =  'ERROR 007: Settinterf1Happening hasn\'t been passed a value for whether happening now or not';
  static const launchURLfailed =           'ERROR 008: launchURL could not launch the URL it was passed:';
  static const launchEmailFailed =         'ERROR 009: launchEmail could not launch the email address it was passed:';
  static const arrivedScreenShouldnt =     'ERROR 010: We\'ve arrived at a screen from somewhere we shouldn\'t';
  static const badgerSignModalInvalid =    'ERROR 011: Badger sign modal has been passed an invalid value';
  static const whichDeviceInvalid =        'ERROR 012: whichDevice didn\'t receive a valid value';
  static const incidentTypeInvalidDbase =  'ERROR 013: InterfType is blank during database operations.';
}
