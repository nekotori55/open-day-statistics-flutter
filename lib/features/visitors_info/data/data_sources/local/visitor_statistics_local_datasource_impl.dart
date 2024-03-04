import 'package:open_day_statistics_flutter/core/common_domain/api_result.dart';
import 'package:open_day_statistics_flutter/core/common_domain/error_result.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/data_sources/visitor_statistics_datasource.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/district_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/region_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/school_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/statistics_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/visitor_model.dart';

class VisitorStatisticsLocalDatasourceImpl
    implements VisitorStatisticsDatasource {

  @override
  Future<ApiResult<Null>> addVisitor(VisitorModel visitor) async {
    try {
      // TODO: implement
      throw UnimplementedError();
    } catch (e) {
      return ApiResult<Null>.failure(error: ErrorResult(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<List<DistrictModel>>> getAllDistricts() async {
    try {
      // TODO: implement
      throw UnimplementedError();
    } catch (e) {
      return ApiResult<List<DistrictModel>>.failure(error: ErrorResult(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<List<RegionModel>>> getAllRegions() async {
    try {
      // TODO: implement
      throw UnimplementedError();
    } catch (e) {
      return ApiResult<List<RegionModel>>.failure(error: ErrorResult(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<List<SchoolModel>>> getAllSchools() async {
    try {
      // TODO: implement
      throw UnimplementedError();
    } catch (e) {
      return ApiResult<List<SchoolModel>>.failure(error: ErrorResult(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<DistrictModel>> getDistrictByID(String id) async {
    try {
      // TODO: implement
      throw UnimplementedError();
    } catch (e) {
      return ApiResult<DistrictModel>.failure(error: ErrorResult(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<StatisticsModel>> getDistrictStatistics() async {
    try {
      // TODO: implement
      throw UnimplementedError();
    } catch (e) {
      return ApiResult<StatisticsModel>.failure(error: ErrorResult(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<RegionModel>> getRegionByID(String id) async {
    try {
      // TODO: implement
      throw UnimplementedError();
    } catch (e) {
      return ApiResult<RegionModel>.failure(error: ErrorResult(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<StatisticsModel>> getRegionStatistics() async {
    try {
      // TODO: implement
      throw UnimplementedError();
    } catch (e) {
      return ApiResult<StatisticsModel>.failure(error: ErrorResult(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<SchoolModel>> getSchoolByID(String id) async {
    try {
      // TODO: implement
      throw UnimplementedError();
    } catch (e) {
      return ApiResult<SchoolModel>.failure(error: ErrorResult(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<StatisticsModel>> getSchoolStatistics() async {
    try {
      // TODO: implement
      throw UnimplementedError();
    } catch (e) {
      return ApiResult<StatisticsModel>.failure(error: ErrorResult(message: e.toString()));
    }
  }
}
