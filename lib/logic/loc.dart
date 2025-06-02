import 'package:badger/config/dev.dart';

/// Class to represent a saved location that can be saved to database storage
class Loc {

  int id;
  String mnemonicLabel;

  double latitude;
  double longitude;
  String gridRefText;
  String w3wText;

  String createdDateTime;
  String appVersionCreated;

  // Default constructor
  Loc({
    this.id = 0,    // TODO investigate
    this.mnemonicLabel = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.gridRefText = '',
    this.w3wText = '',
    this.createdDateTime = '',
    this.appVersionCreated = '',
  });

  // Map our fields onto JSON strings as this is how they are represented in database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mnemonicLabel': mnemonicLabel,
      'latitude': latitude,
      'longitude': longitude,
      'gridRefText': gridRefText,
      'w3wText': w3wText,
      'createdDateTime': createdDateTime,
      'appVersionCreated': appVersionCreated,
    };
  }

  // Method for setting time and version stamp when a report is created
  void createStamp () {
    createdDateTime = DateTime.now().toString();
    appVersionCreated = appVersion;
  }

  factory Loc.fromMap(int id, Map<String, dynamic> map) {
    print('running factory');
    return Loc(
      id: map['id'],
      mnemonicLabel: map['mnemonicLabel'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      gridRefText: map['gridRefText'],
      w3wText: map['w3wText'],
      createdDateTime: map['createdDateTime'],
      appVersionCreated: map['appVersionCreated'],
    );
  }

  // for edits - can we do this if some fields are blank? looks like yes
  // how do we update lastmodified here, and appversionlastmod?
  /*Report copyWith({
    required int gridRefE,
    required int gridRefN,
  }) {
    return Report(
      id: id,
      locationLabel: locationLabel,
      firstName: firstName,
      lastName: lastName,
      emailAddress: emailAddress,
      phoneNumber: phoneNumber,
      incidentDateStr: incidentDateStr,
      policeReport: policeReport,
      crimeReference: crimeReference,
      gridRefE: gridRefE,
      gridRefN: gridRefN,
      what3Words: what3Words,
      nearestTown: nearestTown,
      county: county,
      reportCompleted: reportCompleted,
      //this.created,
      //this.lastModified, // TODO this needs updating when we copy
      appVersionCreated: appVersionCreated,
      appVersionLastMod: appVersionLastMod, // TODO this needs updating when we copy
    );
  }*/

  // FOR DEBUGGING
  @override
  String toString() { return
    'LOC'
    '\nid:                              $id'
    '\nmnemonicLabel                    $mnemonicLabel'
    '\nlatitude:                        $latitude'
    '\nlongitude:                       $longitude'
    '\ngridRefText:                     $gridRefText'
    '\nw3wText:                         $w3wText'
    '\ncreatedDateTime:                 $createdDateTime'
    '\nappVersionCreated:               $appVersionCreated';
  }
}
