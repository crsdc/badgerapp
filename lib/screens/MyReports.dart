import 'package:get_it/get_it.dart';
import '../exports_config.dart';

class MyReports extends StatefulWidget {
  @override
  State<MyReports> createState() => _MyReportsState();
}

class _MyReportsState extends State<MyReports> {
  final ReportRepository _reportRepository = GetIt.I.get();
  List<Report> _reports = [];

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  @override
  Widget build(BuildContext context) {
    //print(_reports[0]);
    return Scaffold(
      backgroundColor: appBackground,
      appBar: appBarOneLineWithHome(
        titleText: 'My reports',
        context: context,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _reports.length,
              itemBuilder: (context, index) {
                final report = _reports[index];
                print('iiiiiindex $index');
                return ExpansionTile(
                  key: ValueKey(report.id),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  childrenPadding: const EdgeInsets.only(left: 16, right: 16),
                  //expandedAlignment: Alignment.,
                  // Alternate colours for readability
                  collapsedBackgroundColor: index % 2 == 1 ? Colors.white : appBackground,
                  backgroundColor: index % 2 == 1 ? Colors.white : appBackground,
                  collapsedIconColor: crimeRed,
                  iconColor: crimeRed,
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(
                    // TODO if no label, "draft of #date#"
                    report.mnemonicLabel.isNotEmpty ? report.mnemonicLabel : '[Unnamed report]',
                    style: mTStyle,
                  ),
                  subtitle: Text(
                    // TODO make this neater
                      report.incidentDateStr.isNotEmpty ? 'Incident date: ${niceDate(report.incidentDateStr)}' : '[No date recorded]',
                    style: sTStyle,
                  ),
                  children: [
                    Text(report.incidentType.value,style: sTStyle),

                    Visibility(
                    // TODO
                      visible: report.gridRefText + report.nearestTown + report.county != '',
                      child: Text(
                        // TODO unpack this, include w3w if enabled
                        '${report.gridRefText}\n${report.nearestTown}${(report.nearestTown != '' && report.county != '') ? ', ' : ''}${report.county}',
                        style: sTStyle,
                      ),
                    ),

                    // TODO incident type - need to convert enum same as for fleshout

                    Visibility(
                      visible: report.crimeReference != '',
                      child: Text('Police reference: ${report.crimeReference}'),
                    ),
                    Visibility(
                      visible: report.userNarrative != '',
                      child: Text(report.userNarrative),
                      // TODO clip gracefully
                    ),
                    Text(
                      //'Report begun: ${niceTimeDate(report.whenCreated.substring(0, 16))}\nLast modified: ${niceTimeDate(report.lastModified.substring(0, 16))}',
                      '\nReport begun: ${niceTimeDate(report.whenCreated.substring(0, 16))}',
                      style: xsTStyle,
                    ),
                    Row(
                      children: <Widget>[
                        PillButton(
                          buttonType: PillButtonType.deemphasised,
                          buttonText: 'Edit',
                          pressFunction: () => _useReport(report),
                        ),
                        PillButton(
                          buttonType: PillButtonType.deemphasised,
                          buttonText: 'Delete',
                          pressFunction: () => _deleteReport(report),
                            // remove from db and kill the widget, rebuild without messing up expansion (might need keys)
                        ),
                      ],
                    )
                  ],
                );
              }
            ),
          ),
        ],
      ),

      // FOR TESTING PURPOSES
      /*floatingActionButton: FloatingActionButton(
        onPressed: _addReport,
        child: const Icon(Icons.add),
      ),*/
    );
  }

  _loadReports() async {
    print('loading reports!! 1');
    final reports = await _reportRepository.getAllReports();
    print('loading reports!! 2');
    setState(() => _reports = reports);
    print('loading reports!! 3');
  }

  /*_addReport() async {

    // Assign it an ID
    final int id = DateTime.now().millisecondsSinceEpoch;
    //final int id = 720;

    // Set a made-up label
    final list = ['Cow Farm sett', 'Gamekeeper incident', 'Injured badger', 'Sheep Farm sett', 'Sett in the woods']..shuffle();
    final mnemonicLabel = list.first;

    // Not shown in my reports but will appear in QuickReport
    const firstName = 'John';
    const lastName = 'Smith';
    const emailAddress = 'email@example.com';
    const phoneNumber = '1254467';

    // Does or should appear in my reports
    const incidentDateStr = '2022-11-20';
    const incidentType = IncidentType.shootlamp;
    const policeReport = true;
    const crimeReference = 'CRIME/4567';
    const gridRefText = 'NH 24235 79828';
    const what3Words = 'test.test.test';
    const nearestTown = 'London';
    const county = 'Yorkshire';
    //const reportText = 'LOTS OF TEXT HERE';
    const userNarrative = 'ewfogjt ergiojfr opkr kopr getoopk pofskpo';
    const reportStatus = true;
    const whenCreated = '2022-09-13 14:02';
    final lastModified = DateTime.now().toString();
    const appVersionCreated = appVersion;
    const appVersionLastMod = appVersion;
    //final gridRefE = Random().nextInt(99999);
    //final gridRefN = Random().nextInt(99999);
    // TODO fill in all the required fields here now
    final newReport = Report(
      id: id,
      mnemonicLabel: mnemonicLabel,
      firstName: firstName,
      lastName: lastName,
      emailAddress: emailAddress,
      phoneNumber: phoneNumber,
      incidentDateStr: incidentDateStr,
      incidentType: incidentType,
      policeReport: policeReport,
      crimeReference: crimeReference,
        //this.latitude,
        //this.longitude,
      //gridRefE: gridRefE,
      //gridRefN: gridRefN,
      gridRefText: gridRefText,
      what3Words: what3Words,
      nearestTown: nearestTown,
      county: county,
      userNarrative: userNarrative,
      //reportText: reportText,
      reportCompleted: reportStatus,
      //copyEmail: copyEmail,
      whenCreated: whenCreated,
      lastModified: lastModified,
      appVersionCreated: appVersionCreated,
      appVersionLastMod: appVersionLastMod,
    );
    var insertresult = await _reportRepository.insertReport(newReport);
    print('INSERT RESULT $insertresult');
    _loadReports();
  }*/

  _addReport() async {
    Report newReport = Report.fresh();
    final list = ['Cow Farm sett', 'Gamekeeper incident', 'Injured badger', 'Sheep Farm sett', 'Sett in the woods']..shuffle();
    newReport.mnemonicLabel = list.first;
    newReport.incidentType = IncidentType.poison;
    newReport.psType = PsType.substance;
    newReport.policeReport = true;
    newReport.evidenceBadgeractivitySignSpoil = true;
    newReport.incidentDateStr = '2022-11-11';
    newReport.gridRefText = 'ST 39683 29476';
    newReport.reportCompleted = true;
    newReport.permission = true;
    newReport.userNarrative = 'THIS IS A TEST ONE HHHHHHHHHHHHHHH';
    print(newReport);
    int insertresult = await _reportRepository.insertReport(newReport);
    print('INSERT RESULT $insertresult');
    _loadReports();
  }

  _deleteReport(Report report) async {
    print('deleting report 1: ${report.whenCreated}');
    print('deleting report 1: ID ${report.id}');
    print('deleting report 1: ${report.mnemonicLabel}');
    int delresult = await _reportRepository.deleteReport(report.id);
    print('delresult..... $delresult');
    print('deleting report 2: ${report.id}');
    _loadReports();
  }

  /*_editReport(Report report) async {
    final updatedReport = report.copyWith(
      gridRefE: Random().nextInt(99999),
      gridRefN: Random().nextInt(99999),
    );
    await _reportRepository.updateReport(updatedReport);
    _loadReports();
  }*/

  // TODO all the required fields need to be spelled out here
  _useReport(Report report) {
    print('USE REPORT !!!!!');
    LiveReport liveReport = LiveReport();
    liveReport.activeReport = report;
    Navigator.of(context).pushNamed(sQuickReport, arguments: liveReport);
  }
}
