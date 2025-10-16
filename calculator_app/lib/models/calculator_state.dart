/// Calculator state model that holds the current state of the calculator
class CalculatorState {
  /// The current expression being built
  final String expression;

  /// The calculated result
  final String result;

  /// Whether the calculator is in scientific mode
  final bool isScientificMode;

  /// Whether there's an error state
  final bool hasError;

  /// Error message if any
  final String? errorMessage;

  const CalculatorState({
    this.expression = '0',
    this.result = '0',
    this.isScientificMode = false,
    this.hasError = false,
    this.errorMessage,
  });

  /// Creates a copy of this state with the given fields replaced
  CalculatorState copyWith({
    String? expression,
    String? result,
    bool? isScientificMode,
    bool? hasError,
    String? errorMessage,
  }) {
    return CalculatorState(
      expression: expression ?? this.expression,
      result: result ?? this.result,
      isScientificMode: isScientificMode ?? this.isScientificMode,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'CalculatorState(expression: $expression, result: $result, '
        'isScientificMode: $isScientificMode, hasError: $hasError)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalculatorState &&
        other.expression == expression &&
        other.result == result &&
        other.isScientificMode == isScientificMode &&
        other.hasError == hasError &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return expression.hashCode ^
        result.hashCode ^
        isScientificMode.hashCode ^
        hasError.hashCode ^
        errorMessage.hashCode;
  }
}
