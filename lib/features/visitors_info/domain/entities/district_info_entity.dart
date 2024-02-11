import 'package:meta/meta.dart';

@immutable
class DistrictInfoEntity {
  final String id;
  final String name;

  const DistrictInfoEntity({
    required this.id,
    required this.name,
  });
}
