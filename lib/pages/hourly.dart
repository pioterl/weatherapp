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
            verticalInterval: 0.125 * 0.1667,
            horizontalInterval: 1),
        alignment: BarChartAlignment.spaceAround,
        maxY: getHighest(),
        minY: getLowest(),
      ),
    );
  }

  double getHighest() {
    return weather?.hourlyWeather
            .map((e) => e.temperature + 0.6)
            .reduce((a, b) => a > b ? a : b) ??
        30;
  }

  double getLowest() {
    return weather?.hourlyWeather
            .map((e) => e.temperature - 0.6)
            .reduce((a, b) => a < b ? a : b) ??
        -10;
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
      color: AppColors.contentColorWhite.withOpacity(0.4),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    final index = value.toInt();
    if (index < 0 || index > 47) return const SizedBox.shrink();

    final hour = getHour(index);
    final icon = getIcon(index);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BoxedIcon(icon, size: 18),
          Text(hour, style: style),
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

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 70,
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
      child: Container(
        width: MediaQuery.of(context).size.width * 3,
        height: 250,
        child: AspectRatio(
          aspectRatio: 1.9,
          child: _BarChart(weather: widget.weather),
        ),
      ),
    );
  }
}
