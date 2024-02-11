import 'package:meta/meta.dart';

@immutable
class SchoolInfoEntity {
  final String id;
  final String name;

  const SchoolInfoEntity({
    required this.id,
    required this.name,
  });
}
