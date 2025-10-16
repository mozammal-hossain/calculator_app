import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator_app/models/calculator_state.dart';
import 'package:calculator_app/utils/calculator_logic.dart';

/// Provider for calculator state management
final calculatorProvider =
    StateNotifierProvider<CalculatorNotifier, CalculatorState>((ref) {
  return CalculatorNotifier();
});

/// StateNotifier for managing calculator operations
class CalculatorNotifier extends StateNotifier<CalculatorState> {
  CalculatorNotifier() : super(const CalculatorState());

  /// Appends a number to the expression
  void appendNumber(String number) {
    String newExpression = state.expression;

    // If current expression is '0' or error, replace it
    if (newExpression == '0' || state.hasError) {
      newExpression = number;
    } else {
      newExpression += number;
    }

    state = state.copyWith(
      expression: newExpression,
      hasError: false,
      errorMessage: null,
    );
  }

  /// Appends an operator to the expression
  void appendOperator(String operator) {
    if (state.hasError) {
      state = const CalculatorState();
      return;
    }

    String newExpression = state.expression;

    // Don't add operator if expression is just '0'
    if (newExpression == '0') return;

    // Replace the last operator if the expression ends with one
    if (CalculatorLogic.endsWithOperator(newExpression)) {
      newExpression = newExpression.substring(0, newExpression.length - 1);
    }

    newExpression += operator;

    state = state.copyWith(expression: newExpression);
  }

  /// Appends a decimal point
  void appendDecimal() {
    if (state.hasError) {
      state = const CalculatorState();
      return;
    }

    String newExpression = state.expression;

    // Find the last number in the expression
    final parts = newExpression.split(RegExp(r'[+\-×÷]'));
    final lastNumber = parts.isNotEmpty ? parts.last : '';

    // Only add decimal if the last number doesn't already have one
    if (!lastNumber.contains('.')) {
      if (newExpression == '0') {
        newExpression = '0.';
      } else if (CalculatorLogic.endsWithOperator(newExpression)) {
        newExpression += '0.';
      } else {
        newExpression += '.';
      }

      state = state.copyWith(expression: newExpression);
    }
  }

  /// Calculates the result of the expression
  void calculateResult() {
    if (state.hasError) return;

    if (!CalculatorLogic.isValidExpression(state.expression)) {
      state = state.copyWith(
        hasError: true,
        errorMessage: 'Invalid Expression',
        result: 'Error',
      );
      return;
    }

    final result = CalculatorLogic.evaluateExpression(state.expression);

    if (result.startsWith('Error')) {
      state = state.copyWith(
        hasError: true,
        errorMessage: result,
        result: result,
      );
    } else {
      state = state.copyWith(
        result: result,
        expression: result,
      );
    }
  }

  /// Clears the last entry (CE - Clear Entry)
  void clear() {
    state = state.copyWith(
      expression: '0',
      result: '0',
      hasError: false,
      errorMessage: null,
    );
  }

  /// Clears all (AC - All Clear)
  void allClear() {
    state = const CalculatorState();
  }

  /// Deletes the last character
  void delete() {
    if (state.hasError) {
      state = const CalculatorState();
      return;
    }

    String newExpression = state.expression;

    if (newExpression.length <= 1) {
      newExpression = '0';
    } else {
      newExpression = newExpression.substring(0, newExpression.length - 1);
    }

    state = state.copyWith(expression: newExpression);
  }

  /// Toggles the sign of the last number
  void toggleSign() {
    if (state.hasError) return;

    String expression = state.expression;

    // Find the last number
    final regex = RegExp(r'(-?\d+\.?\d*)$');
    final match = regex.firstMatch(expression);

    if (match != null) {
      final lastNumber = match.group(0)!;
      final prefix = expression.substring(0, match.start);

      String newNumber;
      if (lastNumber.startsWith('-')) {
        newNumber = lastNumber.substring(1);
      } else {
        newNumber = '-$lastNumber';
      }

      state = state.copyWith(expression: prefix + newNumber);
    }
  }

  /// Calculates percentage
  void calculatePercentage() {
    if (state.hasError) return;

    final result =
        CalculatorLogic.evaluateExpression('${state.expression}/100');

    if (!result.startsWith('Error')) {
      state = state.copyWith(
        expression: result,
        result: result,
      );
    }
  }

  /// Toggles between basic and scientific mode
  void toggleMode() {
    state = state.copyWith(isScientificMode: !state.isScientificMode);
  }
}
