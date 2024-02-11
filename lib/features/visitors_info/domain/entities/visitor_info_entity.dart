import 'package:meta/meta.dart';

enum Grade { minor, ninth, tenth, eleventh }

@immutable
class VisitorInfoEntity {
  final String regionID;

  final String districtID;

  final String schoolID;

  final Grade grade;

  const VisitorInfoEntity({
    required this.regionID,
    required this.districtID,
    required this.schoolID,
    required this.grade,
  });
}
