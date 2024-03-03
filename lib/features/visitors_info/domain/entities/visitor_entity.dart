import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'school_entity.dart';
import 'district_entity.dart';
import 'region_entity.dart';

enum Grade { minor, ninth, tenth, eleventh }

@immutable
class VisitorEntity extends Equatable {
  final RegionEntity region;

  final DistrictEntity district;

  final SchoolEntity school;

  final Grade grade;

  const VisitorEntity({
    required this.region,
    required this.district,
    required this.school,
    required this.grade,
  });

  @override
  List<Object?> get props => [region, district, school, grade];
}
