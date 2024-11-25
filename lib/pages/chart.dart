import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/weather.dart';
import 'app_resources.dart';

class _BarChart extends StatelessWidget {
  final Weather? weather;

  const _BarChart({required this.weather});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups, // Access weather here
        gridData: FlGridData(
            show: true, verticalInterval: 0.125, horizontalInterval: 5),
        alignment: BarChartAlignment.spaceAround,
        maxY: weather?.dailyWeather
                .map((e) => e.temperatureHigh + 3)
                .reduce((a, b) => a > b ? a : b) ??
            0,
        minY: 0,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: AppColors.contentColorCyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.contentColorBlue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = DateTime.fromMillisecondsSinceEpoch(
                weather!.dailyWeather[0].time * 1000,
                isUtc: true)
            .add(Duration(hours: 1))
            .day
            .toString();
        break;
      case 1:
        text = DateTime.fromMillisecondsSinceEpoch(
                weather!.dailyWeather[1].time * 1000,
                isUtc: true)
            .add(Duration(hours: 1))
            .day
            .toString();
        break;
      case 2:
        text = DateTime.fromMillisecondsSinceEpoch(
                weather!.dailyWeather[2].time * 1000,
                isUtc: true)
            .add(Duration(hours: 1))
            .day
            .toString();
        break;
      case 3:
        text = DateTime.fromMillisecondsSinceEpoch(
                weather!.dailyWeather[3].time * 1000,
                isUtc: true)
            .add(Duration(hours: 1))
            .day
            .toString();
        break;
      case 4:
        text = DateTime.fromMillisecondsSinceEpoch(
                weather!.dailyWeather[4].time * 1000,
                isUtc: true)
            .add(Duration(hours: 1))
            .day
            .toString();
        break;
      case 5:
        text = DateTime.fromMillisecondsSinceEpoch(
                weather!.dailyWeather[5].time * 1000)
            .day
            .toString();
        break;
      case 6:
        text = DateTime.fromMillisecondsSinceEpoch(
                weather!.dailyWeather[6].time * 1000,
                isUtc: true)
            .add(Duration(hours: 1))
            .day
            .toString();
        break;
      case 7:
        text = DateTime.fromMillisecondsSinceEpoch(
                weather!.dailyWeather[7].time * 1000,
                isUtc: true)
            .add(Duration(hours: 1))
            .day
            .toString();
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          AppColors.contentColorBlue,
          AppColors.contentColorCyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: weather!.dailyWeather[0].temperatureHigh,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: weather!.dailyWeather[1].temperatureHigh,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: weather!.dailyWeather[2].temperatureHigh,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: weather!.dailyWeather[3].temperatureHigh,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: weather!.dailyWeather[4].temperatureHigh,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: weather!.dailyWeather[5].temperatureHigh,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: weather!.dailyWeather[6].temperatureHigh,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              toY: weather!.dailyWeather[7].temperatureHigh,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class BarChartSample3 extends StatefulWidget {
  final Weather? weather;

  const BarChartSample3({super.key, required this.weather});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: _BarChart(weather: widget.weather),
    );
  }
}
