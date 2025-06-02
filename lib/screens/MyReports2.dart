// DEPRECATED

//import 'package:characters/characters.dart';
import 'package:get_it/get_it.dart';
//import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../exports_config.dart';

class MyReports extends StatefulWidget {
  @override
  State<MyReports> createState() => _MyReportsState();
}

class _MyReportsState extends State<MyReports> {
  final ReportRepository _reportRepository = GetIt.I.get();
  List<Report> _reports = [];
  //bool _customTileExpanded = false;

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
      body: ListView.builder(
        itemCount: _reports.length,
        itemBuilder: (context, index) {
          final report = _reports[index];
          print('report type value!!!!!!');
          print(report.incidentType.value);
          return ExpansionTile(
            controlAffinity: ListTileControlAffinity.leading,
            //trailing: Icon(MdiIcons.dotsVertical),
            title: Text(report.mnemonicLabel),
            //subtitle: Text('${report.id}'), /// Report ID for debugging
            // TODO reinstate
            /*subtitle: Text(DateFormat('E d MMM y').format(DateTime.parse(report.incidentDateStr))),*/
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(2 * edgePad, 0.0, 2 * edgePad, edgePad),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(report.gridRefText, style: xsTStyle),
                      Text('${report.nearestTown}, ${report.county}'),
                      //Text(report.incidentType.value), //TODO
                      if (report.crimeReference != '') Text('Police log or crime no. ${report.crimeReference}'),
                      Text('${Characters(report.userNarrative).take(40)}...', style: xsTItalic),//FIXME also make it conditional - not appear if no nararitve, dots only if cut off
                      /////TODO Text('Report created ' + DateFormat('HH:mm E d MMM y').format(DateTime.parse(report.whenCreated))),
                      //Text('Report created ' + Characters(report.whenCreated).take(10).toString()),
                      report.reportCompleted ? const Text('COMPLETED') : const Text('DRAFT'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // TODO reinstate
                          /*Expanded(
                            child: ListTile(
                              title: const Text('Edit'),
                              leading: const Icon(MdiIcons.pencil),
                              onTap: () {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit temporarily disabled')));}
                            )
                          ),
                          const VerticalDivider(width: 1.0),*/
                          Expanded(
                              child: ListTile(
                                title: const Text('Delete'),
                                leading: const Icon(MdiIcons.delete),
                                onTap: () => _deleteReport(report),
                                //onTap: () {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Delete temporarily disabled')));}
                              )
                          ),
                          //Expanded(child: Center(child: Text('delete'))),
                        ],
                      ),
                      //Text('Saved? ' + report.reportCompleted.toString()),
                    ],
                  ),
                ),
              ),
              /*ListTile(dense: true, title: Text(report.gridRefText)),
              ListTile(dense: true, title: Text(report.nearestTown + ', ' + report.county)),
              ListTile(dense: true, title: Text(report.incidentType.toString())),
              ListTile(dense: true, title: Text(report.crimeReference)),
              ListTile(dense: true, title: Text(report.userNarrative)),
              ListTile(dense: true, title: Text('Report created ' + Characters(report.whenCreated).take(10).toString())),
              ListTile(dense: true, title: Text('Saved? ' + report.reportCompleted.toString())),*/
            ],
            //textColor: textBlack,
            //collapsedTextColor: textBlack,
          );
          /*return ListTile(
            title: Text(report.locationLabel),
            subtitle: Text(
                '${report.mnemonicLabel}\n'
                //'Grid ref: TQ ${report.gridRefE} ${report.gridRefN}\n'
                'ID: ${report.id}\n'
                'Created: ${report.whenCreated}\n'
                'Name: ${report.firstName} ${report.lastName}\n'
                'Date: ${report.incidentDateStr}\n'
                //'Type: ${report.incidentTypeKey}\n'
                //'Police report made? ${report.policeReport}'
                'Compl?: ${report.reportCompleted}\n'
                ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteReport(report),
            ),
            /*leading: IconButton(
              icon: const Icon(Icons.edit_location_outlined),
              onPressed: () => _editReport(report),
            ),*/
          );*/
        },
      ),
      /*floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _addReport,
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

  _addReport() async {

    // Assign it an ID
    final int id = DateTime.now().millisecondsSinceEpoch;
    //final int id = 720;

    final list = ['Cow Farm sett', 'Gamekeeper incident', 'Injured badger', 'Sheep Farm sett', 'Sett in the woods']..shuffle();
    final mnemonicLabel = list.first;
    const firstName = 'John';
    const lastName = 'Smith';
    const emailAddress = 'email@example.com';
    const phoneNumber = '1254467';
    const incidentDateStr = '2021-08-04';
    const incidentType = IncidentType.shootlamp;
    const policeReport = false;
    const crimeReference = '';
    //final latitude = 53;
    //final longitude = -2;
    //const gridRefE = 37868;
    //const gridRefN = 73312;
    const what3Words = 'test.test.test';
    const nearestTown = 'London';
    const county = 'Yorkshire';
    //const reportText = 'LOTS OF TEXT HERE';
    const reportStatus = true;
    //final created = 1;
    //final lastModified = 1;
    const appVersionCreated = 'test';
    const appVersionLastMod = 'test';
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
      what3Words: what3Words,
      nearestTown: nearestTown,
      county: county,
      //reportText: reportText,
      reportCompleted: reportStatus,
      //copyEmail: copyEmail,
      whenCreated: '',
      //lastModified: lastModified,
      appVersionCreated: appVersionCreated,
      appVersionLastMod: appVersionLastMod,
    );
    var insertresult = await _reportRepository.insertReport(newReport);
    print('INSERT RESULT $insertresult');
    _loadReports();
  }

  _deleteReport(Report report) async {
    print('deleting report 1: ${report.whenCreated}');
    print('deleting report 1: ID ${report.id}');
    print('deleting report 1: ${report.mnemonicLabel}');
    int? delresult = 66; //TODO
    delresult = await _reportRepository.deleteReport(report.id);
    print('delresult..... $delresult');
    print('deleting report 2: ${report.id}');
    _loadReports();
    print('deleting report 3: ${report.id}');
  }

// TODO all the required fields need to be spelled out here
/*_editReport(Report report) async {
    final updatedReport = report.copyWith(
      gridRefE: Random().nextInt(99999),
      gridRefN: Random().nextInt(99999),
    );
    await _reportRepository.updateReport(updatedReport);
    _loadReports();
  }*/
}
