import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/district_entity.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/statistics_entity.dart';
import 'package:open_day_statistics_flutter/core/common_domain/api_result.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/visitor_entity.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/region_entity.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/school_entity.dart';

abstract class VisitorStatisticsRepository {
  Future<ApiResult<StatisticsEntity<RegionEntity>>> getRegionStatistics();
  Future<ApiResult<StatisticsEntity<DistrictEntity>>> getDistrictStatistics();
  Future<ApiResult<StatisticsEntity<SchoolEntity>>> getSchoolStatistics();

  Future<ApiResult<List<RegionEntity>>> getAllRegions();
  Future<ApiResult<List<DistrictEntity>>> getAllDistricts();
  Future<ApiResult<List<SchoolEntity>>> getAllSchools();

  Future<ApiResult<DistrictEntity>> getDistrictByID(String id);
  Future<ApiResult<RegionEntity>> getRegionByID(String id);
  Future<ApiResult<SchoolEntity>> getSchoolByID(String id);

  Future<ApiResult<Null>> addVisitor(VisitorEntity visitor);
}
