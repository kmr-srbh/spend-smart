import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

class OverviewChart extends StatelessWidget {
  const OverviewChart({super.key, required this.expensesData});

  final List<Map<String, dynamic>> expensesData;

  @override
  Widget build(BuildContext context) {
    double d = 0;
    List<Map<String, dynamic>> pointData =
        expensesData.take(7).toList().reversed.toList();
    List<FlSpot> points = pointData
        .map((e) => FlSpot(++d, (e['totalAmount'] as int).toDouble()))
        .toList();

    return AspectRatio(
      aspectRatio: 1.33,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 24, 24, 0),
        child: LineChart(
          curve: Curves.linear,
          LineChartData(
            minX: 1,
            maxX: 7,
            minY: 0,
            lineTouchData: const LineTouchData(
                touchTooltipData: LineTouchTooltipData(
              fitInsideHorizontally: true,
              fitInsideVertically: true,
            )),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                  strokeWidth: 1,
                );
              },
            ),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                isStrokeCapRound: true,
                barWidth: 3,
                preventCurveOverShooting: true,
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.3),
                  ]),
                ),
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primaryContainer,
                ]),
                spots: points,
              )
            ],
            titlesData: FlTitlesData(
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                drawBelowEverything: true,
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 48,
                  getTitlesWidget: (value, meta) {
                    if (value == meta.max) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: const Text(''),
                      );
                    } else {
                      if (value >= 1000) {
                        String valueText = '${(value.toInt() / 1000)}K';
                        return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 12,
                            child: Text(
                              valueText,
                              textAlign: TextAlign.left,
                            ));
                      } else {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 12,
                          child: Text(
                            value.toInt().toString(),
                            textAlign: TextAlign.left,
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                drawBelowEverything: true,
                sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    reservedSize: 56,
                    getTitlesWidget: (value, meta) {
                      String title;
                      List<Text> titleData = pointData.map((e) {
                        if ((e['date'] as DateTime).day == DateTime.now().day) {
                          title = 'Today';
                        } else {
                          title =
                              '${(e['date'] as DateTime).day.toString().padLeft(2, '0')}/${(e['date'] as DateTime).month.toString().padLeft(2, '0')}';
                        }
                        return Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      }).toList();
                      try {
                        return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 12,
                            child: titleData[value.toInt() - 1]);
                      } catch (e) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: const Text(''),
                        );
                      }
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
