// enums we'll use for any category-type fields in Report and LiveReport classes

enum IncidentType {
  blank, // the null value
  settinterf,
  baiting,
  trapssnares,
  shootlamp,
  poison,
  other
}


// TODO use this more!
extension IncidentTypeExtension on IncidentType {
  String get value {
    switch (this) {
      case IncidentType.blank:
        return '';
      case IncidentType.settinterf:
        return 'Sett interference';
      case IncidentType.baiting:
        return 'Badger baiting';
      case IncidentType.trapssnares:
        return 'Traps or snares';
      case IncidentType.shootlamp:
        return 'Shooting or lamping';
      case IncidentType.poison:
        return 'Poison';
      case IncidentType.other:
        return 'Other';
    }
  }
}

enum InterfType {
  blank, // the null value, not 'unknown' to avoid confusion with when the user says they don't know, which we have an explicit value for
  forestry, // or tree surgery
  farming,
  development, // or road construction
  hunt,
  diggers,
  poisoning, // or gassing
  other,
  unknown
}

enum InterfHappening {
  blank, // the null value
  hapnow,
  nothapnow
}

enum InterfLicensed {
  blank, // the null value, not 'unknown' to avoid confusion with when the user says they don't know, which we lump in with unlicensed
  licensed,
  unlicensed, // or unable to confirm
  noncompliant
}

enum InterfStopped {
  blank, // the null value
  stopped,
  notstopped,
}

// Badger baiting
enum BbType {
  blank, // the null value
  rightnow,
  past,
  injured,
  photovideo,
  otherinfo,
}

// Traps and snares

enum TsType {
  blank, // the null value
  snare,
  legbody,
  cage,
  othertrap,
}

enum TsCircs {
  blank, // the null value
  live,
  dead,
  onrunsett,
}

// Shooting and lamping
enum SlType {
  blank, // the null value
  rightnow,
  past,
  injured,
  otherinfo,
}

// Poison
enum PsType {
  blank, // the null value
  badger,
  substance,
  otherinfo,
}

// Multipurpose

// - poison > poisoned badger
// - shooting/lamping > shot badger
enum BDeadAlive {
  blank, // the null value
  alive,
  dead,
}

// - baiting
// - shooting and lamping
enum PerpsStatus {
  blank, // the null value
  atscene,
  gone,
}

enum VidphotoType {
  blank, // the null value
  ownphone,
  otherdevice
}
