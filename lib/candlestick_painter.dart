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
    double candleWidth = 10;
    double scale = 1.0;

    for (var data in stockPriceHistory) {
      dates.add(data.dateTime);
      open.add(data.open);
      close.add(data.close);
      high.add(data.high);
      low.add(data.low);
    }

    double openMinValue = open.reduce((a, b) => a < b ? a : b);
    double openMaxValue = open.reduce((a, b) => a > b ? a : b);
    double closeMinValue = close.reduce((a, b) => a < b ? a : b);
    double closeMaxValue = close.reduce((a, b) => a > b ? a : b);

    double minValue =
        openMinValue < closeMinValue ? openMinValue : closeMinValue;
    double maxValue =
        openMaxValue > closeMaxValue ? openMaxValue : closeMaxValue;

    for (int i = 0; i < dates.length; i++) {
      // Create candlestick

      final double x = i * candleWidth;
      final double openY =
          size.height * (1 - (open[i] - minValue) / (maxValue - minValue));
      final double closeY =
          size.height * (1 - (close[i] - minValue) / (maxValue - minValue));
      final double highY =
          size.height * (1 - (high[i] - minValue) / (maxValue - minValue));
      final double lowY =
          size.height * (1 - (low[i] - minValue) / (maxValue - minValue));

      Paint paint = Paint()
        ..color = close[i] > open[i] ? Colors.green : Colors.red;

      canvas.drawLine(
        Offset(x + candleWidth / 2, highY),
        Offset(x + candleWidth / 2, lowY),
        paint,
      );

      canvas.drawRect(
        Rect.fromLTRB(
          x + candleWidth * 0.1,
          openY,
          x + candleWidth * 0.9,
          closeY,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
