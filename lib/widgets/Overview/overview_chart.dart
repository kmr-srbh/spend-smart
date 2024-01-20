import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:spend_smart/widgets/data_manager.dart';

class OverviewChart extends StatelessWidget {
  const OverviewChart({super.key, required this.expensesData});

  final List<Map<String, dynamic>> expensesData;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: DataManager().expenseBox.listenable(),
      builder: (context, value, child) => Container(
        margin: const EdgeInsets.only(top: 24),
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: AspectRatio(
          aspectRatio: 1.7,
          child: LineChart(
            LineChartData(
              minX: 1,
              maxX: 30,
              minY: 0,
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  isStrokeCapRound: true,
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ]),
                  spots: const [
                    FlSpot(1, 300),
                    FlSpot(2, 140),
                    FlSpot(3, 325),
                    FlSpot(4, 124),
                    FlSpot(5, 45),
                    FlSpot(6, 0),
                  ],
                )
              ],
              titlesData: const FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
            ),
          ),
        ),
      ),
    );
}
