import 'dart:math';

import 'package:flutter/material.dart';

class LeadersTable extends StatelessWidget {
  const LeadersTable({
    super.key,
    required this.data,
    this.border,
  });

  final List<({String name, int count})> data;
  final TableBorder? border;

  @override
  Widget build(BuildContext context) {
    data.sort((a, b) => b.count.compareTo(a.count));
    return DataTable(
      clipBehavior: Clip.antiAlias,
      border: border,
      columns: const [
        DataColumn(
          label: Text("Название"),
        ),
        DataColumn(
          label: Text("Количество"),
          numeric: true,
        ),
      ],
      rows: data
          .take(min(5, data.length))
          .map((e) => DataRow(cells: [
                DataCell(Text(e.name)),
                DataCell(Text(e.count.toString())),
              ], key: ObjectKey(e.name)))
          .toList(),
    );
  }
}
