import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/school_entity.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/base_view_model.dart';

class SchoolViewModel extends ViewModel {

  SchoolViewModel({required this.id, required this.name});

  factory SchoolViewModel.fromEntity(SchoolEntity entity) {
    return SchoolViewModel(id: entity.id, name: entity.name);
  }

  SchoolEntity toEntity() {
    return SchoolEntity(id: id, name: name);
  }

  final String id;
  final String name;

  @override
  String toStringByName() {
    return name;
  }
}