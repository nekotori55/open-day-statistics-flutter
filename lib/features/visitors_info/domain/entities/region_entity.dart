import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class RegionEntity extends Equatable {
  final String id;
  final String name;

  const RegionEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
