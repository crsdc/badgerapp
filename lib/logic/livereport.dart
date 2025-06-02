import '../exports_config.dart';

/// Class for holding state of an incident report we build as we move through
/// screens.
///
/// Includes a field of class Report, which holds the core data we
/// need to write to database and from which we can generate all other fields
/// of LiveReport. The other variables are ones we use to navigate decision
/// tree, decide what to show in the UI etc, but don't need to be saved to DB.
class LiveReport {

  /// Data that determines what is included in the report, and is saved to DB
  Report activeReport;

  // UI settings while navigating the decision tree
  String interfTypeString; // also used in the generated text
  String themeImage;
  bool dangerFlag; // makes slight change to 999 screen for some tree outcomes
  VidphotoType vidphotoType; // used in evidence sub-checklists take photo screen
  bool quickReportFlag; // adjustments to QuickReport if we came from home screen
  String pvaChecklistWording; // title of "people, vehicles, actions" checklist differs

  // Holds human-readable text generated from Report data, for the email report
  String generatedSummary;
  String generatedEvidencePara;
  String generatedEvidenceList;
  String generatedEmail;

  // Default constructor with default values
  LiveReport()
    : activeReport = Report(), // start with a blank incident report
      interfTypeString = '',
      themeImage = '',
      dangerFlag = false,
      vidphotoType = VidphotoType.blank,
      quickReportFlag = false,
      pvaChecklistWording = 'People, vehicles and actions',
      generatedSummary = '',
      generatedEvidencePara = '',
      generatedEvidenceList = '',
      generatedEmail = '';

  // Factory constructor used to begin a report in progress, with timestamp etc
  factory LiveReport.fresh() {
    LiveReport liveReport = LiveReport();
    liveReport.activeReport = Report.fresh();
    return liveReport;
  }

  /// interfTypeString and themeImage persist over several screens and follow
  /// deterministically from Report.interfType, so set them when we get to
  /// first screen where it matters.
  void interfTypeFleshOut() {
    switch(activeReport.interfType) {
      case InterfType.forestry:
        interfTypeString = 'Forestry or tree surgery';
        themeImage = imgForestry;
        break;
      case InterfType.farming:
        interfTypeString = 'Farming';
        themeImage = imgFarming;
        break;
      case InterfType.development:
        interfTypeString = 'Construction work';
        themeImage = imgDevelopment;
        break;
      case InterfType.hunt:
        interfTypeString = 'Hunting';
        themeImage = imgHunt;
        break;
      case InterfType.diggers:
        interfTypeString = 'Badger diggers';
        themeImage = imgDiggers;
        break;
      case InterfType.poisoning:
        // TODO ideally say poisonING but check whether we can fit this first
        interfTypeString = 'Poison or gassing';
        themeImage = imgPoisonOutside;
        break;
      case InterfType.other:
        interfTypeString = 'Other causes';
        themeImage = '';
        break;
      case InterfType.unknown:
        interfTypeString = 'Cause unknown';
        themeImage = '';
        break;
      default:
        print(Error.interfTypeInvalid);
    }
  }

  /// Determine wording for "people, vehicles, actions" sub-checklist from flags
  void decidePvaChecklistWording() {
    if (activeReport.incidentType == IncidentType.baiting &&
        activeReport.bbType == BbType.injured) {
      pvaChecklistWording = 'People, vehicles and actions\n(where applicable)';
    } else if (activeReport.incidentType == IncidentType.trapssnares
            || activeReport.incidentType == IncidentType.poison) {
      pvaChecklistWording = 'Any other evidence of human activity';
    } else {
      // This is what it says already from initialisation, but allow for routes
      // here where flags may have been changed
      pvaChecklistWording = 'People, vehicles and actions';
    }
    print('liveReport.pvaChecklistWording:');
    print(pvaChecklistWording);
  }

