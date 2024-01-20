import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

class OverviewChart extends StatelessWidget {
  const OverviewChart({super.key, required this.expensesData});

  final List<Map<String, dynamic>> expensesData;

  @override
  Widget build(BuildContext context) {
    double d = 0;
    final List<FlSpot> points = expensesData.length < 7
        ? expensesData.reversed
            .toList()
            .map((e) => FlSpot(++d, (e['totalAmount'] as int).toDouble()))
            .toList()
        : expensesData.reversed
            .toList()
            .take(7)
            .map((e) => FlSpot(++d, (e['totalAmount'] as int).toDouble()))
            .toList();

    return Container(
      margin: const EdgeInsets.only(top: 56, right: 16),
      child: AspectRatio(
        aspectRatio: 1.7,
        child: LineChart(
          LineChartData(
            minX: 1,
            maxX: 7,
            minY: 0,
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                isStrokeCapRound: true,
                barWidth: 3,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    Theme.of(context)
                        .colorScheme
                        .secondaryContainer
                        .withOpacity(0.3),
                  ]),
                ),
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondaryContainer,
                ]),
                spots: points,
              )
            ],
            titlesData: const FlTitlesData(
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
