/// State for calculator memory functions
class MemoryState {
  final double value;
  final bool hasValue;

  const MemoryState({
    this.value = 0.0,
    this.hasValue = false,
  });

  MemoryState copyWith({
    double? value,
    bool? hasValue,
  }) {
    return MemoryState(
      value: value ?? this.value,
      hasValue: hasValue ?? this.hasValue,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MemoryState &&
        other.value == value &&
        other.hasValue == hasValue;
  }

  @override
  int get hashCode => value.hashCode ^ hasValue.hashCode;

  @override
  String toString() {
    return 'MemoryState(value: $value, hasValue: $hasValue)';
  }
}
