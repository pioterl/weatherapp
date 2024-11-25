import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/weather.dart';
import 'app_resources.dart';

class LineChartSample2 extends StatefulWidget {
  final Weather? weather;

  const LineChartSample2({super.key, required this.weather});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 30,
              left: 30,
              top: 30,
              bottom: 12,
            ),
            child: LineChart(mainData()),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    DateTime dateTimeNow = DateTime.now();
    String now2 = DateFormat('EEEE')
        .format(dateTimeNow.add(Duration(hours: 24)))
        .substring(0, 3);
    String now4 = DateFormat('EEEE')
        .format(dateTimeNow.add(Duration(hours: 64)))
        .substring(0, 3);
    String now6 = DateFormat('EEEE')
        .format(dateTimeNow.add(Duration(hours: 120)))
        .substring(0, 3);
    String now8 = DateFormat('EEEE')
        .format(dateTimeNow.add(Duration(hours: 168)))
        .substring(0, 3);

    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('NOW', style: style);
        break;
      case 1:
        text = Text(now2, style: style);
        break;
      case 2:
        text = Text(now2, style: style);
        break;
      case 3:
        text = Text(now2, style: style);
        break;
      case 4:
        text = Text(now4, style: style);
        break;
      case 5:
        text = Text(now2, style: style);
        break;
      case 6:
        text = Text(now6, style: style);
        break;
      case 7:
        text = Text(now2, style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
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
    final weather = widget.weather;

    List<int> showingTooltipOnSpots = [0, 1, 2, 3, 4, 5, 6, 7];

    return LineChartData(
      showingTooltipIndicators: showingTooltipOnSpots.map((index) {
        return ShowingTooltipIndicators([
          LineBarSpot(
            LineChartBarData(
              spots: [
                FlSpot(0, weather!.dailyWeather[0].temperatureHigh),
                FlSpot(1, weather!.dailyWeather[1].temperatureHigh),
                FlSpot(2, weather!.dailyWeather[2].temperatureHigh),
                FlSpot(3, weather!.dailyWeather[3].temperatureHigh),
                FlSpot(4, weather!.dailyWeather[4].temperatureHigh),
                FlSpot(5, weather!.dailyWeather[5].temperatureHigh),
                FlSpot(6, weather!.dailyWeather[6].temperatureHigh),
                FlSpot(7, weather!.dailyWeather[7].temperatureHigh),
              ],
            ),
            0, // Index of the LineChartBarData
            FlSpot(
                index.toDouble(), weather!.dailyWeather[index].precipIntensity),
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
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
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
            reservedSize: 30,
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
      maxY: 1,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, weather!.dailyWeather[0].precipIntensity),
            FlSpot(1, weather!.dailyWeather[1].precipIntensity),
            FlSpot(2, weather!.dailyWeather[2].precipIntensity),
            FlSpot(3, weather!.dailyWeather[3].precipIntensity),
            FlSpot(4, weather!.dailyWeather[4].precipIntensity),
            FlSpot(5, weather!.dailyWeather[5].precipIntensity),
            FlSpot(6, weather!.dailyWeather[6].precipIntensity),
            FlSpot(7, weather!.dailyWeather[7].precipIntensity),
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
}
