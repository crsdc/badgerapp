import 'package:badger/config/dev.dart';

import 'tree_enums.dart';

/// Class to represent a draft or completed incident report that can be saved
/// to database storage, and does not include transient info passed between
/// screens as part of LiveReport (which includes Report as one of its fields)
class Report {

  /// Simple ms-since-epoch timestamp serves as a unique ID
  int id;

  /// Optional memorable name for report
  String mnemonicLabel;

  // Incident type flags
  IncidentType incidentType;

  // if sett interference:
  InterfType interfType;
  InterfHappening interfHappening;
  InterfLicensed interfLicensed;
  InterfStopped interfStopped;

  // if badger baiting:
  BbType bbType;
  // TODO
  // hap now or not? TODO especially this, how is it flagged? prob by BbType.notnow
  // badger still alive? - applies only in case of bbType.injured
  // perps still at scene or not - applies only in case of bbType.past or bbType.injured

  // if traps/snares:
  TsType tsType;
  TsCircs tsCircs;

  // if shooting/lamping:
  SlType slType;

  // if poison:
  PsType psType;

  // Multipurpose flags for several incident types
  BDeadAlive bDeadAlive;
  PerpsStatus perpsStatus;

  // Additional report details
  String userNarrative;
  bool policeReport;
  String crimeReference;

  // Evidence fields
  bool evidenceAnimalPhotos;
  String evidenceAnimalText;

  bool evidencePoisonPhotos;
  String evidencePoisonText;

  bool evidenceTrapsnarePhotos;
  String evidenceTrapsnareText;

  bool evidenceHumanPhotos;
  String evidenceHumanText;

  bool evidenceAftermathPhotos;
  String evidenceAftermathText;

  bool evidenceBadgeractivityPhotos;
  String evidenceBadgeractivityText;
  bool evidenceBadgeractivitySignEntrance;
  bool evidenceBadgeractivitySignSpoil;
  bool evidenceBadgeractivitySignBedding;
  bool evidenceBadgeractivitySignPawprints;
  bool evidenceBadgeractivitySignHair;
  bool evidenceBadgeractivitySignScratch;
  bool evidenceBadgeractivitySignLatrine;
  bool evidenceBadgeractivitySignRun;
  bool evidenceBadgeractivitySignForaging;

  bool evidenceDeadbadger;
  bool evidenceDeadother;
  bool evidenceSettbefore;
  bool evidenceTrailcam;
  bool evidenceDrone;
  bool evidenceSketchmap;

  String evidenceOtherText;

  // When and where
  String incidentDateStr;
  // TODO we are interested in resolution to the day only, and we convert date
  // to an ISO 8601 string in the UI, but what if we incorporate time?
  double latitude;
  double longitude;
  String gridRefText;
  String what3Words;
  String nearestTown;
  String county;

  // Personal details
  String firstName;
  String lastName;
  String emailAddress;
  String phoneNumber;

  // Permission and completed flags
  bool permission; // TODO shouldn't be nullable
  bool reportCompleted; // TODO replace with validated and ready to send, and a flag saying whether sent, based on email conf screen

  // Report metadata
  String whenCreated; // TODO can now be inferred from id
  String lastModified; // TODO make it an int timestamp
  String appVersionCreated;
  String appVersionLastMod;

