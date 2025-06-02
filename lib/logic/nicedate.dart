// Functions for formatting dates

/// Turn e.g. 2000-01-01 into 1 Jan 2000
String niceDate (String isoDate) {

  String result = '';

  if (isoDate.length < 10) {
    print('Date error in niceDate');
    return '';

  } else {
    String interim = isoDate.substring(8, 10);
    interim += ' ';
    interim += intToMMM(int.parse(isoDate.substring(5, 7)));
    interim += ' ';
    interim += isoDate.substring(0, 4);

    // Trim leading zero on date, if present
    interim[0] != '0' ? result = interim : result = interim.substring(1);

    return result;
  }
}

/// Turn e.g. 2000-01-01T05:32:52.543 into 05:32 1 Jan 2000
String niceTimeDate (String isoDate) {

  String result = '';

  if (isoDate.length < 16) {
    print('Date error in niceTimeDate');
    return '';

  } else {
    result = isoDate.substring(11, 16);
    result += ' ';
    result += niceDate(isoDate);

    return result;
  }
}

/// Turn e.g. 4 into Apr
String intToMMM(int month) {
  switch (month) {
    case 1: return 'Jan';
    case 2: return 'Feb';
    case 3: return 'Mar';
    case 4: return 'Apr';
    case 5: return 'May';
    case 6: return 'Jun';
    case 7: return 'Jul';
    case 8: return 'Aug';
    case 9: return 'Sep';
    case 10: return 'Oct';
    case 11: return 'Nov';
    case 12: return 'Dec';
    default: return '';
  }
}
