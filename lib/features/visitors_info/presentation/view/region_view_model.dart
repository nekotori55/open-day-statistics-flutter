import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/region_entity.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/base_view_model.dart';

class RegionViewModel extends ViewModel {

  RegionViewModel({required this.id, required this.name});

  factory RegionViewModel.fromEntity(RegionEntity entity) {
    return RegionViewModel(id: entity.id, name: entity.name);
  }

  RegionEntity toEntity() {
    return RegionEntity(id: id, name: name);
  }

  final String id;
  final String name;

  @override
  String toStringByName() {
    return name;
  }
}