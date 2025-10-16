import 'package:flutter_test/flutter_test.dart';
import 'package:calculator_app/utils/scientific_logic.dart';
import 'package:calculator_app/models/calculator_state.dart';
import 'package:calculator_app/utils/constants.dart';
import 'dart:math' as math;

void main() {
  group('ScientificLogic Tests', () {
    group('Trigonometric Functions - Degrees', () {
      test('Sin function works correctly in degrees', () {
        final result =
            ScientificLogic.evaluateTrigFunction('sin', 30, AngleMode.degrees);
        expect(double.parse(result), closeTo(0.5, 0.0001));
      });

      test('Cos function works correctly in degrees', () {
        final result =
            ScientificLogic.evaluateTrigFunction('cos', 60, AngleMode.degrees);
        expect(double.parse(result), closeTo(0.5, 0.0001));
      });

      test('Tan function works correctly in degrees', () {
        final result =
            ScientificLogic.evaluateTrigFunction('tan', 45, AngleMode.degrees);
        expect(double.parse(result), closeTo(1.0, 0.0001));
      });
    });

    group('Trigonometric Functions - Radians', () {
      test('Sin function works correctly in radians', () {
        final result = ScientificLogic.evaluateTrigFunction(
            'sin', math.pi / 6, AngleMode.radians);
        expect(double.parse(result), closeTo(0.5, 0.0001));
      });

      test('Cos function works correctly in radians', () {
        final result = ScientificLogic.evaluateTrigFunction(
            'cos', math.pi / 3, AngleMode.radians);
        expect(double.parse(result), closeTo(0.5, 0.0001));
      });
    });

    group('Logarithmic Functions', () {
      test('Log base 10 works correctly', () {
        final result = ScientificLogic.evaluateLogFunction('log', 100);
        expect(result, '2');
      });

      test('Natural log works correctly', () {
        final result = ScientificLogic.evaluateLogFunction('ln', math.e);
        expect(double.parse(result), closeTo(1.0, 0.0001));
      });

      test('Log of zero or negative returns error', () {
        final result1 = ScientificLogic.evaluateLogFunction('log', 0);
        final result2 = ScientificLogic.evaluateLogFunction('log', -5);
        expect(result1.contains('Error'), isTrue);
        expect(result2.contains('Error'), isTrue);
      });
    });

    group('Exponential Functions', () {
      test('e^x works correctly', () {
        final result = ScientificLogic.evaluateExpFunction('e^x', 1);
        expect(double.parse(result), closeTo(math.e, 0.0001));
      });

      test('10^x works correctly', () {
        final result = ScientificLogic.evaluateExpFunction('10^x', 2);
        expect(result, '100');
      });
    });

    group('Power and Root Functions', () {
      test('Square function works correctly', () {
        final result = ScientificLogic.evaluatePowerFunction('x²', 5);
        expect(result, '25');
      });

      test('Cube function works correctly', () {
        final result = ScientificLogic.evaluatePowerFunction('x³', 3);
        expect(result, '27');
      });

      test('Square root works correctly', () {
        final result = ScientificLogic.evaluatePowerFunction('√x', 16);
        expect(result, '4');
      });

      test('Cube root works correctly', () {
        final result = ScientificLogic.evaluatePowerFunction('³√x', 27);
        expect(double.parse(result), closeTo(3.0, 0.0001));
      });

      test('Square root of negative returns error', () {
        final result = ScientificLogic.evaluatePowerFunction('√x', -4);
        expect(result.contains('Error'), isTrue);
      });
    });

    group('Factorial Function', () {
      test('Factorial of 0 is 1', () {
        final result = ScientificLogic.calculateFactorial(0);
        expect(result, '1');
      });

      test('Factorial of 5 is 120', () {
        final result = ScientificLogic.calculateFactorial(5);
        expect(result, '120');
      });

      test('Factorial of 10 is 3628800', () {
        final result = ScientificLogic.calculateFactorial(10);
        expect(result, '3628800');
      });

      test('Factorial of negative number returns error', () {
        final result = ScientificLogic.calculateFactorial(-5);
        expect(result.contains('Error'), isTrue);
      });

      test('Factorial of decimal returns error', () {
        final result = ScientificLogic.calculateFactorial(5.5);
        expect(result.contains('Error'), isTrue);
      });
    });

    group('Constant Insertion', () {
      test('Pi constant is inserted correctly', () {
        final result = ScientificLogic.insertConstant('0', 'π');
        expect(result, AppConstants.piValue.toString());
      });

      test('Euler constant is inserted correctly', () {
        final result = ScientificLogic.insertConstant('0', 'e');
        expect(result, AppConstants.eulerValue.toString());
      });

      test('Constant with implicit multiplication', () {
        final result = ScientificLogic.insertConstant('5', 'π');
        expect(result, '5×${AppConstants.piValue}');
      });
    });

    group('Function Insertion', () {
      test('Function is inserted correctly', () {
        final result = ScientificLogic.insertFunction('0', 'sin');
        expect(result, 'sin(');
      });

      test('Function with implicit multiplication', () {
        final result = ScientificLogic.insertFunction('5', 'cos');
        expect(result, '5×cos(');
      });
    });

    group('Unary Function Application', () {
      test('Applies sin to last number', () {
        final result =
            ScientificLogic.applyUnaryFunction('30', 'sin', AngleMode.degrees);
        expect(double.parse(result), closeTo(0.5, 0.0001));
      });

      test('Applies square to last number', () {
        final result =
            ScientificLogic.applyUnaryFunction('5', 'x²', AngleMode.degrees);
        expect(result, '25');
      });

      test('Applies factorial to last number', () {
        final result =
            ScientificLogic.applyUnaryFunction('5', 'x!', AngleMode.degrees);
        expect(result, '120');
      });
    });
  });
}
