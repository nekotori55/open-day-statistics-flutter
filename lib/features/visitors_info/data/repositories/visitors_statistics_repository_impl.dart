import 'package:open_day_statistics_flutter/core/common_domain/api_result.dart';
import 'package:open_day_statistics_flutter/core/common_domain/error_result.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/data_sources/visitor_statistics_datasource.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/district_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/region_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/statistics_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/district_entity.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/region_entity.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/school_entity.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/statistics_entity.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/visitor_entity.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/domain/repositories/visitor_statistics_repository.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/school_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/visitor_model.dart';

class VisitorStatisticsRepositoryImpl extends VisitorStatisticsRepository {
  final VisitorStatisticsDatasource datasource;
  final bool useCache;

  List<DistrictEntity>? _districtsCache;
  List<RegionEntity>? _regionCache;
  List<SchoolEntity>? _schoolCache;

  @override
  Future<ApiResult<Null>> addVisitor(VisitorEntity visitor) {
    var visitorModel = VisitorModel(
        regionID: visitor.region.id,
        districtID: visitor.district?.id,
        schoolID: visitor.school?.id);

    return datasource.addVisitor(visitorModel);
  }

  @override
  Future<ApiResult<List<DistrictEntity>>> getAllDistricts() async {
    if (_districtsCache != null) {
      return ApiResult<List<DistrictEntity>>.success(data: _districtsCache!);
    }

    var result = await datasource.getAllDistricts();
    switch (result) {
      case Success():
        List<DistrictModel> resultData = result.data;
        _districtsCache = resultData.map((e) => e.toEntity()).toList();
        return ApiResult<List<DistrictEntity>>.success(data: _districtsCache!);

      case Failure():
        return ApiResult<List<DistrictEntity>>.failure(error: result.error);

      default:
        throw TypeError();
    }
  }

  @override
  Future<ApiResult<List<RegionEntity>>> getAllRegions() async {
    if (_regionCache != null) {
      return ApiResult<List<RegionEntity>>.success(data: _regionCache!);
    }

    var result = await datasource.getAllRegions();
    switch (result) {
      case Success():
        List<RegionModel> resultData = result.data;
        _regionCache = resultData.map((e) => e.toEntity()).toList();
        return ApiResult<List<RegionEntity>>.success(data: _regionCache!);

      case Failure():
        return ApiResult<List<RegionEntity>>.failure(error: result.error);

      default:
        throw TypeError();
    }
  }

  @override
  Future<ApiResult<List<SchoolEntity>>> getAllSchools() async {
    if (_schoolCache != null) {
      return ApiResult<List<SchoolEntity>>.success(data: _schoolCache!);
    }

    var result = await datasource.getAllSchools();
    switch (result) {
      case Success():
        List<SchoolModel> resultData = result.data;
        var entitiesList = resultData.map((e) => e.toEntity()).toList();
        return ApiResult<List<SchoolEntity>>.success(data: entitiesList);

      case Failure():
        return ApiResult<List<SchoolEntity>>.failure(error: result.error);

      default:
        throw TypeError();
    }
  }

  @override
  Future<ApiResult<DistrictEntity>> getDistrictByID(String id) async {
    var result = await datasource.getDistrictByID(id);
    switch (result) {
      case Success():
        DistrictModel resultData = result.data;
        return ApiResult<DistrictEntity>.success(data: resultData.toEntity());
      case Failure():
        return ApiResult<DistrictEntity>.failure(error: result.error);
      default:
        throw TypeError();
    }
  }

  @override
  Future<ApiResult<StatisticsEntity<DistrictEntity>>>
      getDistrictStatistics() async {
    var result = await datasource.getDistrictStatistics();
    switch (result) {
      case Success():
        StatisticsModel resultData = result.data;
        Map<DistrictEntity, int> a = {};

        for (var element in resultData.idToTotal.entries) {
          var apiResult = await getDistrictByID(element.key);
          switch (apiResult) {
            case Success():
              var entity = (apiResult as Success).data;
              a[entity] = element.value;
            case Failure():
              return ApiResult<StatisticsEntity<DistrictEntity>>.failure(
                  error: apiResult.error);
          }
        }

        return ApiResult<StatisticsEntity<DistrictEntity>>.success(
            data: StatisticsEntity(subjectToVisitorsNumber: a));

      case Failure():
        return ApiResult<StatisticsEntity<DistrictEntity>>.failure(
            error: result.error);

      default:
        throw TypeError();
    }
  }

  @override
  Future<ApiResult<RegionEntity>> getRegionByID(String id) async {
    var result = await datasource.getRegionByID(id);
    switch (result) {
      case Success():
        RegionModel resultData = result.data;
        return ApiResult<RegionEntity>.success(data: resultData.toEntity());
      case Failure():
        return ApiResult<RegionEntity>.failure(error: result.error);
      default:
        throw TypeError();
    }
  }

  @override
  Future<ApiResult<StatisticsEntity<RegionEntity>>>
      getRegionStatistics() async {
    var result = await datasource.getRegionStatistics();
    switch (result) {
      case Success():
        StatisticsModel resultData = result.data;
        Map<RegionEntity, int> a = {};

        for (var element in resultData.idToTotal.entries) {
          var apiResult = await getRegionByID(element.key);
          switch (apiResult) {
            case Success():
              var entity = (apiResult as Success).data;
              a[entity] = element.value;
            case Failure():
              return ApiResult<StatisticsEntity<RegionEntity>>.failure(
                  error: apiResult.error);
          }
        }

        return ApiResult<StatisticsEntity<RegionEntity>>.success(
            data: StatisticsEntity(subjectToVisitorsNumber: a));

      case Failure():
        return ApiResult<StatisticsEntity<RegionEntity>>.failure(
            error: result.error);

      default:
        throw TypeError();
    }
  }

  @override
  Future<ApiResult<SchoolEntity>> getSchoolByID(String id) async {
    var result = await datasource.getSchoolByID(id);
    switch (result) {
      case Success():
        SchoolModel resultData = result.data;
        return ApiResult<SchoolEntity>.success(data: resultData.toEntity());
      case Failure():
        return ApiResult<SchoolEntity>.failure(error: result.error);
      default:
        throw TypeError();
    }
  }

  @override
  Future<ApiResult<StatisticsEntity<SchoolEntity>>>
      getSchoolStatistics() async {
    var result = await datasource.getSchoolStatistics();
    switch (result) {
      case Success():
        StatisticsModel resultData = result.data;
        Map<SchoolEntity, int> a = {};

        for (var element in resultData.idToTotal.entries) {
          var apiResult = await getSchoolByID(element.key);
          switch (apiResult) {
            case Success():
              var entity = (apiResult as Success).data;
              a[entity] = element.value;
            case Failure():
              return ApiResult<StatisticsEntity<SchoolEntity>>.failure(
                  error: apiResult.error);
          }
        }
        return ApiResult<StatisticsEntity<SchoolEntity>>.success(
            data: StatisticsEntity(subjectToVisitorsNumber: a));

      case Failure():
        return ApiResult<StatisticsEntity<SchoolEntity>>.failure(
            error: result.error);

      default:
        throw TypeError();
    }
  }

  VisitorStatisticsRepositoryImpl(
      {required this.useCache, required this.datasource});
}
