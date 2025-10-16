import 'package:math_expressions/math_expressions.dart';

/// Utility class for calculator logic and expression evaluation
class CalculatorLogic {
  /// Evaluates a mathematical expression and returns the result
  static String evaluateExpression(String expression) {
    try {
      // Replace common symbols with math_expressions compatible ones
      String processedExpression = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('%', '/100')
          .replaceAll('^', '^'); // Power operator is already supported

      // Parse and evaluate the expression
      Parser parser = Parser();
      Expression exp = parser.parse(processedExpression);
      ContextModel contextModel = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, contextModel);

      // Format the result
      if (eval.isInfinite) {
        return 'Error: Infinity';
      }
      if (eval.isNaN) {
        return 'Error: Invalid';
      }

      // Remove unnecessary decimals
      if (eval == eval.truncate()) {
        return eval.truncate().toString();
      }

      // Limit decimal places to 10
      return eval
          .toStringAsFixed(10)
          .replaceAll(RegExp(r'0*$'), '')
          .replaceAll(RegExp(r'\.$'), '');
    } catch (e) {
      return 'Error';
    }
  }

  /// Checks if the last character is an operator
  static bool endsWithOperator(String expression) {
    if (expression.isEmpty) return false;
    final lastChar = expression[expression.length - 1];
    return ['+', '-', '×', '÷', '*', '/'].contains(lastChar);
  }

  /// Checks if the expression is valid
  static bool isValidExpression(String expression) {
    if (expression.isEmpty) return false;
    if (endsWithOperator(expression)) return false;

    // Check if expression starts with an operator (except minus for negative numbers)
    final firstChar = expression[0];
    if (['+', '×', '÷', '*', '/'].contains(firstChar)) return false;

    // Check for balanced parentheses
    int openCount = 0;
    for (var char in expression.split('')) {
      if (char == '(') openCount++;
      if (char == ')') openCount--;
      if (openCount < 0) return false;
    }

    return openCount == 0;
  }

  /// Formats a number for display
  static String formatNumber(String number) {
    if (number.isEmpty || number == '0') return '0';

    try {
      double value = double.parse(number);
      if (value == value.truncate()) {
        return value.truncate().toString();
      }
      return value.toString();
    } catch (e) {
      return number;
    }
  }
}
