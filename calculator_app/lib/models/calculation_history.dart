/// Model for a single calculation history entry
class CalculationEntry {
  final String expression;
  final String result;
  final DateTime timestamp;

  const CalculationEntry({
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  /// Creates a CalculationEntry from JSON
  factory CalculationEntry.fromJson(Map<String, dynamic> json) {
    return CalculationEntry(
      expression: json['expression'] as String,
      result: json['result'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  /// Converts the CalculationEntry to JSON
  Map<String, dynamic> toJson() {
    return {
      'expression': expression,
      'result': result,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalculationEntry &&
        other.expression == expression &&
        other.result == result &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode =>
      expression.hashCode ^ result.hashCode ^ timestamp.hashCode;

  @override
  String toString() {
    return 'CalculationEntry(expression: $expression, result: $result, timestamp: $timestamp)';
  }
}

/// State for calculation history
class HistoryState {
  final List<CalculationEntry> entries;

  const HistoryState({
    this.entries = const [],
  });

  HistoryState copyWith({
    List<CalculationEntry>? entries,
  }) {
    return HistoryState(
      entries: entries ?? this.entries,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryState &&
        other.entries.length == entries.length &&
        other.entries.every((entry) => entries.contains(entry));
  }

  @override
  int get hashCode => entries.hashCode;
}