  // Default constructor sets everything blank, but should not be used much
  Report({
    this.id = 0,
    this.mnemonicLabel = '',
    this.incidentType = IncidentType.blank,
    this.interfType = InterfType.blank,
    this.interfHappening = InterfHappening.blank,
    this.interfLicensed = InterfLicensed.blank,
    this.interfStopped = InterfStopped.blank,
    this.bbType = BbType.blank,
    this.tsType = TsType.blank,
    this.tsCircs = TsCircs.blank,
    this.slType = SlType.blank,
    this.psType = PsType.blank,
    this.bDeadAlive = BDeadAlive.blank,
    this.perpsStatus = PerpsStatus.blank,
    this.userNarrative = '',
    this.policeReport = false,
    this.crimeReference = '',
    this.evidenceAnimalPhotos = false,
    this.evidenceAnimalText = '',
    this.evidencePoisonPhotos = false,
    this.evidencePoisonText = '',
    this.evidenceTrapsnarePhotos = false,
    this.evidenceTrapsnareText = '',
    this.evidenceHumanPhotos = false,
    this.evidenceHumanText = '',
    this.evidenceAftermathPhotos = false,
    this.evidenceAftermathText = '',
    this.evidenceBadgeractivityPhotos = false,
    this.evidenceBadgeractivityText = '',
    this.evidenceBadgeractivitySignEntrance = false,
    this.evidenceBadgeractivitySignSpoil = false,
    this.evidenceBadgeractivitySignBedding = false,
    this.evidenceBadgeractivitySignPawprints = false,
    this.evidenceBadgeractivitySignHair = false,
    this.evidenceBadgeractivitySignScratch = false,
    this.evidenceBadgeractivitySignLatrine = false,
    this.evidenceBadgeractivitySignRun = false,
    this.evidenceBadgeractivitySignForaging = false,
    this.evidenceDeadbadger = false,
    this.evidenceDeadother = false,
    this.evidenceSettbefore = false,
    this.evidenceTrailcam = false,
    this.evidenceDrone = false,
    this.evidenceSketchmap = false,
    this.evidenceOtherText = '',
    this.incidentDateStr = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.gridRefText = '',
    this.what3Words = '',
    this.nearestTown = '',
    this.county = '',
    this.firstName = '',
    this.lastName = '',
    this.emailAddress = '',
    this.phoneNumber = '',
    this.permission = false,
    this.reportCompleted = false, // true = complete, false = draft, and default to false
    this.whenCreated = '',
    this.lastModified = '',
    this.appVersionCreated = '',
    this.appVersionLastMod = '',
  });

  // Constructor to be used when beginning a new report with timestamp etc
  Report.fresh() : this(
    id: DateTime.now().millisecondsSinceEpoch,
    whenCreated: DateTime.now().toIso8601String(),
    lastModified: DateTime.now().toIso8601String(),
    appVersionCreated: appVersion,
    appVersionLastMod: appVersion,
  );

  // Method for setting time and version stamp when a report is created
  /*void createStamp () {
    whenCreated = DateTime.now().toString();
    appVersionCreated = appVersion;
  }*/