  /// Method for taking variables set over the course of several screens and
  /// generating the INCIDENT SUMMARY text for an emailed report
  void genSummary() {
    print('liveReport.genSummary');
    switch (activeReport.incidentType) {

      case IncidentType.settinterf:
        generatedSummary = 'This is a badger sett interference incident linked to ';
        generatedSummary += '${interfTypeString.toLowerCase()}.';
        switch(activeReport.interfHappening) {
          case InterfHappening.hapnow:
            generatedSummary += '\n\nThe interference was ongoing at the time I began trying to report it.';
            break;
          case InterfHappening.nothapnow:
            generatedSummary += '\n\nThe interference had ceased by the time I began reporting it.';
            break;
          default:
            print(Error.interfHappeningInvalid);
        }
        switch(activeReport.interfLicensed) {
          case InterfLicensed.licensed:
            generatedSummary += '\n\nThis sett interference is believed to be licensed.';
            break;
          case InterfLicensed.unlicensed:
            generatedSummary += '\n\nThis sett interference is believed to be unlicensed, or I\'m unable to confirm whether there\'s a licence.';
            break;
          case InterfLicensed.noncompliant:
            generatedSummary += '\n\nThere may be a licence for some form of sett interference, but the interference here is not compliant with the licence.';
            break;
          default:
            print(Error.interfLicensedInvalid);
        }
        switch(activeReport.interfStopped) {
          case InterfStopped.stopped:
            generatedSummary += '\n\nWork interfering with the sett was stopped when asked.';
            break;
          case InterfStopped.notstopped:
            generatedSummary += '\n\nWork interfering with the sett was NOT stopped when asked.';
            break;
          default:
            print('interfstopped is blank and that\'s fine as we only ask users about this if interf is happening now and unlicenced');
        }
        break;

      case IncidentType.baiting:
        generatedSummary = 'This is a report concerning badger baiting,';
        switch(activeReport.bbType) {
          case BbType.rightnow:
            generatedSummary += ' about an ongoing incident.';
            break;
          case BbType.past:
            generatedSummary += ' about an incident no longer ongoing.';
            switch(activeReport.perpsStatus) {
              case PerpsStatus.atscene:
                generatedSummary += '\n\nSuspected perpetrators are still at the scene.';
                break;
              case PerpsStatus.gone:
                generatedSummary += '\n\nSuspected perpetrators are no longer at the scene.';
                break;
              default:
                print('ERROR building report text');
            }
            break;
          case BbType.injured:
            generatedSummary += ' about an incident in which an injured badger or other animal was found.';
            switch(activeReport.bDeadAlive) {
              case BDeadAlive.alive:
                generatedSummary += ' The animal is or was still alive.';
                break;
              case BDeadAlive.dead:
                generatedSummary += ' The animal in question is dead.';
                break;
              default:
                print('ERROR building report text');
            }
            // Copy+paste from baiting > past
            // Could combine both after BbType switch, but would need to get rid of error msgs
            switch(activeReport.perpsStatus) {
              case PerpsStatus.atscene:
                generatedSummary += '\n\nSuspected perpetrators still at scene.';
                break;
              case PerpsStatus.gone:
                generatedSummary += '\n\nSuspected perpetrators no longer at scene.';
                break;
              default:
                print('ERROR building report text');
            }
            break;
          case BbType.photovideo:
            generatedSummary += ' about photos or videos of the activity.';
            break;
          case BbType.otherinfo:
            generatedSummary += ' with information other than an ongoing or witnessed incident.';
            break;
          default:
            print('ERROR building report text');
        }
        break;

      case IncidentType.trapssnares:
        generatedSummary = 'This is a traps or snares incident, concerning a ';
        switch(activeReport.tsType) {
          case TsType.snare:
            generatedSummary += 'snare.';
            break;
          case TsType.legbody:
            generatedSummary += 'leghold or bodygrip trap.';
            break;
          case TsType.cage:
            generatedSummary += 'cage trap.';
            break;
          case TsType.othertrap:
            generatedSummary += 'type of trap other than a snare, cage, leghold or bodygrip trap.';
            break;
          default:
            print('ERROR building report text');
        }
        switch(activeReport.tsCircs) {
          case TsCircs.live:
            generatedSummary += '\n\nA live badger was found.';
            break;
          case TsCircs.dead:
            generatedSummary += '\n\nA dead badger was found.';
            break;
          case TsCircs.onrunsett:
            generatedSummary += '\n\nThe trap/snare was found on a badger run or near a sett.';
            break;
          default:
            print('ERROR building report text');
        }
        break;

      case IncidentType.shootlamp:
        generatedSummary = 'This is a shooting or lamping report,';
        switch(activeReport.slType) {
          case SlType.rightnow:
            generatedSummary += ' about an ongoing incident.';
            break;
          case SlType.past:
            generatedSummary += ' about an incident no longer ongoing.';
            switch(activeReport.perpsStatus) {
              case PerpsStatus.atscene:
                generatedSummary += '\n\nSuspected perpetrators are still at the scene.';
                break;
              case PerpsStatus.gone:
                generatedSummary += '\n\nSuspected perpetrators are no longer at the scene.';
                break;
              default:
                print('ERROR building report text');
            }
            break;
          case SlType.injured:
            generatedSummary += ' about an incident in which a shot or lamped badger was found.';
            switch(activeReport.bDeadAlive) {
              case BDeadAlive.alive:
                generatedSummary += ' The badger is or was still alive.';
                break;
              case BDeadAlive.dead:
                generatedSummary += ' The badger in question is dead.';
                break;
              default:
                print('ERROR building report text');
            }
            // Copy+paste from shootlamp > past
            // Could combine both after SlType switch, but would need to get rid of error msgs
            switch(activeReport.perpsStatus) {
              case PerpsStatus.atscene:
                generatedSummary += '\n\nSuspected perpetrators are still at the scene.';
                break;
              case PerpsStatus.gone:
                generatedSummary += '\n\nSuspected perpetrators are no longer at the scene.';
                break;
              default:
                print('ERROR building report text');
            }
            break;
          case SlType.otherinfo:
            generatedSummary += ' with information about something other than a witnessed incident or discovery of a shot badger.';
            break;
          default:
            print('ERROR building report text');
        }
        break;

      case IncidentType.poison:
        generatedSummary = 'This is a possible poison incident.';
        switch(activeReport.psType) {
          case PsType.badger:
            generatedSummary += '\n\nA badger was found that may have been poisoned.';
            switch(activeReport.bDeadAlive) {
              case BDeadAlive.alive:
                generatedSummary += ' The badger is or was still alive.';
                break;
              case BDeadAlive.dead:
                generatedSummary += ' The badger in question is dead.';
                break;
              default:
                print('ERROR building report text');
            }
            break;
          case PsType.substance:
            generatedSummary += '\n\nA suspicious substance or poison was found.';
            break;
          case PsType.otherinfo:
            generatedSummary += '\n\nThe report concerns information about poisoning, other than finding a poisoned badger or poison in a badger habitat.';
            break;
          default:
            print('ERROR building report text'); // TODO spin off all these errors
        }
        break;

      case IncidentType.other:
        generatedSummary = 'This is an incident of type \'other\'.';
        break;
      case IncidentType.blank:
        print(Error.incidentTypeInvalid);
        break;
    }
    //print('From within liveReport.genSummary(), our generatedSummary is\n$generatedSummary');
  }

