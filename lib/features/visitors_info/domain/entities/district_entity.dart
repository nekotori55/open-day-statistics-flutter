import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class DistrictEntity extends Equatable{
  final String id;
  final String name;

  const DistrictEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