  // Map our fields onto JSON strings for database storage
  Map<String, String> toMap() {
    return {
      'id': id.toString(),
      'mnemonicLabel': mnemonicLabel,
      'incidentType': incidentType.name,
      'interfType': interfType.name,
      'interfHappening': interfHappening.name,
      'interfLicensed': interfLicensed.name,
      'interfStopped': interfStopped.name,
      'bbType': bbType.name,
      'tsType': tsType.name,
      'tsCircs': tsCircs.name,
      'slType': slType.name,
      'psType': psType.name,
      'bDeadAlive': bDeadAlive.name,
      'perpsStatus': perpsStatus.name,
      'userNarrative': userNarrative,
      'policeReport': policeReport.toString(),
      'crimeReference': crimeReference,
      'evidenceAnimalPhotos': evidenceAnimalPhotos.toString(),
      'evidenceAnimalText': evidenceAnimalText,
      'evidencePoisonPhotos': evidencePoisonPhotos.toString(),
      'evidencePoisonText': evidencePoisonText,
      'evidenceTrapsnarePhotos': evidenceTrapsnarePhotos.toString(),
      'evidenceTrapsnareText': evidenceTrapsnareText,
      'evidenceHumanPhotos': evidenceHumanPhotos.toString(),
      'evidenceHumanText': evidenceHumanText,
      'evidenceAftermathPhotos': evidenceAftermathPhotos.toString(),
      'evidenceAftermathText': evidenceAftermathText,
      'evidenceBadgeractivityPhotos': evidenceBadgeractivityPhotos.toString(),
      'evidenceBadgeractivityText': evidenceBadgeractivityText,
      'evidenceBadgeractivitySignEntrance': evidenceBadgeractivitySignEntrance.toString(),
      'evidenceBadgeractivitySignSpoil': evidenceBadgeractivitySignSpoil.toString(),
      'evidenceBadgeractivitySignBedding': evidenceBadgeractivitySignBedding.toString(),
      'evidenceBadgeractivitySignPawprints': evidenceBadgeractivitySignPawprints.toString(),
      'evidenceBadgeractivitySignHair': evidenceBadgeractivitySignHair.toString(),
      'evidenceBadgeractivitySignScratch': evidenceBadgeractivitySignScratch.toString(),
      'evidenceBadgeractivitySignLatrine': evidenceBadgeractivitySignLatrine.toString(),
      'evidenceBadgeractivitySignRun': evidenceBadgeractivitySignRun.toString(),
      'evidenceBadgeractivitySignForaging': evidenceBadgeractivitySignForaging.toString(),
      'evidenceDeadbadger': evidenceDeadbadger.toString(),
      'evidenceDeadother': evidenceDeadother.toString(),
      'evidenceSettbefore': evidenceSettbefore.toString(),
      'evidenceTrailcam': evidenceTrailcam.toString(),
      'evidenceDrone': evidenceDrone.toString(),
      'evidenceSketchmap': evidenceSketchmap.toString(),
      'evidenceOtherText': evidenceOtherText,
      'incidentDateStr': incidentDateStr,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'gridRefText': gridRefText,
      'what3Words': what3Words,
      'nearestTown': nearestTown,
      'county': county,
      'firstName': firstName,
      'lastName': lastName,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'permission': permission.toString(),
      'reportCompleted': reportCompleted.toString(),
      'whenCreated': whenCreated,
      'lastModified': lastModified,
      'appVersionCreated': appVersionCreated,
      'appVersionLastMod': appVersionLastMod,
    };
  }

