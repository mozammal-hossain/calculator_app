import 'dart:math' as math;
import 'package:calculator_app/models/calculator_state.dart';
import 'package:calculator_app/utils/constants.dart';

/// Utility class for scientific calculator operations
class ScientificLogic {
  /// Converts degrees to radians
  static double degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  /// Converts radians to degrees
  static double radiansToDegrees(double radians) {
    return radians * 180 / math.pi;
  }

  /// Evaluates a trigonometric function
  static String evaluateTrigFunction(
    String function,
    double value,
    AngleMode angleMode,
  ) {
    try {
      double result;
      final double inputValue =
          angleMode == AngleMode.degrees ? degreesToRadians(value) : value;

      switch (function) {
        case AppConstants.sin:
          result = math.sin(inputValue);
          break;
        case AppConstants.cos:
          result = math.cos(inputValue);
          break;
        case AppConstants.tan:
          result = math.tan(inputValue);
          break;
        case AppConstants.asin:
          final sinResult = math.asin(value);
          result = angleMode == AngleMode.degrees
              ? radiansToDegrees(sinResult)
              : sinResult;
          break;
        case AppConstants.acos:
          final cosResult = math.acos(value);
          result = angleMode == AngleMode.degrees
              ? radiansToDegrees(cosResult)
              : cosResult;
          break;
        case AppConstants.atan:
          final tanResult = math.atan(value);
          result = angleMode == AngleMode.degrees
              ? radiansToDegrees(tanResult)
              : tanResult;
          break;
        default:
          return 'Error';
      }

      if (result.isInfinite || result.isNaN) {
        return 'Error';
      }

      return _formatResult(result);
    } catch (e) {
      return 'Error';
    }
  }

  /// Evaluates a logarithmic function
  static String evaluateLogFunction(String function, double value) {
    try {
      if (value <= 0) return 'Error: Domain';

      double result;
      switch (function) {
        case AppConstants.log:
          result = math.log(value) / math.ln10; // log base 10
          break;
        case AppConstants.ln:
          result = math.log(value); // natural log
          break;
        default:
          return 'Error';
      }

      return _formatResult(result);
    } catch (e) {
      return 'Error';
    }
  }

  /// Evaluates an exponential function
  static String evaluateExpFunction(String function, double value) {
    try {
      double result;
      switch (function) {
        case AppConstants.exp:
          result = math.exp(value); // e^x
          break;
        case AppConstants.power10:
          result = math.pow(10, value).toDouble(); // 10^x
          break;
        default:
          return 'Error';
      }

      if (result.isInfinite || result.isNaN) {
        return 'Error: Overflow';
      }

      return _formatResult(result);
    } catch (e) {
      return 'Error';
    }
  }

  /// Evaluates power and root functions
  static String evaluatePowerFunction(String function, double value,
      [double? secondValue]) {
    try {
      double result;
      switch (function) {
        case AppConstants.square:
          result = math.pow(value, 2).toDouble();
          break;
        case AppConstants.cube:
          result = math.pow(value, 3).toDouble();
          break;
        case AppConstants.power:
          if (secondValue == null) return 'Error';
          result = math.pow(value, secondValue).toDouble();
          break;
        case AppConstants.squareRoot:
          if (value < 0) return 'Error: Domain';
          result = math.sqrt(value);
          break;
        case AppConstants.cubeRoot:
          result = value < 0
              ? -math.pow(-value, 1 / 3).toDouble()
              : math.pow(value, 1 / 3).toDouble();
          break;
        default:
          return 'Error';
      }

      if (result.isInfinite || result.isNaN) {
        return 'Error';
      }

      return _formatResult(result);
    } catch (e) {
      return 'Error';
    }
  }

  /// Calculates factorial
  static String calculateFactorial(double value) {
    try {
      if (value < 0 || value != value.floor()) {
        return 'Error: Must be non-negative integer';
      }

      if (value > 170) {
        return 'Error: Overflow';
      }

      int n = value.toInt();
      double result = 1;
      for (int i = 2; i <= n; i++) {
        result *= i;
      }

      return _formatResult(result);
    } catch (e) {
      return 'Error';
    }
  }

  /// Formats the result for display
  static String _formatResult(double result) {
    // Handle very small numbers
    if (result.abs() < 1e-10 && result != 0) {
      return result.toStringAsExponential(6);
    }

    // Handle very large numbers
    if (result.abs() > 1e10) {
      return result.toStringAsExponential(6);
    }

    // Remove trailing zeros and decimal point if not needed
    if (result == result.truncate()) {
      return result.truncate().toString();
    }

    // Limit decimal places
    String formatted = result.toStringAsFixed(10);
    formatted = formatted.replaceAll(RegExp(r'0*$'), '');
    formatted = formatted.replaceAll(RegExp(r'\.$'), '');

    return formatted;
  }

  /// Inserts a function into the expression
  static String insertFunction(String expression, String function) {
    // Handle special cases
    if (expression == '0') {
      return '$function(';
    }

    // Check if we should add multiplication before function
    if (expression.isNotEmpty) {
      final lastChar = expression[expression.length - 1];
      if (RegExp(r'[0-9)]').hasMatch(lastChar)) {
        return '$expression×$function(';
      }
    }

    return '$expression$function(';
  }

  /// Inserts a constant into the expression
  static String insertConstant(String expression, String constant) {
    String value;
    switch (constant) {
      case AppConstants.pi:
        value = AppConstants.piValue.toString();
        break;
      case AppConstants.euler:
        value = AppConstants.eulerValue.toString();
        break;
      default:
        return expression;
    }

    if (expression == '0') {
      return value;
    }

    // Check if we should add multiplication before constant
    if (expression.isNotEmpty) {
      final lastChar = expression[expression.length - 1];
      if (RegExp(r'[0-9)]').hasMatch(lastChar)) {
        return '$expression×$value';
      }
    }

    return expression + value;
  }

  /// Applies a unary function to the last number in expression
  static String applyUnaryFunction(
    String expression,
    String function,
    AngleMode angleMode,
  ) {
    try {
      // Extract the last number from the expression
      final regex = RegExp(r'(-?\d+\.?\d*)$');
      final match = regex.firstMatch(expression);

      if (match == null) return expression;

      final lastNumber = match.group(0)!;
      final prefix = expression.substring(0, match.start);
      final value = double.parse(lastNumber);

      String result;

      // Determine which type of function to evaluate
      if ([
        AppConstants.sin,
        AppConstants.cos,
        AppConstants.tan,
        AppConstants.asin,
        AppConstants.acos,
        AppConstants.atan
      ].contains(function)) {
        result = evaluateTrigFunction(function, value, angleMode);
      } else if ([AppConstants.log, AppConstants.ln].contains(function)) {
        result = evaluateLogFunction(function, value);
      } else if ([AppConstants.exp, AppConstants.power10].contains(function)) {
        result = evaluateExpFunction(function, value);
      } else if ([
        AppConstants.square,
        AppConstants.cube,
        AppConstants.squareRoot,
        AppConstants.cubeRoot
      ].contains(function)) {
        result = evaluatePowerFunction(function, value);
      } else if (function == AppConstants.factorial) {
        result = calculateFactorial(value);
      } else {
        return expression;
      }

      if (result.startsWith('Error')) {
        return result;
      }

      return prefix + result;
    } catch (e) {
      return 'Error';
    }
  }
}
