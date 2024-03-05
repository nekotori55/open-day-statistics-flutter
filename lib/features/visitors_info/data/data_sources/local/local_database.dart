import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import 'initial_db_data.dart';

part 'local_database.g.dart';

@DriftDatabase(tables: [Districts, Regions, Schools, Visitors])
class AppDatabase extends _$AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();

  AppDatabase._internal() : super(_openConnection());

  factory AppDatabase() {
    return _instance;
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();

        var regionRows = initialRegions.entries.map((entry) =>
            RegionsCompanion(id: Value(entry.key), name: Value(entry.value)));

        var districtRows = initialDistricts.entries.map((entry) =>
            DistrictsCompanion(id: Value(entry.key), name: Value(entry.value)));

        var schoolRows = initialSchools.entries.map((entry) =>
            SchoolsCompanion(id: Value(entry.key), name: Value(entry.value)));

        batch((batch) {
          batch.insertAll(regions, regionRows);
          batch.insertAll(districts, districtRows);
          batch.insertAll(schools, schoolRows);
        });
      },
    );
  }

  Future<List<District>> get allDistricts => select(districts).get();

  Future<List<Region>> get allRegions => select(regions).get();

  Future<List<School>> get allSchools => select(schools).get();

  Future<int> addVisitor(VisitorsCompanion entry) {
    return into(visitors).insert(entry);
  }

  Future<Map<Region, int>> countRegionsVisitors() async {
    final amountOfVisitors = visitors.id.count();

    final query = select(regions).join([
      innerJoin(
        visitors,
        regions.id.equalsExp(visitors.regionId),
        useColumns: false,
      ),
    ])
      ..addColumns([amountOfVisitors])
      ..groupBy([regions.id]);

    final queryResult = await query.get();

    final result = Map<Region, int>.fromEntries(queryResult.map((row) {
      final reg = row.readTable(regions);
      final amount = row.read(amountOfVisitors);
      return MapEntry<Region, int>(reg, amount!);
    }));
    return result;
  }

  Future<Map<District, int>> countDistrictsVisitors() async {
    final amountOfVisitors = visitors.id.count();
    final query = select(districts).join([
      innerJoin(visitors, districts.id.equalsExp(visitors.districtId),
          useColumns: false),
    ])
      ..addColumns([amountOfVisitors])
      ..groupBy([districts.id]);

    final queryResult = await query.get();

    final result = Map<District, int>.fromEntries(queryResult.map((row) {
      final dis = row.readTable(districts);
      final amount = row.read(amountOfVisitors);
      return MapEntry<District, int>(dis, amount!);
    }));
    return result;
  }

  Future<Map<School, int>> countSchoolVisitors() async {
    final amountOfVisitors = visitors.id.count();
    final query = select(schools).join([
      innerJoin(visitors, schools.id.equalsExp(visitors.regionId),
          useColumns: false),
    ])
      ..addColumns([amountOfVisitors])
      ..groupBy([schools.id]);

    final queryResult = await query.get();

    final result = Map<School, int>.fromEntries(queryResult.map((row) {
      final sch = row.readTable(schools);
      final amount = row.read(amountOfVisitors);
      return MapEntry<School, int>(sch, amount!);
    }));
    return result;
  }

  Future<Region> getRegionById(String id) async {
    return await (select(regions)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<District> getDistrictById(String id) async {
    return await (select(districts)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<School> getSchoolById(String id) async {
    return await (select(schools)..where((t) => t.id.equals(id))).getSingle();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cacheBase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cacheBase;

    return NativeDatabase.createInBackground(file);
  });
}

class Districts extends Table {
  TextColumn get id => text().withLength(min: 6, max: 6)();

  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Regions extends Table {
  TextColumn get id => text().withLength(min: 5, max: 6)();

  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Schools extends Table {
  TextColumn get id => text().withLength(min: 1, max: 2)();

  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Visitors extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get districtId => text().references(Districts, #id).nullable()();

  TextColumn get regionId => text().references(Regions, #id)();

  TextColumn get schoolId => text().references(Schools, #id).nullable()();
}
