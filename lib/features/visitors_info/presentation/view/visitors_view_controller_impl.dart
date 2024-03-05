import 'package:open_day_statistics_flutter/core/common_domain/api_result.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/domain/repositories/visitor_statistics_repository.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/district_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/region_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/school_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/visitor_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/visitors_view_controller.dart';

class VisitorsViewControllerImpl extends VisitorsViewController {
  VisitorsViewControllerImpl({required this.repository});

  final VisitorStatisticsRepository repository;
  final List<Function(String? msg)> _errorListeners = [];


  void addListener(Function(String? msg) func) {
    _errorListeners.add(func);
  }

  void removeListener(Function(String? msg) func) {
    _errorListeners.remove(func);
  }

  void notifyErrorListeners(String? msg) {
    for (var element in _errorListeners) {
      element.call(msg);
    }
  }

  @override
  Future<void> addVisitor(VisitorViewModel visitor) async {
    var response = await repository.addVisitor(visitor.toEntity());
    if (response case Failure()) {
      notifyErrorListeners(response.error.message);
    }
    return;
  }

  @override
  Future<List<DistrictViewModel>> getAllDistricts() async {
    var response = await repository.getAllDistricts();
    switch (response) {
      case Failure():
        notifyErrorListeners(response.error.message);
        return [];
      case Success():
        return response.data
            .map((e) => DistrictViewModel.fromEntity(e))
            .toList();
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<List<RegionViewModel>> getAllRegions() async {
    var response = await repository.getAllRegions();
    switch (response) {
      case Failure():
        notifyErrorListeners(response.error.message);
        return [];
      case Success():
        return response.data.map((e) => RegionViewModel.fromEntity(e)).toList();
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<List<SchoolViewModel>> getAllSchools() async {
    var response = await repository.getAllSchools();
    switch (response) {
      case Failure():
        notifyErrorListeners(response.error.message);
        return [];
      case Success():
        return response.data.map((e) => SchoolViewModel.fromEntity(e)).toList();
      default:
        throw UnimplementedError();
    }
  }
}