import 'package:flutter/material.dart';

// Global variables for simplicity
double savingsGoal = 0.0; // Savings goal
double totalExpenses = 0.0; // Total expenses

class ExpenseFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
        backgroundColor: Colors.blue,
      ),
      body: ExpenseForm(),
    );
  }
}

class ExpenseForm extends StatefulWidget {
  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  List<TextEditingController> _titleControllers = [];
  List<TextEditingController> _amountControllers = [];

  void _showFieldDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int numberOfFields = 0;

        return AlertDialog(
          title: Text('Enter Number of Expenses'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Number of Fields'),
            onChanged: (value) {
              numberOfFields = int.tryParse(value) ?? 0;
            },
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _generateFields(numberOfFields);
              },
            ),
          ],
        );
      },
    );
  }

  void _generateFields(int count) {
    setState(() {
      _titleControllers = List.generate(count, (_) => TextEditingController());
      _amountControllers = List.generate(count, (_) => TextEditingController());
    });
  }

  void _submitForm() {
    double newTotal = 0.0;

    for (var amountController in _amountControllers) {
      double amount = double.tryParse(amountController.text) ?? 0;
      newTotal += amount;
    }

    setState(() {
      totalExpenses += newTotal; // Update total expenses
    });

    // Show a snackbar with the input values
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Total Expenses Added: \$${newTotal.toStringAsFixed(2)}, Grand Total: \$${totalExpenses.toStringAsFixed(2)}')),
    );

    // Clear the form fields for new input
    for (var controller in _titleControllers) {
      controller.clear();
    }
    for (var controller in _amountControllers) {
      controller.clear();
    }
  }

  @override
 @override
Widget build(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(16.0),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _showFieldDialog,
            child: Text('Add Expense',style:TextStyle(color:Colors.black)),
             style:ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 111, 185, 245)),
          ),
          SizedBox(height: 20),
          Text(
            'Total Expenses: \$${totalExpenses.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20), // Optional: Increase font size for visibility
          ),
          SizedBox(height: 20),
          // Generate text fields based on the number of expenses
          ...List.generate(_titleControllers.length, (index) {
            return Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleControllers[index],
                    decoration: InputDecoration(labelText: 'Title ${index + 1}'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _amountControllers[index],
                    decoration: InputDecoration(labelText: 'Amount ${index + 1}'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            );
          }),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm, // Call _submitForm when pressed
            child: Text('Submit',style:TextStyle(color:Colors.black)),
            style:ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 111, 185, 245)),
          ),
        ],
      ),
    ),
  );
}
}

// Savings Goal Page
class SetSavingsGoalPage extends StatefulWidget {
  @override
  _SetSavingsGoalPageState createState() => _SetSavingsGoalPageState();
}

class _SetSavingsGoalPageState extends State<SetSavingsGoalPage> {
  final TextEditingController _goalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Savings Goal'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _goalController,
              decoration: InputDecoration(labelText: 'Monthly Savings Goal'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _setSavingsGoal(context);
                
              },
              style:ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 111, 185, 245)),
              child: Text('Set Goal',style:TextStyle(color:Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  void _setSavingsGoal(BuildContext context) {
    final double goal = double.tryParse(_goalController.text) ?? 0;

    if (goal > 0) {
      setState(() {
        savingsGoal = goal; // Update global savings goal variable
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Savings goal set to \$${savingsGoal.toStringAsFixed(2)}'),
      ));

      // Clear the form
      _goalController.clear();
    }
  }
}

// Analysis Page

class AnalysisPage extends StatefulWidget {
  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  String result = '';
  
  double totalExpenses = 500; // Example value for total expenses
  double savingsGoal = 1000; // Example value for savings goal

  void checksaving() {
    setState(() {
      if (totalExpenses <= savingsGoal) {
        result = 'HURRAY! YOUR EXPENSE IS BELOW SAVING GOAL, CONGRATS!';
      } else {
        result = 'YOUR EXPENSE IS NOT BELOW SAVING GOAL, REDUCE YOUR EXPENSES';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Analysis',
          style: TextStyle(
            fontFamily: "Times New Roman",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 96, 179, 247),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Responsive padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // First Card for Total Expenses
                Container(
                  width: screenWidth * 0.4, // Responsive width
                  height: screenHeight * 0.35, // Responsive height
                  child: Card(
                    color: const Color.fromARGB(255, 134, 196, 247),
                    elevation: 4,
                    margin: EdgeInsets.all(16.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Expenses:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '\$${totalExpenses.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Second Card for Savings Goal
                Container(
                  width: screenWidth * 0.4, // Responsive width
                  height: screenHeight * 0.35, // Responsive height
                  child: Card(
                    color: const Color.fromARGB(255, 134, 196, 247),
                    elevation: 4,
                    margin: EdgeInsets.all(16.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Savings Goal:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '\$${savingsGoal.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: checksaving,
              child: Text('Check'),
            ),
            SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center, // Center the result text
            ),
          ],
        ),
      ),
    );
  }
}


