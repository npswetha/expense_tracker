import 'package:expensetracker/front.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Buddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent,
          titleTextStyle: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "Arial",
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
      home: CenteredImagePage(),
    );
  }
}

class CenteredImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Frontpage()),
      );
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
          "lib/icons.png",
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
