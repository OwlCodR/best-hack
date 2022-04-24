import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_api_provider/api_provider.dart';
import 'package:best_hack/feature_main_screen/feature_custom_widgets/custom_widgets.dart';
import 'package:best_hack/feature_responses/response_chart.dart';
import 'package:best_hack/feature_responses/response_stock.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({
    Key? key,
    required this.animate,
    required this.stock,
  }) : super(key: key);

  final bool animate;
  final ResponseStock? stock;

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  List<Color> gradientColors = [
    AppConstants.colors.blue,
    AppConstants.colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.stock == null) {
      return Center(child: customCircularProgressIndicator());
    }

    return FutureBuilder(
      future: ApiProvider.getChart(
        targetCurrency: widget.stock!.targetCurrency,
        sourceCurrency: widget.stock!.sourceCurrency,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var points = (snapshot.data as ResponseChart).points;
          debugPrint('Points: $points');
          return customCard(
            child: LineChart(LineChartData(
              gridData: FlGridData(
                show: false,
                drawVerticalLine: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: AppConstants.colors.gray,
                    strokeWidth: 0.5,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: AppConstants.colors.gray,
                    strokeWidth: 0.5,
                  );
                },
              ),
              titlesData: FlTitlesData(
                show: false,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(
                  show: true,
                  border:
                      Border.all(color: AppConstants.colors.gray, width: 0.5)),
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(
                      points.length,
                      (index) => FlSpot(
                            DateTime.now()
                                .difference(points[index].dateTime)
                                .inMinutes as double,
                            points[index].value,
                          )),
                  isCurved: true,
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  barWidth: 5,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: false,
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: gradientColors
                          .map((color) => color.withOpacity(0.3))
                          .toList(),
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ],
            )),
          );
        } else if (snapshot.hasError) {
          debugPrint('_ChartWidgetState | Error: ${snapshot.error}');
          return Expanded(
            flex: 3,
            child: Center(
              child: Text(
                'Failed to load data.',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          );
        }
        return Center(child: customCircularProgressIndicator());
      },
    );
  }
}
