import 'dart:convert';

import 'package:candlestick_widget/candlestick_model.dart';
import 'package:candlestick_widget/candlestick_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CandleStickScreen extends StatefulWidget {
  const CandleStickScreen({super.key});

  @override
  State<CandleStickScreen> createState() => _CandleStickScreenState();
}

class _CandleStickScreenState extends State<CandleStickScreen> {
  Map<String, dynamic>? data;

  Future<void> loadJsonFromAssets() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    setState(() {
      data = jsonDecode(jsonString);
    });
  }

  @override
  void initState() {
    loadJsonFromAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      return Scaffold(
        body: Center(
            child: CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 300),
          painter: CandleStickPainter(
              PriceHistory.fromJson(data!).stockPriceHistory),
        )),
      );
    } else {
      return const Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
