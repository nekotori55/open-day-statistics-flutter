import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/statistics_entity.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/base_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/district_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/region_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/school_view_model.dart';

class StatisticsViewModel<SubjectType extends ViewModel> extends ViewModel {

  final Map<SubjectType, int> subjectToVisitorNumber;

  final int total;


  StatisticsViewModel({required this.subjectToVisitorNumber, required this.total});


  factory StatisticsViewModel.fromEntity(StatisticsEntity entity) {
    Type typeOf<X>() => X;

    late var viewToNum;
    var type = typeOf<SubjectType>();
    switch (type) {
      case RegionViewModel:
        viewToNum = entity.subjectToVisitorsNumber.map((key, value) => MapEntry(RegionViewModel.fromEntity(key), value));
      case DistrictViewModel:
        viewToNum = entity.subjectToVisitorsNumber.map((key, value) => MapEntry(DistrictViewModel.fromEntity(key), value));
      case SchoolViewModel:
        viewToNum = entity.subjectToVisitorsNumber.map((key, value) => MapEntry(SchoolViewModel.fromEntity(key), value));
      default: throw ArgumentError("Invalid type");
    }

    return StatisticsViewModel(subjectToVisitorNumber: viewToNum, total:entity.getTotal());
  }

  @override
  String toStringByName() {
    // TODO: implement toStringByName
    throw UnimplementedError();
  }
}