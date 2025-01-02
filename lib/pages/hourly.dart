import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

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
            show: true,
            verticalInterval: 0.02082,
            horizontalInterval: getMaxY() / 2),
        alignment: BarChartAlignment.spaceAround,
        maxY: getMaxY(),
        minY: getMinY(),
      ),
    );
  }

  double getMaxY() {
    return weather?.hourlyWeather
            .map((e) => e.temperature * 1.8)
            .reduce((a, b) => a > b ? a : b) ??
        30;
  }

  double getMinY() {
    double lowestTemperature = weather?.hourlyWeather
            .map((e) => e.temperature)
            .reduce((a, b) => a < b ? a : b) ??
        0;
    return lowestTemperature < 0 ? calculateMinYBelow0(lowestTemperature) : 0;
  }

  double calculateMinYBelow0(double lowestTemperature) {
    if (lowestTemperature > -1.5) {
      return lowestTemperature - 2.0;
    } else if (lowestTemperature > -3) {
      return lowestTemperature - 3.0;
    } else if (lowestTemperature > -4) {
      return lowestTemperature - 4.0;
    } else {
      return lowestTemperature * 1.6;
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
    if (index < 0 || index > 47) {
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
    if (index < 0 || index > 47) return const SizedBox.shrink();

    final String hour = getHour(index);
    final IconData icon = getIcon(index);
    final String rain = getRain(index);
    final String wind = getWind(index);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BoxedIcon(icon, size: 17),
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
    double probability = weather!.hourlyWeather[index].windSpeed;

    double fontSize = 11;
    if (probability > 45) {
      return style.copyWith(
        color: AppColors.contentColorRed,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (probability > 40) {
      return style.copyWith(
        color: AppColors.contentColorRed.withOpacity(0.8),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (probability > 35) {
      return style.copyWith(
        color: AppColors.contentColorRed.withOpacity(0.7),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (probability > 30) {
      return style.copyWith(
        color: AppColors.contentColorRed.withOpacity(0.6),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (probability > 20) {
      return style.copyWith(
        color: AppColors.contentColorRed.withOpacity(0.5),
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
    double probability = weather!.hourlyWeather[index].precipProbability * 100;

    double fontSize = 11;
    if (probability > 90) {
      return style.copyWith(
        color: AppColors.contentColorCyan,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (probability > 80) {
      return style.copyWith(
        color: AppColors.contentColorCyan.withOpacity(0.8),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (probability > 70) {
      return style.copyWith(
        color: AppColors.contentColorCyan.withOpacity(0.7),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (probability > 60) {
      return style.copyWith(
        color: AppColors.contentColorCyan.withOpacity(0.6),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (probability > 50) {
      return style.copyWith(
        color: AppColors.contentColorCyan.withOpacity(0.5),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (probability > 40) {
      return style.copyWith(
        color: AppColors.contentColorCyan.withOpacity(0.4),
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    } else if (probability > 30) {
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

  IconData getIcon(int i) {
    switch (weather!.hourlyWeather[i].icon) {
      case 'clear-day':
        return WeatherIcons.day_sunny;
      case 'clear-night':
        return WeatherIcons.night_clear;
      case 'rain':
        return WeatherIcons.rain;
      case 'snow':
        return WeatherIcons.snow;
      case 'sleet':
        return WeatherIcons.sleet;
      case 'wind':
        return WeatherIcons.strong_wind;
      case 'fog':
        return WeatherIcons.fog;
      case 'cloudy':
        return WeatherIcons.cloudy;
      case 'partly-cloudy-day':
        return WeatherIcons.day_cloudy;
      case 'partly-cloudy-night':
        return WeatherIcons.night_alt_cloudy;
      default:
        return WeatherIcons.na;
    }
  }

  String getHour(int i) {
    return DateTime.fromMillisecondsSinceEpoch(
            weather!.hourlyWeather[i].time * 1000,
            isUtc: true)
        .add(Duration(hours: 1))
        .hour
        .toString();
  }

  String getDayName(int i) {
    if (i < 0 || i >= weather!.hourlyWeather.length) {
      return '';
    }
    int weekday = DateTime.fromMillisecondsSinceEpoch(
      weather!.hourlyWeather[i].time * 1000,
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
    return (weather!.hourlyWeather[i].windSpeed).round().toString();
  }

  String getRain(int i) {
    return (weather!.hourlyWeather[i].precipProbability * 100)
        .round()
        .toString();
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
        48,
        (index) => BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: weather!.hourlyWeather[index].temperature,
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
        width: MediaQuery.of(context).size.width * 3.03,
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