  factory Report.fromMap(int id, Map<String, dynamic> map) {
    print('factory Report.fromMap');
    print(map);
    /*print(map['incidentType']);
    print(IncidentType.values);
    print(IncidentType.values.firstWhere((element) => element.toString() == IncidentType.poison.toString()));*/
    return Report(
      id: int.tryParse(map['id']) ?? 0,
      mnemonicLabel: map['mnemonicLabel'],
      incidentType: IncidentType.values.firstWhere(
        (element) => element.name == map['incidentType'],
        orElse: () => IncidentType.blank),
      interfType: InterfType.values.firstWhere(
        (element) => element.name == map['interfType'],
        orElse: () => InterfType.blank),
      interfHappening: InterfHappening.values.firstWhere(
        (element) => element.name == map['interfHappening'],
        orElse: () => InterfHappening.blank),
      interfLicensed: InterfLicensed.values.firstWhere(
        (element) => element.name == map['interfLicensed'],
        orElse: () => InterfLicensed.blank),
      interfStopped: InterfStopped.values.firstWhere(
        (element) => element.name == map['interfStopped'],
        orElse: () => InterfStopped.blank),
      bbType: BbType.values.firstWhere(
        (element) => element.name == map['bbType'],
        orElse: () => BbType.blank),
      tsType: TsType.values.firstWhere(
        (element) => element.name == map['tsType'],
        orElse: () => TsType.blank),
      tsCircs: TsCircs.values.firstWhere(
        (element) => element.name == map['tsCircs'],
        orElse: () => TsCircs.blank),
      slType: SlType.values.firstWhere(
        (element) => element.name == map['slType'],
        orElse: () => SlType.blank),
      psType: PsType.values.firstWhere(
        (element) => element.name == map['psType'],
        orElse: () => PsType.blank),
      bDeadAlive: BDeadAlive.values.firstWhere(
        (element) => element.name == map['bDeadAlive'],
        orElse: () => BDeadAlive.blank),
      perpsStatus: PerpsStatus.values.firstWhere(
        (element) => element.name == map['perpsStatus'],
        orElse: () => PerpsStatus.blank),
      userNarrative: map['userNarrative'],
      policeReport: map['policeReport'] == 'true' ? true : false,
      crimeReference: map['crimeReference'],
      evidenceAnimalPhotos: map['evidenceAnimalPhotos'] == 'true' ? true : false,
      evidenceAnimalText: map['evidenceAnimalText'],
      evidencePoisonPhotos: map['evidencePoisonPhotos'] == 'true' ? true : false,
      evidencePoisonText: map['evidencePoisonText'],
      evidenceTrapsnarePhotos: map['evidenceTrapsnarePhotos'] == 'true' ? true : false,
      evidenceTrapsnareText: map['evidenceTrapsnareText'],
      evidenceHumanPhotos: map['evidenceHumanPhotos'] == 'true' ? true : false,
      evidenceHumanText: map['evidenceHumanText'],
      evidenceAftermathPhotos: map['evidenceAftermathPhotos'] == 'true' ? true : false,
      evidenceAftermathText: map['evidenceAftermathText'],
      evidenceBadgeractivityPhotos: map['evidenceBadgeractivityPhotos'] == 'true' ? true : false,
      evidenceBadgeractivityText: map['evidenceBadgeractivityText'],
      evidenceBadgeractivitySignEntrance: map['evidenceBadgeractivitySignEntrance'] == 'true' ? true : false,
      evidenceBadgeractivitySignSpoil: map['evidenceBadgeractivitySignSpoil'] == 'true' ? true : false,
      evidenceBadgeractivitySignBedding: map['evidenceBadgeractivitySignBedding'] == 'true' ? true : false,
      evidenceBadgeractivitySignPawprints: map['evidenceBadgeractivitySignPawprints'] == 'true' ? true : false,
      evidenceBadgeractivitySignHair: map['evidenceBadgeractivitySignHair'] == 'true' ? true : false,
      evidenceBadgeractivitySignScratch: map['evidenceBadgeractivitySignScratch'] == 'true' ? true : false,
      evidenceBadgeractivitySignLatrine: map['evidenceBadgeractivitySignLatrine'] == 'true' ? true : false,
      evidenceBadgeractivitySignRun: map['evidenceBadgeractivitySignRun'] == 'true' ? true : false,
      evidenceBadgeractivitySignForaging: map['evidenceBadgeractivitySignForaging'] == 'true' ? true : false,
      evidenceDeadbadger: map['evidenceDeadbadger'] == 'true' ? true : false,
      evidenceDeadother: map['evidenceDeadother'] == 'true' ? true : false,
      evidenceSettbefore: map['evidenceSettbefore'] == 'true' ? true : false,
      evidenceTrailcam: map['evidenceTrailcam'] == 'true' ? true : false,
      evidenceDrone: map['evidenceDrone'] == 'true' ? true : false,
      evidenceSketchmap: map['evidenceSketchmap'] == 'true' ? true : false,
      evidenceOtherText: map['evidenceOtherText'],
      incidentDateStr: map['incidentDateStr'],
      latitude: double.tryParse(map['latitude']) ?? 0.0,
      longitude: double.tryParse(map['longitude']) ?? 0.0,
      gridRefText: map['gridRefText'],
      what3Words: map['what3Words'],
      nearestTown: map['nearestTown'],
      county: map['county'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      emailAddress: map['emailAddress'],
      phoneNumber: map['phoneNumber'],
      permission: map['permission'] == 'true' ? true : false,
      reportCompleted: map['reportCompleted'] == 'true' ? true : false,
      whenCreated: map['whenCreated'],
      lastModified: map['lastModified'],
      appVersionCreated: map['appVersionCreated'],
      appVersionLastMod: map['appVersionLastMod'],
    );
  }

  //TODO when Myreports reenabled
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
  // fields below are out of date
    'REPORT'
    '\nid:                              $id'
    /*'\nlocationLabel                    $locationLabel'
    '\nfirstName:                       $firstName'
    '\nlastName:                        $lastName'
    '\nemailAddress:                    $emailAddress'
    '\nphoneNumber:                     $phoneNumber'
    '\npermission:                      $permission'
    '\nincidentDateStr:                 $incidentDateStr'
    '\nlatitude:                        $latitude'
    '\nlongitude:                       $longitude'
    '\ngridRefText:                     $gridRefText'
    '\nwhat3Words:                      $what3Words'
    '\nnearestTown:                     $nearestTown'
    '\ncounty:                          $county'*/
    '\nincidentType:                    $incidentType'
    '\ninterfType:                      $interfType'
    '\ninterfHappening:                 $interfHappening'
    '\ninterfLicensed:                  $interfLicensed'
    '\ninterfStopped:                   $interfStopped'
    '\nbbType:                          $bbType'
    '\ntsType:                          $tsType'
    '\ntsCircs:                         $tsCircs'
    '\nslType:                          $slType'
    '\npoliceReport:                    $policeReport'
    '\ncrimeReference:                  $crimeReference'
    '\nevidenceAnimalPhotos:            $evidenceAnimalPhotos'
    '\nevidenceAnimalText:              $evidenceAnimalText'
    '\nevidencePoisonPhotos:            $evidencePoisonPhotos'
    '\nevidencePoisonText:              $evidencePoisonText'
    '\nevidenceTrapsnarePhotos:         $evidenceTrapsnarePhotos'
    '\nevidenceTrapsnareText:           $evidenceTrapsnareText'
    '\nevidenceHumanPhotos:             $evidenceHumanPhotos'
    '\nevidenceHumanText:               $evidenceHumanText'
    '\nevidenceAftermathPhotos:         $evidenceAftermathPhotos'
    '\nevidenceAftermathText:           $evidenceAftermathText'
    '\nevidenceBadgeractivityPhotos:    $evidenceBadgeractivityPhotos'
    '\nevidenceBadgeractivityText:      $evidenceBadgeractivityText'
    '\nevidenceBadgeractivitySignEntrance $evidenceBadgeractivitySignEntrance'
    '\nevidenceBadgeractivitySignSpoil  $evidenceBadgeractivitySignSpoil'
    '\nevidenceBadgeractivitySignBedding $evidenceBadgeractivitySignBedding'
    '\nevidenceBadgeractivitySignPawprints $evidenceBadgeractivitySignPawprints'
    '\nevidenceBadgeractivitySignHair   $evidenceBadgeractivitySignHair'
    '\nevidenceBadgeractivitySignScratch $evidenceBadgeractivitySignScratch'
    '\nevidenceBadgeractivitySignLatrine $evidenceBadgeractivitySignLatrine'
    '\nevidenceBadgeractivitySignRun    $evidenceBadgeractivitySignRun'
    '\nevidenceBadgeractivitySignForaging $evidenceBadgeractivitySignForaging'
    '\nevidenceDeadbadger:              $evidenceDeadbadger'
    '\nevidenceDeadother:               $evidenceDeadother'
    '\nevidenceSettbefore:              $evidenceSettbefore'
    '\nevidenceTrailcam:                $evidenceTrailcam'
    '\nevidenceDrone:                   $evidenceDrone'
    '\nevidenceSketchmap:               $evidenceSketchmap'
    '\nevidenceOtherText:               $evidenceOtherText'
    '\nuserNarrative:                   $userNarrative'
    '\nmnemonicLabel:                   $mnemonicLabel'
    '\nreportCompleted:                 $reportCompleted'
    '\nwhenCreated:                     $whenCreated'
    '\nlastModified:                    $lastModified'
    '\nappVersionCreated:               $appVersionCreated'
    '\nappVersionLastMod:               $appVersionLastMod';
  }
}
