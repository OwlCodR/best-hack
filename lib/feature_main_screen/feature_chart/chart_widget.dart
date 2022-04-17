import 'dart:developer';

import 'package:best_hack/feature_main_screen/feature_api_provider/api_provider.dart';
import 'package:best_hack/feature_main_screen/feature_custom_widgets/custom_widgets.dart';
import 'package:best_hack/feature_main_screen/feature_responses/reposne_stock.dart';
import 'package:best_hack/feature_main_screen/feature_responses/response_chart.dart';
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
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.stock == null) {
      return customCircularProgressIndicator();
    }

    return FutureBuilder(
      future: ApiProvider.getChart(widget.stock!.tag),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var points = (snapshot.data as ResponseChart).points;
          log('$points');
          // return charts.LineChart(
          //   [
          //     charts.Series<Point, int>(
          //       seriesColor: charts.ColorUtil.fromDartColor(Colors.green),
          //       colorFn: (Point, int) => Constants.colorPurple,
          //       id: 'NAME',
          //       domainFn: (Point point, _) => point.dateTime.day,
          //       measureFn: (Point point, _) => point.value,
          //       data: points,
          //     )
          //   ],
          //   animate: widget.animate,
          // );
          // List<Map<String, dynamic>> dots = [];
          // List<Map<String, dynamic>> data = [];
          // for (var point in points) {
          //   Map<String, dynamic> buff = {
          //     'domain': point.dateTime.millisecondsSinceEpoch,
          //     'measure': point.value,
          //   };
          //   data.add(buff);
          // }
          // dots.add({'id': 'Line'});
          // dots.add({'data': data});
          // log('DOTS $dots');
          // return DChartLine(
          //   data: dots,
          //   lineColor: (lineData, index, id) => Constants.colorGreen,
          // );
          return LineChart(LineChartData(
            titlesData: FlTitlesData(
              show: false,
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                  reservedSize: 30,
                  interval: 1,
                ),
              ),
            ),
            minX: 0,
            maxX: 7,
            minY: points[0].value / 1.5,
            maxY: points[0].value * 1.5,
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                    points.length,
                    (i) => FlSpot(i as double,
                        double.parse(points[i].value.toStringAsFixed(2)))),
                isCurved: true,
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                barWidth: 1,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: false,
                ),
              ),
            ],
          ));
        } else if (snapshot.hasError) {
          log('_ChartWidgetState | Error: ${snapshot.error}');
          return Text(
            'Failed to load data.',
            style: Theme.of(context).textTheme.labelLarge,
          );
        }

        return customCircularProgressIndicator();
      },
    );
  }
}
