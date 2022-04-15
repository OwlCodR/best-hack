class ResponseChart {
  ResponseChart({required this.points});
  List<Point> points;

  factory ResponseChart.fromJson(Map<String, dynamic> json) {
    List<Point> _points = [];
    for (var point in json['points']) {
      _points.add(Point.fromJson(point));
    }
    return ResponseChart(points: _points);
  }
}

class Point {
  Point({
    required this.value,
    required this.dateTime,
  });

  double value;
  DateTime dateTime;

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      value: json['value'],
      dateTime: DateTime.parse(json['timestamp']),
    );
  }
}
