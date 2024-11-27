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
    String dayNum;
    String dayName = "";
    switch (value.toInt()) {
      case 0:
        dayNum = getDayNumber(0);
        dayName = getDayName(0);
        break;
      case 1:
        dayNum = getDayNumber(1);
        dayName = getDayName(1);
        break;
      case 2:
        dayNum = getDayNumber(2);
        dayName = getDayName(2);
        break;
      case 3:
        dayNum = getDayNumber(3);
        dayName = getDayName(3);
        break;
      case 4:
        dayNum = getDayNumber(4);
        dayName = getDayName(4);
        break;
      case 5:
        dayNum = getDayNumber(5);
        dayName = getDayName(5);
        break;
      case 6:
        dayNum = getDayNumber(6);
        dayName = getDayName(6);
        break;
      case 7:
        dayNum = getDayNumber(7);
        dayName = getDayName(7);
        break;
      default:
        dayNum = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4, // Ensure adequate spacing between axis and dayNum
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Ensure the column does not take extra space
        children: [
          Text(dayNum, style: style), // Main text
          Text(dayName, style: style.copyWith(fontSize: 10)), // Secondary text
        ],
      ),
    );
  }

  String getDayName(int i) {
    int weekday = DateTime.fromMillisecondsSinceEpoch(
      weather!.dailyWeather[i].time * 1000,
      isUtc: true,
    ).add(Duration(hours: 1)).weekday;

    String weekdayName = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ][weekday - 1];

    return weekdayName.substring(0, 3);
  }

  String getDayNumber(int i) {
    return DateTime.fromMillisecondsSinceEpoch(
            weather!.dailyWeather[i].time * 1000,
            isUtc: true)
        .add(Duration(hours: 1))
        .day
        .toString();
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
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
