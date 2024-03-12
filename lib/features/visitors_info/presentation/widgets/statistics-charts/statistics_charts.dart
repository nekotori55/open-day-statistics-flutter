import 'package:flutter/material.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/leaders-table/leaders-table.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/pie-chart/visitors_pie_chart.dart';

class StatisticsCharts extends StatelessWidget {
  const StatisticsCharts({
    super.key,
    required this.data,
    required this.label,
  });

  final (Map<String, int>, {int total}) data;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 300, child: VisitorsPieChart(data: data)),
            Container(
              color: Colors.white,
              child: LeadersTable(
                border: TableBorder.all(width: 1, color: Colors.grey),
                label: label,
                data: data.$1.entries
                    .map((e) => (name: e.key, count: e.value))
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
