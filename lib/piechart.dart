import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Piechart extends StatelessWidget {
  Map worldData;
  Piechart({this.worldData});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: {
        'Confirmed': worldData['cases'].toDouble(),
        'Active': worldData['active'].toDouble(),
        'Recovered': worldData['recovered'].toDouble(),
        'Deaths': worldData['deaths'].toDouble()
      },
      colorList: [Colors.red, Colors.blue, Colors.green, Colors.grey[400]],
    );
  }
}
