class StatisticsEntity<SubjectType> {
  final Map<SubjectType, int> subjectToVisitorsNumber; //id to visitors count

  int? _totalCached;

  int getTotal() {
    if (_totalCached == null) {
      var values = subjectToVisitorsNumber.values;
      if (values.isEmpty) {
        _totalCached = 0;
      } else {
        _totalCached = values.reduce((sum, element) => sum + element);
      }
    }
    return _totalCached!;
  }

  StatisticsEntity({
    required this.subjectToVisitorsNumber,
  });
}
