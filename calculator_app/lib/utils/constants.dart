import 'package:flutter/material.dart';

/// Application-wide constants
class AppConstants {
  // Button labels
  static const String clear = 'C';
  static const String allClear = 'AC';
  static const String delete = '⌫';
  static const String divide = '÷';
  static const String multiply = '×';
  static const String subtract = '-';
  static const String add = '+';
  static const String equals = '=';
  static const String decimal = '.';
  static const String percent = '%';
  static const String negate = '+/-';

  // Number buttons
  static const List<String> numbers = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];

  // Basic operation buttons
  static const List<String> basicOperators = [divide, multiply, subtract, add];

  // Button dimensions
  static const double buttonSpacing = 8.0;
  static const double buttonBorderRadius = 20.0;

  // Display settings
  static const double displayPadding = 24.0;
  static const double expressionFontSize = 24.0;
  static const double resultFontSize = 48.0;

  // Animation durations
  static const Duration buttonPressAnimation = Duration(milliseconds: 100);
  static const Duration themeTransition = Duration(milliseconds: 300);
}

/// Button types for styling
enum ButtonType {
  number,
  operator,
  function,
  equals,
  clear,
}

/// Button configuration
class ButtonConfig {
  final String label;
  final ButtonType type;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const ButtonConfig({
    required this.label,
    required this.type,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
  });
}
