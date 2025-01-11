import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import '../model/weather.dart';
import '../util/commons.dart';
import '../util/icon_service.dart';
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
            show: true, verticalInterval: 0.125, horizontalInterval: 100),
        alignment: BarChartAlignment.spaceAround,
        maxY: getMaxY(),
        minY: getMinY(),
      ),
    );
  }

  double getMaxY() {
    double maxTemp = weather?.timeseries
            .take(82)
            .map((e) => e.air_temperature)
            .reduce((a, b) => a > b ? a : b) ??
        30;
    return calculateMaxY(maxTemp);
  }

  double calculateMaxY(double maxTemp) {
    if (maxTemp > 35) {
      return maxTemp * 1.1;
    } else if (maxTemp > 25) {
      return maxTemp * 1.25;
    } else if (maxTemp > 0) {
      return maxTemp + 2.0;
    } else if (maxTemp <= 0) {
      return 0.1;
    }
    return maxTemp * 1.5;
  }

  double getMinY() {
    Map<int, double> temperatures = {};
    for (int i = 0; i <= 7; i++) {
      temperatures[i] = getMaxTemperatureForDay(i);
    }

    double lowestTemperature =
        temperatures.values.reduce((a, b) => a < b ? a : b);

    return lowestTemperature < 0
        ? calculateMinYBelow0(lowestTemperature)
        : -0.2;
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.only(top: 8),
          tooltipMargin: 2,
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
      color: AppColors.contentColorWhite.withOpacity(0.4),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    int dayNum;
    String dayName;
    String icon = "";

    var index = value.toInt();

    switch (index) {
      case 0:
        dayNum = getDayNumber(0);
        dayName = getDayName(0);
        icon = getIcon(0);
        break;
      case 1:
        dayNum = getDayNumber(1);
        dayName = getDayName(1);
        icon = getIcon(1);
        break;
      case 2:
        dayNum = getDayNumber(2);
        dayName = getDayName(2);
        icon = getIcon(2);
        break;
      case 3:
        dayNum = getDayNumber(3);
        dayName = getDayName(3);
        icon = getIcon(3);
        break;
      case 4:
        dayNum = getDayNumber(4);
        dayName = getDayName(4);
        icon = getIcon(4);
        break;
      case 5:
        dayNum = getDayNumber(5);
        dayName = getDayName(5);
        icon = getIcon(5);
        break;
      case 6:
        dayNum = getDayNumber(6);
        dayName = getDayName(6);
        icon = getIcon(6);
        break;
      case 7:
        dayNum = getDayNumber(7);
        dayName = getDayName(7);
        icon = getIcon(7);
        break;
      default:
        dayNum = 00;
        dayName = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(IconService.getIconDaily(icon), width: 35, height: 35),
          Text(dayNum.toString(), style: style),
          Text(
            dayName,
            style: style.copyWith(fontSize: 12, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
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

  int getDayNumber(int i) {
    DateTime actual = DateTime.now();
    return DateTime(actual.year, actual.month, actual.day + i).day;
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 77,
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

  LinearGradient get _barsGradientMax => LinearGradient(
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
              toY: getMaxTemperatureForDay(0),
              gradient: _barsGradientMax,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: getMaxTemperatureForDay(1),
              gradient: _barsGradientMax,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: getMaxTemperatureForDay(2),
              gradient: _barsGradientMax,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: getMaxTemperatureForDay(3),
              gradient: _barsGradientMax,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: getMaxTemperatureForDay(4),
              gradient: _barsGradientMax,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: getMaxTemperatureForDay(5),
              gradient: _barsGradientMax,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: getMaxTemperatureForDay(6),
              gradient: _barsGradientMax,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              toY: getMaxTemperatureForDay(7),
              gradient: _barsGradientMax,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];

  String getIcon(int dayNum) {
    if (dayNum == 0) {
      return weather!.timeseries.elementAt(0).icon_12h;
    }
    DateTime actualDay = DateTime.now();
    DateTime calculatedDay =
        DateTime(actualDay.year, actualDay.month, actualDay.day + dayNum);

    List<String> icons = weather!.timeseries
        .where((e) =>
            e.time.year == calculatedDay.year &&
            e.time.month == calculatedDay.month &&
            e.time.day == calculatedDay.day &&
            e.time.hour == 1)
        .map((e) => e.icon_12h)
        .toList();

    if (icons.isEmpty) {
      return "assets/weather_symbols/na.png";
    }

    return icons.first;
  }

  double getMaxTemperatureForDay(int dayNum) {
    DateTime actualDay = DateTime.now();
    DateTime calculatedDay =
        DateTime(actualDay.year, actualDay.month, actualDay.day + dayNum);

    List<double> dayTemperatures = weather!.timeseries
        .where((e) =>
            e.time.year == calculatedDay.year &&
            e.time.month == calculatedDay.month &&
            e.time.day == calculatedDay.day)
        .map((e) => e.air_temperature)
        .toList();

    if (dayTemperatures.isEmpty) {
      return 0.0;
    }

    return dayTemperatures.reduce((a, b) => a > b ? a : b);
  }

  double getMinTemperatureForDay(int dayNum) {
    DateTime actual = DateTime.now();
    DateTime nextDay = DateTime(actual.year, actual.month, actual.day + dayNum);

    List<double> nextDayTemperatures = weather!.timeseries
        .where((e) =>
            e.time.year == nextDay.year &&
            e.time.month == nextDay.month &&
            e.time.day == nextDay.day)
        .map((e) => e.air_temperature)
        .toList();

    if (nextDayTemperatures.isEmpty) {
      return 0.0;
    }

    return nextDayTemperatures.reduce((a, b) => a < b ? a : b);
  }
}

class DailyChart extends StatefulWidget {
  final Weather? weather;

  const DailyChart({super.key, required this.weather});

  @override
  State<StatefulWidget> createState() => DailyChartState();
}

class DailyChartState extends State<DailyChart> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: _BarChart(weather: widget.weather),
    );
  }
}
