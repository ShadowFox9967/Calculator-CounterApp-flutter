import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _displayText = "0"; // To store the current input or result
  String _input = ""; // To store the current sequence of numbers
  double? _firstOperand; // Store the first operand
  String? _operator; // Store the operator

  List<String> _buttons = [
    'C', 'AC', '%', '/',
    '7', '8', '9', '*',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '+/-', '0', '.', '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator Page"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Display Screen
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16),
              color: Colors.black12,
              child: Text(
                _displayText,
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          // Buttons Grid
          Expanded(
            flex: 8,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 columns
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: _buttons.length,
              itemBuilder: (context, index) {
                String buttonText = _buttons[index];
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    backgroundColor: _getButtonColor(buttonText),
                  ),
                  onPressed: () {
                    _onButtonPressed(buttonText);
                  },
                  child: Text(
                    buttonText,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Handle button press
  void _onButtonPressed(String buttonText) {
  setState(() {
    if (_isNumeric(buttonText)) {
      // Append the number to the current input
      if (_input == "0" || _input.isEmpty) {
        _input = buttonText;
      } else {
        _input += buttonText;
      }
      _displayText = _input;
    } else {
      switch (buttonText) {
        case '/':
        case '*':
        case '-':
        case '+':
          // Capture the first operand and store the operator
          _firstOperand = double.tryParse(_input);
          _operator = buttonText;
          _input = ""; // Clear input for the next number
          break;

        case '=':
          // Perform the stored operation
          if (isValidExpression(_input)) {
            if (_operator != null && _firstOperand != null) {
              try {
                double secondOperand = double.tryParse(_input) ?? 0;
                double result;
                switch (_operator) {
                  case '/':
                    result = _firstOperand! / secondOperand;
                    break;
                  case '*':
                    result = _firstOperand! * secondOperand;
                    break;
                  case '-':
                    result = _firstOperand! - secondOperand;
                    break;
                  case '+':
                    result = _firstOperand! + secondOperand;
                    break;
                  default:
                    result = 0;
                }
                // Format the result to trim unnecessary decimal places
                _displayText = formatNumber(result);
                _input = _displayText; // Update input with the result
                _operator = null; // Clear operator
                _firstOperand = null; // Clear operand
              } catch (e) {
                _displayText = "Invalid Expression";
                _input = ""; // Optionally clear input
              }
            }
          } else {
            _displayText = "Invalid Expression";
            _input = ""; // Optionally clear input
          }
          break;

        case 'C':
          _displayText = "";
          break;

        case '+/-':
          setState(() {
            // Check if displayText is not empty and can be parsed to a number
            if (_displayText.isNotEmpty && double.tryParse(_displayText) != null) {
              // Parse the current displayText to a double
              double currentNumber = double.parse(_displayText);
              // Negate the number
              double negatedNumber = -currentNumber;
              // Convert the negated number back to a string and update displayText
              _displayText = formatNumber(negatedNumber);
              // Update the input to reflect the negated number
              _input = _displayText;
            }
          });
          break;

        case '%':
          setState(() {
            // Check if displayText is not empty and can be parsed to a number
            if (_displayText.isNotEmpty && double.tryParse(_displayText) != null) {
              // Parse the current displayText to a double
              double currentNumber = double.parse(_displayText);
              // Calculate the percentage (e.g., for 20%, it's 20/100)
              double percentageValue = currentNumber / 100;
              // Update displayText to show the percentage value
              _displayText = formatNumber(percentageValue);
              // Update the input to reflect the percentage value
              _input = _displayText;
            }
          });
          break;

        case 'AC':
          // Clear everything
          _input = "";
          _displayText = "0";
          _operator = null;
          _firstOperand = null;
          break;
      }
    }
  });
}

// Check if the expression is valid
bool isValidExpression(String expression) {
  // Implement basic validation logic (you may want to add more checks)
  // For example, check if the expression contains valid numbers and operators
  try {
    // Try parsing the expression
    // In a more complex implementation, you might use a parser or expression evaluator
    double result = double.parse(expression); // Simple check, assumes the expression is numeric
    return true;
  } catch (e) {
    return false;
  }
}

// Format the number to trim unnecessary decimal places
String formatNumber(double number) {
  if (number % 1 == 0) {
    return number.toStringAsFixed(0); // No decimal places if the number is an integer
  } else {
    return number.toString(); // Use default formatting if it's a floating point number
  }
}


  // Check if the input is a number
  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Color _getButtonColor(String buttonText) {
    switch (buttonText) {
      case 'C':
      case'AC':
        return Colors.redAccent;
      case '=':
        return Colors.greenAccent;
      case '*':
      case '/':
      case '+':
      case '-':
        return Colors.green;
      default:
        return Colors.grey[800]!;
    }
  }
}