  /// Method for taking variables set over the course of several screens and
  /// generating the EVIDENCE SUMMARY text for an emailed report
  void genEvidencePara() {
    generatedEvidencePara = '';

    // Code removed in the if below since 1.2.28 for overwrought logic when
    // multiple evidenceTexts exist and we want \n\n between them. Now just
    // tacks onto end of all.
    if (activeReport.evidenceAnimalText != '') {
      generatedEvidencePara += 'Notes on animal in situ:\n';
      generatedEvidencePara += activeReport.evidenceAnimalText;
      generatedEvidencePara += '\n\n';
    }
    if (activeReport.evidencePoisonText != '') {
      generatedEvidencePara += 'Notes on poison in situ:\n';
      generatedEvidencePara += activeReport.evidencePoisonText;
      generatedEvidencePara += '\n\n';
    }
    if (activeReport.evidenceTrapsnareText != '') {
      generatedEvidencePara += 'Notes on trap/snare in situ:\n';
      generatedEvidencePara += activeReport.evidenceTrapsnareText;
      generatedEvidencePara += '\n\n';
    }
    if (activeReport.evidenceHumanText != '') {
      generatedEvidencePara += 'Notes on people, vehicles or actions:\n';
      generatedEvidencePara += activeReport.evidenceHumanText;
      generatedEvidencePara += '\n\n';
    }
    if (activeReport.evidenceAftermathText != '') {
      generatedEvidencePara += 'Notes on the aftermath of sett interference:\n';
      generatedEvidencePara += activeReport.evidenceAftermathText;
      generatedEvidencePara += '\n\n';
    }
    if (activeReport.evidenceBadgeractivityText != '') {
      generatedEvidencePara += 'Notes on badger activity at the sett, demonstrating current use by badgers:\n';
      generatedEvidencePara += activeReport.evidenceBadgeractivityText;
      generatedEvidencePara += '\n\n';
    }

    // Field signs
    // Abbreviated conditional expression syntax
    String fieldSignsPara = '';
    fieldSignsPara += activeReport.evidenceBadgeractivitySignEntrance ? '\nOpen sett entrance' : '';
    fieldSignsPara += activeReport.evidenceBadgeractivitySignSpoil ? '\nFresh spoil heap' : '';
    fieldSignsPara += activeReport.evidenceBadgeractivitySignBedding ? '\nBedding' : '';
    fieldSignsPara += activeReport.evidenceBadgeractivitySignPawprints ? '\nPawprint' : '';
    fieldSignsPara += activeReport.evidenceBadgeractivitySignHair ? '\nHair' : '';
    fieldSignsPara += activeReport.evidenceBadgeractivitySignScratch ? '\nScratch marks' : '';
    fieldSignsPara += activeReport.evidenceBadgeractivitySignLatrine ? '\nLatrine' : '';
    fieldSignsPara += activeReport.evidenceBadgeractivitySignRun ? '\nWell-used run' : '';
    fieldSignsPara += activeReport.evidenceBadgeractivitySignForaging ? '\nForaging signs' : '';
    if (fieldSignsPara != '') {
      generatedEvidencePara += 'Field signs recorded demonstrating current use by badgers:'; // TODO sett / vicinity issue
      generatedEvidencePara += fieldSignsPara;
      generatedEvidencePara += '\n';
    }
  }

