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
              top: 25,
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
    int dayNum;
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
        dayNum = 00;
        dayName = '';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Ensure the column does not take extra space
        children: [
          Text(dayNum.toString(), style: style), // Main text
          Text(
            dayName,
            style: style.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: (dayName == 'Sat' || dayName == 'Sun')
                  ? Colors.orange.shade300.withOpacity(0.8)
                  : style.color,
            ),
          ),
        ],
      ),
    );
  }

  int getDayNumber(int i) {
    DateTime actual = DateTime.now();
    return DateTime(actual.year, actual.month, actual.day + i).day;
  }

  String getDayName(int index) {
    DateTime actual = DateTime.now();
    DateTime targetDay =
        DateTime(actual.year, actual.month, actual.day + index);
    return [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat'
    ][targetDay.weekday % 7];
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
                FlSpot(0, getMaxPrecipAmountForDay(index)),
                FlSpot(1, getMaxPrecipAmountForDay(index)),
                FlSpot(2, getMaxPrecipAmountForDay(index)),
                FlSpot(3, getMaxPrecipAmountForDay(index)),
                FlSpot(4, getMaxPrecipAmountForDay(index)),
                FlSpot(5, getMaxPrecipAmountForDay(index)),
                FlSpot(6, getMaxPrecipAmountForDay(index)),
                FlSpot(7, getMaxPrecipAmountForDay(index)),
              ],
            ),
            0, // Index of the LineChartBarData
            FlSpot(index.toDouble(), getMaxPrecipAmountForDay(index)),
          ),
        ]);
      }).toList(),
      gridData: FlGridData(
        show: false,
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
            reservedSize: 48,
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
            FlSpot(0, getMaxPrecipAmountForDay(0)),
            FlSpot(1, getMaxPrecipAmountForDay(1)),
            FlSpot(2, getMaxPrecipAmountForDay(2)),
            FlSpot(3, getMaxPrecipAmountForDay(3)),
            FlSpot(4, getMaxPrecipAmountForDay(4)),
            FlSpot(5, getMaxPrecipAmountForDay(5)),
            FlSpot(6, getMaxPrecipAmountForDay(6)),
            FlSpot(7, getMaxPrecipAmountForDay(7)),
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
          tooltipPadding: EdgeInsets.all(6),
          getTooltipItems: (spots) {
            return spots.map((spot) {
              var maxPrecipAmountForDay =
                  getMaxPrecipAmountForDay(spot.spotIndex);
              return LineTooltipItem(
                maxPrecipAmountForDay.toStringAsFixed(1),
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

  double getMaxPrecipAmountForDay(int dayNum) {
    DateTime actualDay = DateTime.now();
    DateTime calculatedDay =
        DateTime(actualDay.year, actualDay.month, actualDay.day + dayNum);

    List<double> precipAmount = widget.weather!.timeseries
        .where((e) =>
            e.time.year == calculatedDay.year &&
            e.time.month == calculatedDay.month &&
            e.time.day == calculatedDay.day &&
            (e.time.hour == 1 ||
                e.time.hour == 6 ||
                e.time.hour == 13 ||
                e.time.hour == 19))
        .map((e) => e.precipitationAmount6h)
        .toList();

    if (precipAmount.isEmpty) {
      return 0.0;
    }

    double precipAmountSum = precipAmount.reduce((a, b) => a + b);

    return precipAmountSum;
  }

  double getMaxY() {
    Map<int, double> precipAmounts = {};
    for (int i = 0; i <= 7; i++) {
      precipAmounts[i] = getMaxPrecipAmountForDay(i);
    }

    double maxPrecipAmount =
        precipAmounts.values.reduce((a, b) => a > b ? a : b);

    return maxPrecipAmount * 1.5;
    // return (widget.weather!.timeseries
    //         .take(82)
    //         .map((e) => e.precipitationAmount1h)
    //         .reduce((a, b) => a > b ? a : b)) *
    //     1.5;
  }
}
