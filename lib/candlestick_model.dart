class StockData {
  final String stockCode;
  final DateTime dateTime;
  final double open;
  final double close;
  final double high;
  final double low;

  StockData({
    required this.stockCode,
    required this.dateTime,
    required this.open,
    required this.close,
    required this.high,
    required this.low,
  });

  factory StockData.fromJson(Map<String, dynamic> json) {
    String dateString = json['Date'];
    DateTime dateTime = DateTime.parse(dateString);

    return StockData(
      stockCode: json['StockCode'],
      dateTime: dateTime,
      open: double.parse(
        json['Open'],
      ),
      close: double.parse(
        json['Close'],
      ),
      high: double.parse(
        json['High'],
      ),
      low: double.parse(
        json['Low'],
      ),
    );
  }
}

class PriceHistory {
  final bool status;
  final String message;
  final List<StockData> stockPriceHistory;

  PriceHistory({
    required this.stockPriceHistory,
    required this.status,
    required this.message,
  });

  factory PriceHistory.fromJson(Map<String, dynamic> json) {
    List<StockData> stockPriceHistory = [];

    if (json['data']['stock_price_history'] != null) {
      json['data']['stock_price_history'].forEach((priceHistory) {
        stockPriceHistory.add(StockData.fromJson(priceHistory));
      });
    }

    return PriceHistory(
        stockPriceHistory: stockPriceHistory,
        status: json['status'],
        message: json['message']);
  }
}
