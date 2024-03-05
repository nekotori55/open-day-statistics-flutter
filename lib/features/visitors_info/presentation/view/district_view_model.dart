import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/district_entity.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/base_view_model.dart';

class DistrictViewModel extends ViewModel {

  DistrictViewModel({required this.id, required this.name});

  factory DistrictViewModel.fromEntity(DistrictEntity entity) {
    return DistrictViewModel(id: entity.id, name: entity.name);
  }

  DistrictEntity toEntity() {
    return DistrictEntity(id: id, name: name);
  }

  final String id;
  final String name;

  @override
  String toStringByName() {
    return name;
  }


}