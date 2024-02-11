import 'region_info_entity.dart';

class StatisticsEntity {
  final Map<String, int> idToVisitorsNumber; //id to visitors count

  int count;

  StatisticsEntity({
    required this.idToVisitorsNumber,
    required this.count,
  });
}