  /// Method for taking variables set over course of several screens and
  /// generating the EVIDENCE SUMMARY text for an emailed report
  void genEvidenceList() {
    generatedEvidenceList = '';
    if (activeReport.evidenceAnimalPhotos) generatedEvidenceList += '\nPhoto/video of animal in situ';
    if (activeReport.evidenceTrapsnarePhotos) generatedEvidenceList += '\nPhoto/video of traps or snares in situ';
    if (activeReport.evidenceHumanPhotos) generatedEvidenceList += '\nPhoto/video of people, vehicles or actions';
    if (activeReport.evidenceAftermathPhotos) generatedEvidenceList += '\nPhoto/video of the aftermath of sett interference';
    if (activeReport.evidenceBadgeractivityPhotos) generatedEvidenceList += '\nPhoto/video of badger activity at the sett'; // TODO vicinity issue
    if (activeReport.evidenceDeadbadger) generatedEvidenceList += '\nPhoto/video of a dead or injured badger';
    if (activeReport.evidenceDeadother) generatedEvidenceList += '\nPhoto/video of another dead or injured animal';
    if (activeReport.evidenceSettbefore) generatedEvidenceList += '\nPhoto/video of the sett taken before sett interference';
    if (activeReport.evidenceTrailcam) generatedEvidenceList += '\nTrail camera footage of badgers at the sett taken before sett interference';
    if (activeReport.evidenceDrone) generatedEvidenceList += '\nAerial or drone footage';
    if (activeReport.evidenceSketchmap) generatedEvidenceList += '\nSketch map';
    if (activeReport.evidenceOtherText != '') {
      // Add blank separation line if any others on the list
      if (generatedEvidenceList != '') generatedEvidenceList += '\n';
      generatedEvidenceList += '\nOther evidence:\n';
      generatedEvidenceList += activeReport.evidenceOtherText;
    }
    // Take off first newline, since we don't know until we build the list which
    // item comes first, and all have leading newlines to separate them
    if (generatedEvidenceList != '') generatedEvidenceList = generatedEvidenceList.substring(1);
  }

