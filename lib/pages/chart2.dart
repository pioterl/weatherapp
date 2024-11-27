import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/weather.dart';
import 'app_resources.dart';

class LineChartSample5 extends StatefulWidget {
  final Weather? weather;

  const LineChartSample5({
    required this.weather,
    super.key,
    Color? gradientColor1,
    Color? gradientColor2,
    Color? gradientColor3,
    Color? indicatorStrokeColor,
  })  : gradientColor1 = gradientColor1 ?? AppColors.contentColorRed,
        gradientColor2 = gradientColor2 ?? AppColors.contentColorPink,
        gradientColor3 = gradientColor3 ?? AppColors.contentColorBlue,
        indicatorStrokeColor = indicatorStrokeColor ?? AppColors.mainTextColor1;

  final Color gradientColor1;
  final Color gradientColor2;
  final Color gradientColor3;
  final Color indicatorStrokeColor;

  @override
  State<LineChartSample5> createState() => _LineChartSample5State();
}

class _LineChartSample5State extends State<LineChartSample5> {
  List<int> showingTooltipOnSpots = [0, 1, 2, 3, 4, 5, 6, 7];

  List<FlSpot> get allSpots => [
        FlSpot(0, widget.weather!.dailyWeather[0].windSpeed),
        FlSpot(1, widget.weather!.dailyWeather[1].windSpeed),
        FlSpot(2, widget.weather!.dailyWeather[2].windSpeed),
        FlSpot(3, widget.weather!.dailyWeather[3].windSpeed),
        FlSpot(4, widget.weather!.dailyWeather[4].windSpeed),
        FlSpot(5, widget.weather!.dailyWeather[5].windSpeed),
        FlSpot(6, widget.weather!.dailyWeather[6].windSpeed),
        FlSpot(7, widget.weather!.dailyWeather[7].windSpeed),
      ];

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.contentColorWhite.withOpacity(0.7),
      fontFamily: 'Digital',
      fontSize: 18 * chartWidth / 500,
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
          Text(dayName, style: style.copyWith(fontSize: 10)), // Secondary text
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

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: allSpots,
        isCurved: true,
        barWidth: 5,
        shadow: const Shadow(
          blurRadius: 10,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              widget.gradientColor1.withOpacity(0.4),
              widget.gradientColor2.withOpacity(0.4),
              widget.gradientColor3.withOpacity(0.4),
            ],
          ),
        ),
        dotData: const FlDotData(show: true),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            widget.gradientColor1,
            widget.gradientColor2,
            widget.gradientColor3,
          ],
          stops: const [0.1, 0.4, 0.9],
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return AspectRatio(
      aspectRatio: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 27.0,
          vertical: 10,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return LineChart(
            LineChartData(
              showingTooltipIndicators: showingTooltipOnSpots.map((index) {
                return ShowingTooltipIndicators([
                  LineBarSpot(
                    tooltipsOnBar,
                    lineBarsData.indexOf(tooltipsOnBar),
                    tooltipsOnBar.spots[index],
                  ),
                ]);
              }).toList(),
              lineTouchData: LineTouchData(
                enabled: true,
                handleBuiltInTouches: false,
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? response) {
                  if (response == null || response.lineBarSpots == null) {
                    return;
                  }
                  if (event is FlTapUpEvent) {
                    final spotIndex = response.lineBarSpots!.first.spotIndex;
                    setState(() {
                      if (showingTooltipOnSpots.contains(spotIndex)) {
                        showingTooltipOnSpots.remove(spotIndex);
                      } else {
                        showingTooltipOnSpots.add(spotIndex);
                      }
                    });
                  }
                },
                mouseCursorResolver:
                    (FlTouchEvent event, LineTouchResponse? response) {
                  if (response == null || response.lineBarSpots == null) {
                    return SystemMouseCursors.basic;
                  }
                  return SystemMouseCursors.click;
                },
                getTouchedSpotIndicator:
                    (LineChartBarData barData, List<int> spotIndexes) {
                  return spotIndexes.map((index) {
                    return TouchedSpotIndicatorData(
                      const FlLine(
                        color: Colors.white10,
                      ),
                      FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                          radius: 8,
                          color: lerpGradient(
                            barData.gradient!.colors,
                            barData.gradient!.stops!,
                            percent / 100,
                          ),
                          strokeWidth: 2,
                          strokeColor: widget.indicatorStrokeColor,
                        ),
                      ),
                    );
                  }).toList();
                },
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (touchedSpot) => Colors.pink,
                  tooltipRoundedRadius: 100,
                  getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                    return lineBarsSpot.map((lineBarSpot) {
                      return LineTooltipItem(
                        lineBarSpot.y.round().toString(),
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              lineBarsData: lineBarsData,
              minY: 0,
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                  axisNameWidget: Text('count'),
                  axisNameSize: 0,
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 0,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      return bottomTitleWidgets(
                        value,
                        meta,
                        constraints.maxWidth,
                      );
                    },
                    reservedSize: 40,
                  ),
                ),
                rightTitles: const AxisTitles(
                  axisNameWidget: Text('count'),
                  axisNameSize: 0,
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 0,
                  ),
                ),
                topTitles: const AxisTitles(
                  axisNameWidget: Text(
                    'Wall clock',
                    textAlign: TextAlign.left,
                  ),
                  axisNameSize: 0,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 0,
                  ),
                ),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(
                show: false,
                border: Border.all(
                  color: AppColors.borderColor,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Lerps between a [LinearGradient] colors, based on [t]
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty) {
    throw ArgumentError('"colors" is empty.');
  } else if (colors.length == 1) {
    return colors[0];
  }

  if (stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / (colors.length - 1);
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s];
    final rightStop = stops[s + 1];
    final leftColor = colors[s];
    final rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}
