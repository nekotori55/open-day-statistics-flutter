import 'package:drift/drift.dart';
import 'package:open_day_statistics_flutter/core/common_domain/api_result.dart';
import 'package:open_day_statistics_flutter/core/common_domain/error_result.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/data_sources/local/local_database.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/data_sources/visitor_statistics_datasource.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/district_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/region_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/school_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/statistics_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/visitor_model.dart';

class VisitorStatisticsLocalDatasourceImpl
    implements VisitorStatisticsDatasource {
  var database = AppDatabase();

  void closeConnection() {
    database.close();
  }

  @override
  Future<ApiResult<Null>> addVisitor(VisitorModel visitor) async {
    try {
      final entry = VisitorsCompanion(
        districtId: Value(visitor.districtID),
        regionId: Value(visitor.regionID),
        schoolId: Value(visitor.schoolID),
      );
      await database.addVisitor(entry);
      return const ApiResult<Null>.success(data: null);
    } catch (e) {
      return ApiResult<Null>.failure(error: ErrorResult(message: "[Database Error] $e"));
    }
  }

  @override
  Future<ApiResult<List<DistrictModel>>> getAllDistricts() async {
    try {
      final queryResult = await database.allDistricts;
      final result = List.of(queryResult.map(
          (district) => DistrictModel(id: district.id, name: district.name)));
      return ApiResult<List<DistrictModel>>.success(data: result);
    } catch (e) {
      return ApiResult<List<DistrictModel>>.failure(
          error: ErrorResult(message: "[Database Error] $e"));
    }
  }

  @override
  Future<ApiResult<List<RegionModel>>> getAllRegions() async {
    try {
      final queryResult = await database.allRegions;
      final result = List.of(queryResult
          .map((region) => RegionModel(id: region.id, name: region.name)));
      return ApiResult<List<RegionModel>>.success(data: result);
    } catch (e) {
      return ApiResult<List<RegionModel>>.failure(
          error: ErrorResult(message: "[Database Error] $e"));
    }
  }

  @override
  Future<ApiResult<List<SchoolModel>>> getAllSchools() async {
    try {
      final queryResult = await database.allSchools;
      final result = List.of(queryResult
          .map((region) => SchoolModel(id: region.id, name: region.name)));
      return ApiResult<List<SchoolModel>>.success(data: result);
    } catch (e) {
      return ApiResult<List<SchoolModel>>.failure(
          error: ErrorResult(message: "[Database Error] $e"));
    }
  }

  @override
  Future<ApiResult<DistrictModel>> getDistrictByID(String id) async {
    try {
      final queryResult = await database.getDistrictById(id);
      final result = DistrictModel(id: queryResult.id, name: queryResult.name);
      return ApiResult<DistrictModel>.success(data: result);
    } catch (e) {
      return ApiResult<DistrictModel>.failure(
          error: ErrorResult(message: "[Database Error] $e"));
    }
  }

  @override
  Future<ApiResult<StatisticsModel>> getDistrictStatistics() async {
    try {
      final queryResult = await database.countDistrictsVisitors();
      final result = queryResult.map((key, value) => MapEntry(key.id, value));
      return ApiResult<StatisticsModel>.success(data: StatisticsModel(result));
    } catch (e) {
      return ApiResult<StatisticsModel>.failure(
          error: ErrorResult(message: "[Database Error] $e"));
    }
  }

  @override
  Future<ApiResult<RegionModel>> getRegionByID(String id) async {
    try {
      final queryResult = await database.getRegionById(id);
      final result = RegionModel(id: queryResult.id, name: queryResult.name);
      return ApiResult<RegionModel>.success(data: result);
    } catch (e) {
      return ApiResult<RegionModel>.failure(
          error: ErrorResult(message: "[Database Error] $e"));
    }
  }

  @override
  Future<ApiResult<StatisticsModel>> getRegionStatistics() async {
    try {
      final queryResult = await database.countRegionsVisitors();
      final result = queryResult.map((key, value) => MapEntry(key.id, value));
      return ApiResult<StatisticsModel>.success(data: StatisticsModel(result));
    } catch (e) {
      return ApiResult<StatisticsModel>.failure(
          error: ErrorResult(message: "[Database Error] $e"));
    }
  }

  @override
  Future<ApiResult<SchoolModel>> getSchoolByID(String id) async {
    try {
      final queryResult = await database.getSchoolById(id);
      final result = SchoolModel(id: queryResult.id, name: queryResult.name);
      return ApiResult<SchoolModel>.success(data: result);
    } catch (e) {
      return ApiResult<SchoolModel>.failure(
          error: ErrorResult(message: "[Database Error] $e"));
    }
  }

  @override
  Future<ApiResult<StatisticsModel>> getSchoolStatistics() async {
    try {
      final queryResult = await database.countSchoolVisitors();
      final result = queryResult.map((key, value) => MapEntry(key.id, value));
      return ApiResult<StatisticsModel>.success(data: StatisticsModel(result));
    } catch (e) {
      return ApiResult<StatisticsModel>.failure(
          error: ErrorResult(message: "[Database Error] $e"));
    }
  }
}
