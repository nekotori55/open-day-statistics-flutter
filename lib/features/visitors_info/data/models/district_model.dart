import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/district_entity.dart';

class DistrictModel {
  final String name;

  final String id;

  DistrictModel({required this.id, required this.name});

  DistrictEntity toEntity() {
    return DistrictEntity(id: id, name: name);
  }
}
