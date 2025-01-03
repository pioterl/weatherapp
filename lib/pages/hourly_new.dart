// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:weatherapp/model/weather.dart';
//
// import 'app_resources.dart';
//
// class HourlyNew extends StatefulWidget {
//   final Weather? weather;
//
//   HourlyNew({super.key, required this.weather});
//
//   final Color dark = AppColors.contentColorBlue;
//   final Color normal = AppColors.contentColorCyan;
//   // final Color light = AppColors.contentColorCyanBorder;
//
//   @override
//   State<StatefulWidget> createState() => HourlyNewState();
// }
//
// class HourlyNewState extends State<HourlyNew> {
//   Widget bottomTitles(double value, TitleMeta meta) {
//     const style = TextStyle(fontSize: 10);
//     final index = value.toInt();
//     String text = (index >= 0 && index < 32)
//         ? widget.weather!.hourlyWeather[index].temperature.round().toString()
//         : '';
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: Text(text, style: style),
//     );
//   }
//
//   Widget leftTitles(double value, TitleMeta meta) {
//     if (value == meta.max) {
//       return Container();
//     }
//     const style = TextStyle(
//       fontSize: 10,
//     );
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: Text(
//         meta.formattedValue,
//         style: style,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 2,
//       child: Padding(
//         padding: const EdgeInsets.only(top: 16),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             final barsSpace = 4.0 * constraints.maxWidth / 400;
//             final barsWidth = 8.0 * constraints.maxWidth / 400;
//             return BarChart(
//               BarChartData(
//                 alignment: BarChartAlignment.center,
//                 barTouchData: barTouchData,
//                 titlesData: FlTitlesData(
//                   show: true,
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: 28,
//                       getTitlesWidget: bottomTitles,
//                     ),
//                   ),
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: false,
//                       reservedSize: 40,
//                       getTitlesWidget: leftTitles,
//                     ),
//                   ),
//                   topTitles: const AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                   rightTitles: const AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                 ),
//                 gridData: FlGridData(
//                   show: true,
//                   checkToShowHorizontalLine: (value) => value % 0.5 == 0,
//                   getDrawingHorizontalLine: (value) => FlLine(
//                     color: AppColors.borderColor.withOpacity(0.1),
//                     strokeWidth: 1,
//                   ),
//                   drawVerticalLine: false,
//                 ),
//                 borderData: FlBorderData(
//                   show: false,
//                 ),
//                 groupsSpace: barsSpace,
//                 barGroups: getData(barsWidth, barsSpace),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   BarTouchData get barTouchData => BarTouchData(
//         enabled: true,
//         touchTooltipData: BarTouchTooltipData(
//           getTooltipColor: (group) => Colors.transparent,
//           tooltipPadding: EdgeInsets.zero,
//           tooltipMargin: 8,
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
//   List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
//     return List.generate(32, (index) {
//       return BarChartGroupData(
//         x: index,
//         barsSpace: barsSpace,
//         barRods: [
//           BarChartRodData(
//             toY: widget.weather!.hourlyWeather[index].temperature,
//             rodStackItems: [
//               BarChartRodStackItem(
//                 0,
//                 widget.weather!.hourlyWeather[index].temperature,
//                 widget.normal,
//               ),
//             ],
//             borderRadius: BorderRadius.zero,
//             width: barsWidth,
//           ),
//         ],
//       );
//     });
//   }
// }