  String get genEmail {
    // Getter that transforms a Report into the text of an email, which it returns
    String generatedEmail = '';
    if (globTestMode) {
      generatedEmail = 'TEST REPORT\nIncident details based on questions and answers:\n\n';
    } else {
      generatedEmail = 'Incident details based on questions and answers:\n\n';
    }
    generatedEmail += generatedSummary;
    if (activeReport.incidentDateStr != '') {
      generatedEmail += '\n\nIncident date: ';
      generatedEmail += niceDate(activeReport.incidentDateStr);
    } else {
      generatedEmail += '\n\nIncident date not provided.';
    }
    if (activeReport.policeReport) {
      generatedEmail += '\n\nReported to police. Crime reference or incident number';
      if (activeReport.crimeReference != '') {
        generatedEmail += ': ';
        generatedEmail += activeReport.crimeReference;
      } else {
        generatedEmail += ' not provided.';
      }
    } else {
      generatedEmail += '\n\nNot reported to police, or not yet at time of this report.';
    }
    generatedEmail += '\n'; // listed separately in case we want optional grid refs
    generatedEmail += '\nOS grid ref: ';
    // TODO ensure proper handling of grid refs gh#79
    generatedEmail += activeReport.gridRefText;
    if (activeReport.what3Words != '') {
      generatedEmail += '\nW3W: ';
      generatedEmail += activeReport.what3Words;
    }
    generatedEmail += '\nNearest town: ';
    generatedEmail += activeReport.nearestTown;
    generatedEmail += '\nCounty: ';
    generatedEmail += activeReport.county;
    if (activeReport.userNarrative != '') {
      generatedEmail += '\n\nFurther details from the reporter:\n\n';
      generatedEmail += activeReport.userNarrative;
    }
    if (generatedEvidencePara != '') {
      generatedEmail += '\n\n';
      generatedEmail += generatedEvidencePara;
    }
    if (generatedEvidenceList != '') {
      generatedEmail += '\n\nEvidence held:\n';
      generatedEmail += generatedEvidenceList;
    }
    generatedEmail += '\n\nFirst name: ';
    generatedEmail += activeReport.firstName;
    generatedEmail += '\nLast name: ';
    generatedEmail += activeReport.lastName;
    generatedEmail += '\nContact email: ';
    generatedEmail += activeReport.emailAddress;
    generatedEmail += '\nPhone: ';
    generatedEmail += activeReport.phoneNumber;
    generatedEmail += '\nPermission to share details: ';
    if (activeReport.permission == true) {
      generatedEmail += 'yes';
    } else {
      generatedEmail += 'no';
    }
    generatedEmail += '\n\n[Report begun ';
    generatedEmail += activeReport.whenCreated.substring(0, 10);
    generatedEmail += ' ';
    generatedEmail += activeReport.whenCreated.substring(11, 16);
    generatedEmail += ' with ';
    generatedEmail += appTitle;
    generatedEmail += ' v';
    generatedEmail += activeReport.appVersionCreated;
    generatedEmail += ', last modified ';
    // If created and last modified on same date only include the time
    if (activeReport.lastModified.substring(0, 10) == activeReport.whenCreated.substring(0, 10)) {
      generatedEmail += activeReport.lastModified.substring(11, 16);
    } else {
      generatedEmail += activeReport.whenCreated.substring(0, 10);
      generatedEmail += ' ';
      generatedEmail += activeReport.whenCreated.substring(11, 16);
    }
    // Only include version at last mod if it differs from version when created
    if (activeReport.appVersionLastMod != activeReport.appVersionCreated) {
      generatedEmail += ' with v';
      generatedEmail += activeReport.appVersionLastMod;
    }
    /*generatedEmail += ', and this email generated ';
    // If last modified and email generated on same date only include the time
    if (DateTime.now().toString().substring(0, 10) == activeReport.lastModified.substring(0, 10)) {
      generatedEmail += DateTime.now().toString().substring(11, 16); // if same date only need time
    } else {
      generatedEmail += DateTime.now().toString().substring(0, 16);
    }
    // Only include version at email generation if it differs from version at last mod
    if (appVersion != activeReport.appVersionLastMod) {
      generatedEmail += ' by v';
      generatedEmail += appVersion;
    }*/
    generatedEmail += ']';
    return generatedEmail;
  }

  // For debugging
  @override
  String toString() { return
    'LIVE REPORT'
    '\ninterfTypeString: $interfTypeString'
    '\nthemeImage:       $themeImage'
    '\ndangerFlag:       $dangerFlag'
    '\nvidphotoType:     $vidphotoType'
    '\nquickReportFlag:  $quickReportFlag'
    '\ngeneratedSummary  $generatedSummary'
    '\ngeneratedEvidencePara $generatedEvidencePara'
    '\ngeneratedEvidenceList $generatedEvidenceList'
    '\ngeneratedEmail    $generatedEmail'
    '\n${activeReport.toString()}';
  }
}
