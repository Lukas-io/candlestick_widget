import 'package:candlestick_widget/candlestick_model.dart';
import 'package:flutter/material.dart';

class CandleStickPainter extends CustomPainter {
  final List<StockData> stockPriceHistory;

  CandleStickPainter(this.stockPriceHistory);

  @override
  void paint(Canvas canvas, Size size) {
    List<DateTime> dates = [];
    List<double> open = [];
    List<double> close = [];
    List<double> high = [];
    List<double> low = [];
    List<Offset> chartAxis = [];

    Color riseColor = Colors.green;
    Color fallColor = Colors.red;
    Color noChangeColor = Colors.grey;

    for (var data in stockPriceHistory) {
      dates.add(data.dateTime);
      open.add(data.open);
      close.add(data.close);
      high.add(data.high);
      low.add(data.low);
    }

    DateTime minDate = dates
        .reduce((value, element) => value.isBefore(element) ? value : element);
    DateTime maxDate = dates
        .reduce((value, element) => value.isAfter(element) ? value : element);

    // Calculate the minimum and maximum y-axis values
    double minValue = open.reduce((a, b) => a < b ? a : b);
    double maxValue = open.reduce((a, b) => a > b ? a : b);
    if (minValue == maxValue) {
      minValue /= 2;
      maxValue *= 1.5;
    }

    // Create a path for the line chart
    Path chartPath = Path();

    // Move to the first data point
    double x = ((dates.first.millisecondsSinceEpoch -
                minDate.millisecondsSinceEpoch) /
            (maxDate.millisecondsSinceEpoch - minDate.millisecondsSinceEpoch)) *
        size.width;
    double y = size.height -
        ((open.first - minValue) / (maxValue - minValue)) * size.height;
    chartPath.moveTo(x, y);
    // Store Chart Axis
    // for (int i = 0; i < dates.length; i++) {
    //   double x1 =
    //       ((dates[i].millisecondsSinceEpoch - minDate.millisecondsSinceEpoch) /
    //               (maxDate.millisecondsSinceEpoch -
    //                   minDate.millisecondsSinceEpoch)) *
    //           size.width;
    //   double y1 = size.height -
    //       ((prices[i] - minValue) / (maxValue - minValue)) * size.height;
    //
    //   chartAxis.add(Offset(x1, y1));
    // }
    //
    // Color paintColor = prices.first > prices.last ? fallColor : riseColor;
    //
    // paintColor = prices.first == prices.last ? noChangeColor : paintColor;

    // Draw lines between each pair of consecutive data points
    for (int i = 0; i < chartAxis.length - 1; i++) {
      // Create candlestick
    }

    chartPath.close();
    canvas.drawPath(chartPath, Paint()..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
