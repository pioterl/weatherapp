// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:weather_icons/weather_icons.dart';
//
// import '../model/weather.dart';
// import 'app_resources.dart';
//
// class _BarChart extends StatelessWidget {
//   final Weather? weather;
//
//   const _BarChart({required this.weather});
//
//   @override
//   Widget build(BuildContext context) {
//     return BarChart(
//       BarChartData(
//         barTouchData: barTouchData,
//         titlesData: titlesData,
//         borderData: borderData,
//         barGroups: barGroups, // Access weather here
//         gridData: FlGridData(
//             show: true,
//             verticalInterval: 0.125,
//             horizontalInterval: getMaxY() / 2.999),
//         alignment: BarChartAlignment.spaceAround,
//         maxY: getMaxY(),
//         minY: getMinY(),
//       ),
//     );
//   }
//
//   double getMaxY() {
//     return weather?.dailyWeather
//             .map((e) => e.air_temperature * 1.25)
//             .reduce((a, b) => a > b ? a : b) ??
//         30;
//   }
//
//   double getMinY() {
//     double lowestTemperature = weather?.dailyWeather
//             .map((e) => e.air_temperature)
//             .reduce((a, b) => a < b ? a : b) ??
//         0;
//     return lowestTemperature < 0 ? calculateMinYBelow0(lowestTemperature) : 0;
//   }
//
//   double calculateMinYBelow0(double lowestTemperature) {
//     if (lowestTemperature > -3) {
//       return lowestTemperature - 3.0;
//     } else {
//       return lowestTemperature * 1.4;
//     }
//   }
//
//   BarTouchData get barTouchData => BarTouchData(
//         enabled: false,
//         touchTooltipData: BarTouchTooltipData(
//           getTooltipColor: (group) => Colors.transparent,
//           tooltipPadding: EdgeInsets.only(top: 8),
//           tooltipMargin: 2,
//           getTooltipItem: (
//             BarChartGroupData group,
//             int groupIndex,
//             BarChartRodData rod,
//             int rodIndex,
//           ) {
//             return BarTooltipItem(
//               rod.toY.round().toString(),
//               const TextStyle(
//                 color: AppColors.contentColorCyan,
//                 fontWeight: FontWeight.bold,
//               ),
//             );
//           },
//         ),
//       );
//
//   Widget getTitles(double value, TitleMeta meta) {
//     final style = TextStyle(
//       color: AppColors.contentColorWhite.withOpacity(0.4),
//       fontWeight: FontWeight.bold,
//       fontSize: 14,
//     );
//     String dayNum;
//     String dayName;
//     IconData? icon;
//     switch (value.toInt()) {
//       case 0:
//         dayNum = getDayNumber(0);
//         dayName = getDayName(0);
//         icon = getIcon(0);
//         break;
//       case 1:
//         dayNum = getDayNumber(1);
//         dayName = getDayName(1);
//         icon = getIcon(1);
//         break;
//       case 2:
//         dayNum = getDayNumber(2);
//         dayName = getDayName(2);
//         icon = getIcon(2);
//         break;
//       case 3:
//         dayNum = getDayNumber(3);
//         dayName = getDayName(3);
//         icon = getIcon(3);
//         break;
//       case 4:
//         dayNum = getDayNumber(4);
//         dayName = getDayName(4);
//         icon = getIcon(4);
//         break;
//       case 5:
//         dayNum = getDayNumber(5);
//         dayName = getDayName(5);
//         icon = getIcon(5);
//         break;
//       case 6:
//         dayNum = getDayNumber(6);
//         dayName = getDayName(6);
//         icon = getIcon(6);
//         break;
//       case 7:
//         dayNum = getDayNumber(7);
//         dayName = getDayName(7);
//         icon = getIcon(7);
//         break;
//       default:
//         dayNum = '';
//         dayName = '';
//         break;
//     }
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 4,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           BoxedIcon(icon!, size: 22),
//           Text(dayNum, style: style),
//           Text(
//             dayName,
//             style: style.copyWith(fontSize: 11, fontWeight: FontWeight.normal),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String getDayName(int i) {
//     int weekday = DateTime.fromMillisecondsSinceEpoch(
//       weather!.dailyWeather[i].time * 1000,
//       isUtc: true,
//     ).add(Duration(hours: 1)).weekday;
//
//     String weekdayName = [
//       'Monday',
//       'Tuesday',
//       'Wednesday',
//       'Thursday',
//       'Friday',
//       'Saturday',
//       'Sunday'
//     ][weekday - 1];
//
//     return weekdayName.substring(0, 3);
//   }
//
//   IconData getIcon(int i) {
//     switch (weather!.dailyWeather[i].icon) {
//       case 'clear-day':
//         return WeatherIcons.day_sunny;
//       case 'clear-night':
//         return WeatherIcons.night_clear;
//       case 'rain':
//         return WeatherIcons.rain;
//       case 'snow':
//         return WeatherIcons.snow;
//       case 'sleet':
//         return WeatherIcons.sleet;
//       case 'wind':
//         return WeatherIcons.strong_wind;
//       case 'fog':
//         return WeatherIcons.fog;
//       case 'cloudy':
//         return WeatherIcons.cloudy;
//       case 'partly-cloudy-day':
//         return WeatherIcons.day_cloudy;
//       case 'partly-cloudy-night':
//         return WeatherIcons.night_alt_cloudy;
//       default:
//         return WeatherIcons.na;
//     }
//   }
//
//   String getDayNumber(int i) {
//     return DateTime.fromMillisecondsSinceEpoch(
//             weather!.dailyWeather[i].time * 1000,
//             isUtc: true)
//         .add(Duration(hours: 1))
//         .day
//         .toString();
//   }
//
//   FlTitlesData get titlesData => FlTitlesData(
//         show: true,
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 72,
//             getTitlesWidget: getTitles,
//           ),
//         ),
//         leftTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         rightTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//       );
//
//   FlBorderData get borderData => FlBorderData(
//         show: false,
//       );
//
//   LinearGradient get _barsGradient => LinearGradient(
//         colors: [
//           AppColors.contentColorBlue,
//           AppColors.contentColorCyan,
//         ],
//         begin: Alignment.bottomCenter,
//         end: Alignment.topCenter,
//       );
//
//   List<BarChartGroupData> get barGroups => [
//         BarChartGroupData(
//           x: 0,
//           barRods: [
//             BarChartRodData(
//               toY: weather!.dailyWeather[0].air_temperature,
//               gradient: _barsGradient,
//             )
//           ],
//           showingTooltipIndicators: [0],
//         ),
//         BarChartGroupData(
//           x: 1,
//           barRods: [
//             BarChartRodData(
//               toY: weather!.dailyWeather[1].air_temperature,
//               gradient: _barsGradient,
//             )
//           ],
//           showingTooltipIndicators: [0],
//         ),
//         BarChartGroupData(
//           x: 2,
//           barRods: [
//             BarChartRodData(
//               toY: weather!.dailyWeather[2].air_temperature,
//               gradient: _barsGradient,
//             )
//           ],
//           showingTooltipIndicators: [0],
//         ),
//         BarChartGroupData(
//           x: 3,
//           barRods: [
//             BarChartRodData(
//               toY: weather!.dailyWeather[3].air_temperature,
//               gradient: _barsGradient,
//             )
//           ],
//           showingTooltipIndicators: [0],
//         ),
//         BarChartGroupData(
//           x: 4,
//           barRods: [
//             BarChartRodData(
//               toY: weather!.dailyWeather[4].air_temperature,
//               gradient: _barsGradient,
//             )
//           ],
//           showingTooltipIndicators: [0],
//         ),
//         BarChartGroupData(
//           x: 5,
//           barRods: [
//             BarChartRodData(
//               toY: weather!.dailyWeather[5].air_temperature,
//               gradient: _barsGradient,
//             )
//           ],
//           showingTooltipIndicators: [0],
//         ),
//         BarChartGroupData(
//           x: 6,
//           barRods: [
//             BarChartRodData(
//               toY: weather!.dailyWeather[6].air_temperature,
//               gradient: _barsGradient,
//             )
//           ],
//           showingTooltipIndicators: [0],
//         ),
//         BarChartGroupData(
//           x: 7,
//           barRods: [
//             BarChartRodData(
//               toY: weather!.dailyWeather[7].air_temperature,
//               gradient: _barsGradient,
//             )
//           ],
//           showingTooltipIndicators: [0],
//         ),
//       ];
// }
//
// class DailyChart extends StatefulWidget {
//   final Weather? weather;
//
//   const DailyChart({super.key, required this.weather});
//
//   @override
//   State<StatefulWidget> createState() => DailyChartState();
// }
//
// class DailyChartState extends State<DailyChart> {
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 2,
//       child: _BarChart(weather: widget.weather),
//     );
//   }
// }
