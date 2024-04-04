import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisitorsPieChart extends StatelessWidget {
  const VisitorsPieChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  final (Map<String, int>, {int total}) data;

  Color _generatePastelColor(int hash) {
    var R = (hash % 1000) % 127 + 127;
    var G = (hash ~/ 1000) % 127 + 127;
    var B = (hash * 3) % 127 + 127;

    return Color.fromARGB(0xFF, R, B, G);
  }

  @override
  Widget build(BuildContext context) {
    var myData = data.$1.entries.toList();
    myData.sort(
      (a, b) => b.value.compareTo(a.value),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            swapAnimationDuration: Duration(milliseconds: 800),
            PieChartData(
              centerSpaceRadius: 50,
              sectionsSpace: 0.5,
              sections: data.total == 0
                  ? [
                      PieChartSectionData(
                        value: 1,
                        title: "Нет данных",
                        titlePositionPercentageOffset: -0.72,
                        radius: 70,
                        color: Colors.blueGrey,
                        titleStyle: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      )
                    ]
                  : [
                        PieChartSectionData(
                          value: 0.001,
                          showTitle: true,
                          title: "Всего: ${data.total}",
                          titlePositionPercentageOffset: -1.2,
                          titleStyle: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        )
                      ] +
                      myData.map((e) {
                        var percentage = (e.value / data.total * 100);
                        return PieChartSectionData(
                          value: e.value.toDouble(),
                          color: _generatePastelColor(e.key.hashCode),
                          showTitle: percentage >= 5.0,
                          title: "${percentage.toStringAsFixed(0)}%",
                          radius: 70,
                          titleStyle: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        );
                      }).toList(),
            ),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: data.total == 0
              ? [SizedBox(width: 270)]
              : myData.take(min(10, myData.length)).map((e) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: _generatePastelColor(e.key.hashCode),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          SizedBox(
                            width: 250,
                            child: Text(
                              e.key,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                }).toList(),
        )
      ],
    );
  }
}
