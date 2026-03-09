// Task 2: Async Calculator App
// Name: Addis Ababa University Student (Place holder)
// Name : Kidist Beyene

import 'dart:async';

// Constant for the simulated delay
const delay = Duration(seconds: 1, milliseconds: 500);

class Calculator {
  final String name;
  Calculator(this.name);

  // Adds two numbers
  double add(double a, double b) => a + b;

  // Subtracts two numbers
  double subtract(double a, double b) => a - b;

  // Multiplies two numbers
  double multiply(double a, double b) => a * b;

  // Divides two numbers - throws error if dividing by zero
  double divide(double a, double b) {
    if (b == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return a / b;
  }

  // Async method - picks the right operation, waits 1.5s, returns result
  Future<double> computeAsync(double a, double b, String op) async {
    double result;
    switch (op) {
      case 'add':
        result = add(a, b);
        break;
      case 'subtract':
        result = subtract(a, b);
        break;
      case 'multiply':
        result = multiply(a, b);
        break;
      case 'divide':
        result = divide(a, b);
        break;
      default:
        throw ArgumentError('Unknown operation: $op');
    }
    await Future.delayed(delay);
    return result;
  }

  // Calls computeAsync and prints result - catches errors gracefully
  Future<void> displayResult(double a, double b, String op) async {
    try {
      final result = await computeAsync(a, b, op);
      print('$op($a, $b) = $result');
    } catch (e) {
      print('Error: $e');
    }
  }
}

Future<void> main() async {
  final calc = Calculator('MyCalculator');
  print('--- ${calc.name} ---');

  await calc.displayResult(10, 4, 'add');
  await calc.displayResult(10, 4, 'subtract');
  await calc.displayResult(10, 4, 'multiply');
  await calc.displayResult(10, 4, 'divide');
  await calc.displayResult(15, 3, 'divide');
  await calc.displayResult(10, 0, 'divide');

  print('All calculations complete.');
}
