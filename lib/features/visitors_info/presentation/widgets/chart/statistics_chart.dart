import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class StatisticsChart extends StatefulWidget {
  const StatisticsChart({Key? key, required this.dataMap}) : super(key: key);

  final Map<String, double> dataMap;
  @override
  _StatisticsChartState createState() => _StatisticsChartState();
}

class _StatisticsChartState extends State<StatisticsChart> {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: widget.dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartRadius: MediaQuery.of(context).size.width / 8,
      chartType: ChartType.ring,
      ringStrokeWidth: MediaQuery.of(context).size.width / 36,
      centerText: "HYBRID",
      chartLegendSpacing: 40,
      chartValuesOptions: ChartValuesOptions(
        showChartValuesInPercentage: true,
        showChartValuesOutside: true,
      ),
      degreeOptions: DegreeOptions(
        initialAngle: 0,
        totalDegrees: 359.9,
      ),
    );
  }
}
