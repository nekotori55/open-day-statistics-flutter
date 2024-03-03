import 'package:open_day_statistics_flutter/features/visitors_info/domain/entities/school_entity.dart';

class SchoolModel {
  final String name;
  final String id;

  SchoolModel({required this.name, required this.id});

  SchoolEntity toEntity() {
    return SchoolEntity(id: id, name: name);
  }

}