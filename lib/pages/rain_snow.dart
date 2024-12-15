import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/weather.dart';
import 'app_resources.dart';

class RainSnow extends StatefulWidget {
  final Weather? weather;

  const RainSnow({super.key, required this.weather});

  @override
  State<RainSnow> createState() => _RainSnowState();
}

class _RainSnowState extends State<RainSnow> {
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 3,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 25,
              left: 25,
              top: 30,
              bottom: 0,
            ),
            child: LineChart(mainData()),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: AppColors.contentColorWhite.withOpacity(0.4),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String dayNum;
    String dayName;
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
        dayName = '';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Ensure the column does not take extra space
        children: [
          Text(dayNum, style: style), // Main text
          Text(
            dayName,
            style: style.copyWith(fontSize: 10, fontWeight: FontWeight.normal),
          ), // Secondary text
        ],
      ),
    );
  }

  String getDayNumber(int i) {
    return DateTime.fromMillisecondsSinceEpoch(
            widget.weather!.dailyWeather[i].time * 1000,
            isUtc: true)
        .add(Duration(hours: 1))
        .day
        .toString();
  }

  String getDayName(int i) {
    int weekday = DateTime.fromMillisecondsSinceEpoch(
      widget.weather!.dailyWeather[i].time * 1000,
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

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 2:
        text = '2';
        break;
      case 4:
        text = '4';
        break;
      case 6:
        text = '6';
        break;
      case 8:
        text = '8';
        break;
      case 10:
        text = '10';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    List<int> showingTooltipOnSpots = [0, 1, 2, 3, 4, 5, 6, 7];

    return LineChartData(
      showingTooltipIndicators: showingTooltipOnSpots.map((index) {
        return ShowingTooltipIndicators([
          LineBarSpot(
            LineChartBarData(
              spots: [
                FlSpot(0, widget.weather!.dailyWeather[0].temperatureHigh),
                FlSpot(1, widget.weather!.dailyWeather[1].temperatureHigh),
                FlSpot(2, widget.weather!.dailyWeather[2].temperatureHigh),
                FlSpot(3, widget.weather!.dailyWeather[3].temperatureHigh),
                FlSpot(4, widget.weather!.dailyWeather[4].temperatureHigh),
                FlSpot(5, widget.weather!.dailyWeather[5].temperatureHigh),
                FlSpot(6, widget.weather!.dailyWeather[6].temperatureHigh),
                FlSpot(7, widget.weather!.dailyWeather[7].temperatureHigh),
              ],
            ),
            0, // Index of the LineChartBarData
            FlSpot(index.toDouble(),
                widget.weather!.dailyWeather[index].precipProbability),
          ),
        ]);
      }).toList(),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 0.5,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.blueGrey,
            strokeWidth: 0.4,
            dashArray: [8, 4],
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.blueGrey,
            strokeWidth: 0.4,
            dashArray: [8, 4],
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 45,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 7,
      minY: 0,
      maxY: getMaxY(),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, widget.weather!.dailyWeather[0].precipProbability),
            FlSpot(1, widget.weather!.dailyWeather[1].precipProbability),
            FlSpot(2, widget.weather!.dailyWeather[2].precipProbability),
            FlSpot(3, widget.weather!.dailyWeather[3].precipProbability),
            FlSpot(4, widget.weather!.dailyWeather[4].precipProbability),
            FlSpot(5, widget.weather!.dailyWeather[5].precipProbability),
            FlSpot(6, widget.weather!.dailyWeather[6].precipProbability),
            FlSpot(7, widget.weather!.dailyWeather[7].precipProbability),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          shadow: const Shadow(
            blurRadius: 10,
          ),
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        enabled: false,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) =>
              AppColors.contentColorCyan.withOpacity(0.7),
          tooltipRoundedRadius: 100,
          getTooltipItems: (spots) {
            return spots.map((spot) {
              return LineTooltipItem(
                (spot.y * 100).round().toString(),
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  double getMaxY() {
    return (widget.weather!.dailyWeather
            .map((e) => e.precipProbability)
            .reduce((a, b) => a > b ? a : b)) *
        1.5;
  }
}
