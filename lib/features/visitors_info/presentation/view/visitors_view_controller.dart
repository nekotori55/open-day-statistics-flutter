import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/district_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/region_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/school_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/visitor_view_model.dart';
import 'statistics_view_model.dart';

abstract class VisitorsViewController {

  void addVisitor(VisitorViewModel visitor);

  Future<List<RegionViewModel>> getAllRegions();
  Future<List<DistrictViewModel>> getAllDistricts();
  Future<List<SchoolViewModel>> getAllSchools();
  Future<StatisticsViewModel<RegionViewModel>> getRegionStatistics();
  Future<StatisticsViewModel<DistrictViewModel>> getDistrictStatistics();
  Future<StatisticsViewModel<SchoolViewModel>> getSchoolStatistics();

}