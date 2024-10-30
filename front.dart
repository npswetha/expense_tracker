import 'package:flutter/material.dart';
import 'package:expensetracker/select.dart';

class Frontpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Buddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HorizontalScrollImagePage(),
    );
  }
}

class HorizontalScrollImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ExpenseTrackerApp()),
      );
    });

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("BUDGET BUDDY"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Stack(
          children: [
            Container(
              width: screenWidth * 1.5,
              child: Stack(
                children: [
                  Image.asset(
                    'lib/front.jpg',
                    fit: BoxFit.cover,
                    width: screenWidth * 1.5,
                  ),
                  Positioned(
                    right: 20,
                    bottom: screenHeight * 0.15,
                    child: Text(
                      "SAVE TODAY, SMILE TOMORROW!!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: screenHeight * 0.1,
                    child: Text(
                      "SMALL SAVINGS, BIG DREAMS!!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: screenHeight * 0.05,
                    child: Text(
                      "INVEST IN YOUR FUTURE!!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
