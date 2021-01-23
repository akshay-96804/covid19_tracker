import 'package:covid_tracker/database.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: primaryBlack,
          fontFamily: 'Circular',
          brightness: Brightness.dark),
      home: HomePage(),
    );
  }
}
