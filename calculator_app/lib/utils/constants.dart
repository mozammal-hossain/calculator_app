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

  // Scientific function labels
  static const String sin = 'sin';
  static const String cos = 'cos';
  static const String tan = 'tan';
  static const String asin = 'asin';
  static const String acos = 'acos';
  static const String atan = 'atan';
  static const String log = 'log';
  static const String ln = 'ln';
  static const String exp = 'e^x';
  static const String power10 = '10^x';
  static const String square = 'x²';
  static const String cube = 'x³';
  static const String power = 'x^y';
  static const String squareRoot = '√x';
  static const String cubeRoot = '³√x';
  static const String factorial = 'x!';
  static const String pi = 'π';
  static const String euler = 'e';
  static const String openParen = '(';
  static const String closeParen = ')';
  static const String degreeMode = 'DEG';
  static const String radianMode = 'RAD';

  // Mathematical constants
  static const double piValue = 3.141592653589793;
  static const double eulerValue = 2.718281828459045;

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
