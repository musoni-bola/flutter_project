import 'package:flutter/material.dart';
import 'button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = ""; // First number
  String operand = ""; // Operand (+, -, *, /)
  String number2 = ""; // Second number

  static const TextStyle displayTextStyle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
  );

  static const double buttonTextSize = 24;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double buttonSize = screenSize.width / 20;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        bottom: false,
        child: Center(
          child: Container(
            width: screenSize.width * 0.4,
            height: screenSize.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Text(
                      "$number1$operand$number2".isEmpty ? "0" : "$number1$operand$number2",
                      style: displayTextStyle,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: Btn.buttonValues.map((value) {
                    final width = value == Btn.n0 ? buttonSize * 2 + 10 : buttonSize;
                    return SizedBox(
                      width: width,
                      height: buttonSize,
                      child: buildButton(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton(String value) {
    return MaterialButton(
      onPressed: () => onBtnTap(value),
      color: getBtnColor(value),
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        value,
        style: const TextStyle(fontSize: buttonTextSize),
      ),
    );
  }

  void onBtnTap(String value) {
    setState(() {
      if (value == Btn.del) {
        delete();
      } else if (value == Btn.clr) {
        clearAll();
      } else if (value == Btn.per) {
        convertToPercentage();
      } else if (value == Btn.calculate) {
        calculate();
      } else {
        appendValue(value);
      }
    });
  }

  void calculate() {
    if (number1.isEmpty || operand.isEmpty || number2.isEmpty) return;

    final num1 = double.parse(number1);
    final num2 = double.parse(number2);
    double result = 0.0;

    switch (operand) {
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;
    }

    setState(() {
      number1 = result.toStringAsFixed(2); // Adjusted to show two decimal places
      operand = "";
      number2 = "";
    });
  }

  void convertToPercentage() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      calculate();
    }

    if (operand.isNotEmpty) return;

    final number = double.parse(number1);
    setState(() {
      number1 = (number / 100).toString();
      operand = "";
      number2 = "";
    });
  }

  void clearAll() {
    number1 = "";
    operand = "";
    number2 = "";
  }

  void delete() {
    if (number2.isNotEmpty) {
      number2 = number2.substring(0, number2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }
  }

  void appendValue(String value) {
    if (value != Btn.dot && int.tryParse(value) == null) {
      if (operand.isNotEmpty && number2.isNotEmpty) calculate();
      operand = value;
    } else if (operand.isEmpty) {
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      if (value == Btn.dot && number1.isEmpty) value = "0.";
      number1 += value;
    } else {
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      if (value == Btn.dot && number2.isEmpty) value = "0.";
      number2 += value;
    }
  }

  Color getBtnColor(String value) {
    if ([Btn.del, Btn.clr].contains(value)) {
      return Colors.blueGrey;
    } else if ([Btn.per, Btn.multiply, Btn.add, Btn.subtract, Btn.divide, Btn.calculate].contains(value)) {
      return Colors.orange;
    } else {
      return Colors.black87;
    }
  }
}

class Btn {
  static const String del = "D";
  static const String clr = "C";
  static const String per = "%";
  static const String multiply = "×";
  static const String divide = "÷";
  static const String add = "+";
  static const String subtract = "-";
  static const String calculate = "=";
  static const String dot = ".";

  static const String n0 = "0";
  static const String n1 = "1";
  static const String n2 = "2";
  static const String n3 = "3";
  static const String n4 = "4";
  static const String n5 = "5";
  static const String n6 = "6";
  static const String n7 = "7";
  static const String n8 = "8";
  static const String n9 = "9";

  static const List<String> buttonValues = [
    del,
    clr,
    per,
    multiply,
    divide,
    subtract,
    add,
    calculate,
    n7,
    n8,
    n9,
    n4,
    n5,
    n6,
    n1,
    n2,
    n3,
    n0,
    dot,
  ];
}
