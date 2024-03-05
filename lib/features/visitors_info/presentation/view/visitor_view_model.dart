import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/visitor_entity.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/base_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/district_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/region_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/school_view_model.dart';

class VisitorViewModel extends ViewModel {
  VisitorViewModel(
      {required this.district, required this.region, required this.school});

  factory VisitorViewModel.fromEntity(VisitorEntity entity) {
    return VisitorViewModel(
        district: DistrictViewModel.fromEntity(entity.district),
        region: RegionViewModel.fromEntity(entity.region),
        school: SchoolViewModel.fromEntity(entity.school));
  }

  VisitorEntity toEntity() {
    return VisitorEntity(
        region: region.toEntity(),
        district: district.toEntity(),
        school: school.toEntity());
  }

  final DistrictViewModel district;
  final RegionViewModel region;
  final SchoolViewModel school;

  @override
  String toStringByName() {
    // TODO: implement toStringByName
    throw UnimplementedError();
  }
}
