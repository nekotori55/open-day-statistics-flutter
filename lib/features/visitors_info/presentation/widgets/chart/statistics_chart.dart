import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class StatisticsChart extends StatefulWidget {
  const StatisticsChart({Key? key, required this.getIdMap}) : super(key: key);

  final Future<(int ,Map<String, int>)> Function() getIdMap;
  // final Future<Map<String, int>> Function() getIdMap;
  @override
  _StatisticsChartState createState() => _StatisticsChartState();
}

class _StatisticsChartState extends State<StatisticsChart>
    with TickerProviderStateMixin {

  late Animation<double> _animation;
  late AnimationController _controller;
  Map<String, int> idmap = {};
  int total = 0;

  updateMap() async {
    var something = await widget.getIdMap();
    idmap = something.$2;
    total = something.$1;
  }


  @override
  void initState() {
    updateMap();
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    Tween<double> _shift = Tween(begin: 0.0, end: 13.0);

    _animation = _shift.animate(_controller)
      ..addListener(() {
        setState(() {
          updateMap();
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap;
    if (idmap.length == 0) {
      dataMap = {"Нет данных": 1.0};
    }
    else {
      dataMap = idmap.map((key, val) => MapEntry(key, val.toDouble()));
    }

    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 0),

      chartRadius: MediaQuery.of(context).size.width / 8,
      chartType: ChartType.ring,
      ringStrokeWidth: MediaQuery.of(context).size.width / 36,
      centerText: "Всего: " + total.toString(),
      chartLegendSpacing: 40,
      chartValuesOptions: ChartValuesOptions(
        showChartValuesInPercentage: true,
        showChartValuesOutside: true,
      ),
      degreeOptions: DegreeOptions(
        initialAngle: 0,
        totalDegrees: 360,
      ),
    );
  }
}
