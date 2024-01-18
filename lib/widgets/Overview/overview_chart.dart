import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

class OverviewChart extends StatelessWidget {
  const OverviewChart({super.key, required this.expensesData});

  final List<Map<String, dynamic>> expensesData;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(top: 24),
    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
    child: AspectRatio(
      aspectRatio: 1.7,
      child: LineChart(
            LineChartData(),
          ),
    ),
  );
}
