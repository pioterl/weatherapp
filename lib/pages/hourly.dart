import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../util/icon_service.dart';
import '../model/weather.dart';
import 'app_resources.dart';

class _BarChart extends StatelessWidget {
  final Weather? weather;

  static const double TO_KMH_MULTIPLIER = 3.6;

  const _BarChart({required this.weather});

  @override
  Widget build(BuildContext context) {
    var horizontalInterval = (getMaxY() - getMinY()) / 3.02;
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups, // Access weather here
        gridData: FlGridData(
            show: true,
            verticalInterval: 0.01588,
            horizontalInterval: horizontalInterval),
        alignment: BarChartAlignment.spaceAround,
        maxY: getMaxY(),
        minY: getMinY(),
      ),
    );
  }

  double getMaxY() {
    double maxTemp = weather?.dailyWeather
            .map((e) => e.air_temperature)
            .reduce((a, b) => a > b ? a : b) ??
        30;
    return calculateMaxY(maxTemp);
  }

  double calculateMaxY(double maxTemp) {
    if (maxTemp > 35) {
      return maxTemp * 1.1;
    } else if (maxTemp > 25) {
      return maxTemp * 1.2;
    } else if (maxTemp <= 0) {
      return 0.1;
    }
    return maxTemp * 1.5;
  }

  double getMinY() {
    double lowestTemperature = weather?.dailyWeather
            .map((e) => e.air_temperature)
            .reduce((a, b) => a < b ? a : b) ??
        0;
    return lowestTemperature < 0
        ? calculateMinYBelow0(lowestTemperature)
        : -0.2;
  }

  double calculateMinYBelow0(double lowestTemperature) {
    if (lowestTemperature > -1.5) {
      return lowestTemperature - 2.0;
    } else if (lowestTemperature > -3) {
      return lowestTemperature - 3.0;
    } else if (lowestTemperature > -4) {
      return lowestTemperature - 4.0;
    } else if (lowestTemperature > -15) {
      return lowestTemperature * 1.2;
    } else {
      return lowestTemperature * 1.1;
    }
  }

  // double getLowest() {
  //   return weather?.hourlyWeather
  //           .map((e) => e.temperature - 0.6)
  //           .reduce((a, b) => a < b ? a : b) ??
  //       -10;
  // }

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

  Widget getTopTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.contentColorWhite.withOpacity(0.4),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    final index = value.toInt();
    if (index < 0 || index > 63) {
      return const SizedBox.shrink();
    }

    String dayName = '';
    if (index == 0) {
      dayName = getDayName(index).substring(0, 3);
    }
    int hour = int.parse(getHour(index));
    if (hour == 0 && index != 0) {
      dayName = getDayName(index).substring(0, 3);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (index == 0 || index == 1)
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(dayName,
                  style: style.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                  )),
            )
          else
            Text(dayName,
                style: style.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                )),
        ],
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.contentColorWhite.withOpacity(0.4),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    final index = value.toInt();
    if (index < 0 || index > 63) return const SizedBox.shrink();

    final String hour = getHour(index);
    final String icon = IconService.getIcon(weather!, index);
    final String rain = getRain(index);
    final String wind = getWind(index);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(icon, width: 24, height: 24),
          Text(
            hour,
            style: getTextStyleHour(index),
          ),
          Text(
            rain,
            style: getTextStyleRain(style, index),
          ),
          Text(
            wind,
            style: getTextStyleWind(style, index),
          ),
        ],
      ),
    );
  }

  TextStyle getTextStyleWind(TextStyle style, int index) {
    double kmh = weather!.dailyWeather[index].windSpeed * TO_KMH_MULTIPLIER;
    double fontSize = 11;

    if (kmh > 45) {
      return style.copyWith(
        color: AppColors.contentColorRed,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (kmh > 40) {
      return style.copyWith(
        color: AppColors.contentColorRed.withOpacity(0.8),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (kmh > 35) {
      return style.copyWith(
        color: AppColors.contentColorRed.withOpacity(0.7),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (kmh > 30) {
      return style.copyWith(
        color: AppColors.contentColorRed.withOpacity(0.6),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (kmh > 25) {
      return style.copyWith(
        color: AppColors.contentColorRed.withOpacity(0.5),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (kmh > 20) {
      return style.copyWith(
        color: AppColors.contentColorRed.withOpacity(0.4),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else {
      return style.copyWith(
        color: AppColors.contentColorRed.withOpacity(0.2),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    }
  }

  TextStyle getTextStyleRain(TextStyle style, int index) {
    double amount = weather!.dailyWeather[index].precipitationAmount;

    double fontSize = 11;
    if (amount >= 0.7) {
      return style.copyWith(
        color: AppColors.contentColorCyan,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (amount >= 0.6) {
      return style.copyWith(
        color: AppColors.contentColorCyan.withOpacity(0.8),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (amount >= 0.5) {
      return style.copyWith(
        color: AppColors.contentColorCyan.withOpacity(0.7),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (amount >= 0.4) {
      return style.copyWith(
        color: AppColors.contentColorCyan.withOpacity(0.6),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (amount >= 0.3) {
      return style.copyWith(
        color: AppColors.contentColorCyan.withOpacity(0.5),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (amount >= 0.2) {
      return style.copyWith(
        color: AppColors.contentColorCyan.withOpacity(0.4),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (amount >= 0.1) {
      return style.copyWith(
        color: AppColors.contentColorCyan.withOpacity(0.3),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else {
      return style.copyWith(
        color: AppColors.contentColorCyan.withOpacity(0.2),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    }
  }

  TextStyle getTextStyleHour(int index) {
    int hour = int.parse(getHour(index));
    if (hour >= 7 && hour <= 19) {
      return TextStyle(
        color: Colors.orange.shade300.withOpacity(0.8),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      );
    } else {
      return TextStyle(
        color: AppColors.contentColorWhite.withOpacity(0.4),
        fontWeight: FontWeight.bold,
      );
    }
  }

  String getHour(int i) {
    return DateTime.fromMillisecondsSinceEpoch(
            weather!.dailyWeather[i].time * 1000,
            isUtc: true)
        .add(Duration(hours: 1))
        .hour
        .toString();
  }

  String getDayName(int i) {
    if (i < 0 || i >= weather!.dailyWeather.length) {
      return '';
    }
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

    return weekdayName;
  }

  String getWind(int i) {
    return ((weather!.dailyWeather[i].windSpeed) * TO_KMH_MULTIPLIER)
        .round()
        .toString();
  }

  String getRain(int i) {
    return (weather!.dailyWeather[i].precipitationAmount).toString();
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 82,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            getTitlesWidget: getTopTitles,
          ),
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

  List<BarChartGroupData> get barGroups => List.generate(
        63,
        (index) => BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: weather!.dailyWeather[index].air_temperature,
              gradient: _barsGradient,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      );
}

class HourlyChart extends StatefulWidget {
  final Weather? weather;

  const HourlyChart({super.key, required this.weather});

  @override
  State<StatefulWidget> createState() => HourlyChartState();
}

class HourlyChartState extends State<HourlyChart> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 4,
        height: 230,
        child: Padding(
          padding: const EdgeInsets.only(left: 13),
          child: AspectRatio(
            aspectRatio: 1.9,
            child: _BarChart(weather: widget.weather),
          ),
        ),
      ),
    );
  }
}
