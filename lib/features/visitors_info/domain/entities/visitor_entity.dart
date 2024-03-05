import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'school_entity.dart';
import 'district_entity.dart';
import 'region_entity.dart';


@immutable
class VisitorEntity extends Equatable {
  final RegionEntity region;

  final DistrictEntity? district;

  final SchoolEntity? school;


  const VisitorEntity({
    required this.region,
    required this.district,
    required this.school,
  });

  @override
  List<Object?> get props => [region, district, school];
}
