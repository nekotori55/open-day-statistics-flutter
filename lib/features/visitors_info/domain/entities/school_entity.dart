import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class SchoolEntity extends Equatable{
  final String id;
  final String name;

  const SchoolEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
