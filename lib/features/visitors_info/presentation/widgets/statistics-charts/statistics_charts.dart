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
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 300, child: VisitorsPieChart(data: data)),
              const SizedBox(height: 30),
              SizedBox(
                width: 600,
                height: 300,
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
        ),
      ),
    );
  }
}
