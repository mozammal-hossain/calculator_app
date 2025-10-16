import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator_app/models/calculator_state.dart';
import 'package:calculator_app/utils/calculator_logic.dart';
import 'package:calculator_app/utils/scientific_logic.dart';
import 'package:calculator_app/providers/history_provider.dart';

/// Provider for calculator state management
final calculatorProvider =
    StateNotifierProvider<CalculatorNotifier, CalculatorState>((ref) {
  return CalculatorNotifier(ref);
});

/// StateNotifier for managing calculator operations
class CalculatorNotifier extends StateNotifier<CalculatorState> {
  final Ref ref;

  CalculatorNotifier(this.ref) : super(const CalculatorState());

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
  void calculateResult() async {
    if (state.hasError) return;

    if (!CalculatorLogic.isValidExpression(state.expression)) {
      state = state.copyWith(
        hasError: true,
        errorMessage: 'Invalid Expression',
        result: 'Error',
      );
      return;
    }

    final expression = state.expression;
    final result = CalculatorLogic.evaluateExpression(expression);

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

      // Add to history (import will be added)
      try {
        final historyNotifier = ref.read(historyProvider.notifier);
        await historyNotifier.addCalculation(expression, result);
      } catch (e) {
        // Silently handle any history errors
      }
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

  /// Toggles between degrees and radians
  void toggleAngleMode() {
    final newMode = state.angleMode == AngleMode.degrees
        ? AngleMode.radians
        : AngleMode.degrees;
    state = state.copyWith(angleMode: newMode);
  }

  /// Appends an opening parenthesis
  void appendOpenParen() {
    if (state.hasError) {
      state = const CalculatorState();
      return;
    }

    String newExpression = state.expression;

    if (newExpression == '0') {
      newExpression = '(';
    } else {
      // Add multiplication if needed
      final lastChar = newExpression[newExpression.length - 1];
      if (RegExp(r'[0-9)]').hasMatch(lastChar)) {
        newExpression += '×(';
      } else {
        newExpression += '(';
      }
    }

    state = state.copyWith(expression: newExpression);
  }

  /// Appends a closing parenthesis
  void appendCloseParen() {
    if (state.hasError) return;

    String expression = state.expression;

    // Count open and close parentheses
    int openCount = 0;
    int closeCount = 0;
    for (var char in expression.split('')) {
      if (char == '(') openCount++;
      if (char == ')') closeCount++;
    }

    // Only add close paren if there are unclosed open parens
    if (openCount > closeCount &&
        !CalculatorLogic.endsWithOperator(expression)) {
      state = state.copyWith(expression: '$expression)');
    }
  }

  /// Inserts a scientific function
  void insertFunction(String function) {
    if (state.hasError) {
      state = const CalculatorState();
      return;
    }

    final newExpression =
        ScientificLogic.insertFunction(state.expression, function);
    state = state.copyWith(expression: newExpression);
  }

  /// Inserts a mathematical constant
  void insertConstant(String constant) {
    if (state.hasError) {
      state = const CalculatorState();
      return;
    }

    final newExpression =
        ScientificLogic.insertConstant(state.expression, constant);
    state = state.copyWith(expression: newExpression);
  }

  /// Applies a unary function to the last number
  void applyUnaryFunction(String function) {
    if (state.hasError) return;

    final result = ScientificLogic.applyUnaryFunction(
      state.expression,
      function,
      state.angleMode,
    );

    if (result.startsWith('Error')) {
      state = state.copyWith(
        hasError: true,
        errorMessage: result,
        result: result,
      );
    } else {
      state = state.copyWith(expression: result);
    }
  }

  /// Applies power function (for x^y)
  void applyPower() {
    if (state.hasError) return;

    String newExpression = state.expression;

    // Don't add operator if expression is just '0'
    if (newExpression == '0') return;

    // Replace the last operator if the expression ends with one
    if (CalculatorLogic.endsWithOperator(newExpression)) {
      newExpression = newExpression.substring(0, newExpression.length - 1);
    }

    newExpression += '^';

    state = state.copyWith(expression: newExpression);
  }
}
