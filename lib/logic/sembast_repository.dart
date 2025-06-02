import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'loc.dart';
import 'report.dart';

abstract class ReportRepository {
  Future<int> insertReport(Report report);
  Future updateReport(Report report);
  Future deleteReport(int reportId);
  Future<List<Report>> getAllReports();
}

class SembastReportRepository extends ReportRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store('report_store');

  @override
  Future<int> insertReport(Report report) async {
    print('inserting a report created ${report.whenCreated}');
    int? result = await _store.record(report.id).add(_database, report.toMap());
    return result ?? 0;
    //return await _store.record(9999).add(_database, report.toMap());
    //return await _store.add(_database, report.toMap());
  }

  @override
  Future updateReport(Report report) async {
    await _store.record(report.id).update(_database, report.toMap());
  }

  @override
  Future deleteReport(int reportId) async{
    print('deleteReport has been passed $reportId');

    // Messy, converting RecordRef<dynamic, dynamic> to String then to int
    //int recordToDelete = int.tryParse(_store.record(reportId).toString()) ?? 0;

    return await _store.record(reportId).delete(_database);
    //return await _store.record(recordToDelete).delete(_database);
    //return await _store.record(int.tryParse(reportId)).delete(_database);
  }

  @override
  Future<List<Report>> getAllReports() async {
    print('get all reports!! 1');
    final snapshots = await _store.find(_database);
    print(snapshots);
    print('get all reports!! 2');
    print(snapshots.map((snapshot) => Report.fromMap(snapshot.key, snapshot.value)).toList(growable: false));
    return snapshots.map((snapshot) => Report.fromMap(snapshot.key, snapshot.value)).toList(growable: false);
  }
}

abstract class LocRepository {
  Future<int> insertLoc(Loc loc);
  Future updateLoc(Loc loc);
  Future deleteLoc(int locId);
  Future<List<Loc>> getAllLocs();
}

class SembastLocRepository extends LocRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store('loc_store');

  @override
  Future<int> insertLoc(Loc loc) async {
    print('inserting a location created ${loc.createdDateTime}');
    return await _store.record(loc.id).add(_database, loc.toMap());
    //return await _store.record(9999).add(_database, report.toMap());
    //return await _store.add(_database, report.toMap());
  }

  @override
  Future updateLoc(Loc loc) async {
    await _store.record(loc.id).update(_database, loc.toMap());
  }

  @override
  Future deleteLoc(int locId) async{
    print('deleteLoc has been passed $locId');

    // Messy, converting RecordRef<dynamic, dynamic> to String then to int
    //int recordToDelete = int.tryParse(_store.record(reportId).toString()) ?? 0;

    return await _store.record(locId).delete(_database);
    //return await _store.record(recordToDelete).delete(_database);
    //return await _store.record(int.tryParse(reportId)).delete(_database);
  }

  @override
  Future<List<Loc>> getAllLocs() async {
    print('get all locations!! 1');
    final snapshots = await _store.find(_database);
    print(snapshots);
    print('get all locations!! 2');
    print(snapshots.map((snapshot) => Loc.fromMap(snapshot.key, snapshot.value)).toList(growable: false));
    return snapshots.map((snapshot) => Loc.fromMap(snapshot.key, snapshot.value)).toList(growable: false);
  }
}
