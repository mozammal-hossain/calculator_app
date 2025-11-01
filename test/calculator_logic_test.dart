import 'package:flutter_test/flutter_test.dart';
import 'package:calculator_app/utils/calculator_logic.dart';

void main() {
  group('CalculatorLogic Tests', () {
    group('Basic Arithmetic Operations', () {
      test('Addition works correctly', () {
        expect(CalculatorLogic.evaluateExpression('2+3'), '5');
        expect(CalculatorLogic.evaluateExpression('10+5'), '15');
        expect(CalculatorLogic.evaluateExpression('0+0'), '0');
      });

      test('Subtraction works correctly', () {
        expect(CalculatorLogic.evaluateExpression('5-3'), '2');
        expect(CalculatorLogic.evaluateExpression('10-5'), '5');
        expect(CalculatorLogic.evaluateExpression('0-5'), '-5');
      });

      test('Multiplication works correctly', () {
        expect(CalculatorLogic.evaluateExpression('2×3'), '6');
        expect(CalculatorLogic.evaluateExpression('5×0'), '0');
        expect(CalculatorLogic.evaluateExpression('10×10'), '100');
      });

      test('Division works correctly', () {
        expect(CalculatorLogic.evaluateExpression('6÷2'), '3');
        expect(CalculatorLogic.evaluateExpression('10÷5'), '2');
        expect(CalculatorLogic.evaluateExpression('7÷2'), '3.5');
      });

      test('Division by zero returns error', () {
        final result = CalculatorLogic.evaluateExpression('5÷0');
        expect(result.contains('Error'), isTrue);
      });
    });

    group('Complex Expressions', () {
      test('Multiple operations work correctly', () {
        expect(CalculatorLogic.evaluateExpression('2+3×4'), '14');
        expect(CalculatorLogic.evaluateExpression('10-5+3'), '8');
        expect(CalculatorLogic.evaluateExpression('2×3+4×5'), '26');
      });

      test('Decimal numbers work correctly', () {
        expect(CalculatorLogic.evaluateExpression('2.5+2.5'), '5');
        expect(CalculatorLogic.evaluateExpression('3.14×2'), '6.28');
      });

      test('Negative numbers work correctly', () {
        expect(CalculatorLogic.evaluateExpression('-5+3'), '-2');
        expect(CalculatorLogic.evaluateExpression('-10×2'), '-20');
      });
    });

    group('Expression Validation', () {
      test('Detects invalid expressions', () {
        expect(CalculatorLogic.isValidExpression('5+'), isFalse);
        expect(CalculatorLogic.isValidExpression('×5'), isFalse);
        expect(CalculatorLogic.isValidExpression(''), isFalse);
      });

      test('Validates correct expressions', () {
        expect(CalculatorLogic.isValidExpression('5+5'), isTrue);
        expect(CalculatorLogic.isValidExpression('123'), isTrue);
        expect(CalculatorLogic.isValidExpression('2.5×3'), isTrue);
      });

      test('Checks if expression ends with operator', () {
        expect(CalculatorLogic.endsWithOperator('5+'), isTrue);
        expect(CalculatorLogic.endsWithOperator('5×'), isTrue);
        expect(CalculatorLogic.endsWithOperator('5'), isFalse);
      });
    });

    group('Number Formatting', () {
      test('Formats integers correctly', () {
        expect(CalculatorLogic.formatNumber('5.0'), '5');
        expect(CalculatorLogic.formatNumber('10.0'), '10');
      });

      test('Preserves decimals when needed', () {
        expect(CalculatorLogic.formatNumber('3.14'), '3.14');
        expect(CalculatorLogic.formatNumber('2.5'), '2.5');
      });

      test('Handles zero correctly', () {
        expect(CalculatorLogic.formatNumber('0'), '0');
        expect(CalculatorLogic.formatNumber(''), '0');
      });
    });
  });
}
