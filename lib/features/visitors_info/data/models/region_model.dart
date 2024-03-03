import '../../domain/entities/region_entity.dart';

class RegionModel {
  final String id;
  final String name;

  RegionModel({required this.id, required this.name});

  RegionEntity toEntity() {
    return RegionEntity(id: id, name: name);
  }
}