import 'package:open_day_statistics_flutter/core/common_domain/api_result.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/district_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/region_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/school_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/statistics_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/models/visitor_model.dart';

abstract class VisitorStatisticsDatasource {
  Future<ApiResult<Null>> addVisitor(VisitorModel visitor);

  Future<ApiResult<List<DistrictModel>>> getAllDistricts();

  Future<ApiResult<List<RegionModel>>> getAllRegions();

  Future<ApiResult<List<SchoolModel>>> getAllSchools();

  Future<ApiResult<DistrictModel>> getDistrictByID(String id);

  Future<ApiResult<StatisticsModel>> getDistrictStatistics();

  Future<ApiResult<RegionModel>> getRegionByID(String id);

  Future<ApiResult<StatisticsModel>> getRegionStatistics() ;

  Future<ApiResult<SchoolModel>> getSchoolByID(String id) ;

  Future<ApiResult<StatisticsModel>> getSchoolStatistics();
}
