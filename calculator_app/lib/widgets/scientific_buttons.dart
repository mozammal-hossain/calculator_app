import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator_app/providers/calculator_provider.dart';
import 'package:calculator_app/widgets/calculator_button.dart';
import 'package:calculator_app/utils/constants.dart';
import 'package:calculator_app/models/calculator_state.dart';

/// Scientific calculator buttons layout
class ScientificButtons extends ConsumerWidget {
  const ScientificButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calculatorState = ref.watch(calculatorProvider);
    final calculatorNotifier = ref.read(calculatorProvider.notifier);

    return SingleChildScrollView(
      child: Column(
        children: [
          // Row 1: 2nd, π, e, (, )
          SizedBox(
            height: 60,
            child: Row(
              children: [
                CalculatorButton(
                  label: calculatorState.angleMode == AngleMode.degrees
                      ? AppConstants.degreeMode
                      : AppConstants.radianMode,
                  onPressed: calculatorNotifier.toggleAngleMode,
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.pi,
                  onPressed: () =>
                      calculatorNotifier.insertConstant(AppConstants.pi),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.euler,
                  onPressed: () =>
                      calculatorNotifier.insertConstant(AppConstants.euler),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.openParen,
                  onPressed: calculatorNotifier.appendOpenParen,
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.closeParen,
                  onPressed: calculatorNotifier.appendCloseParen,
                  type: ButtonType.function,
                ),
              ],
            ),
          ),

          // Row 2: sin, cos, tan, x², √x
          SizedBox(
            height: 60,
            child: Row(
              children: [
                CalculatorButton(
                  label: AppConstants.sin,
                  onPressed: () =>
                      calculatorNotifier.applyUnaryFunction(AppConstants.sin),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.cos,
                  onPressed: () =>
                      calculatorNotifier.applyUnaryFunction(AppConstants.cos),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.tan,
                  onPressed: () =>
                      calculatorNotifier.applyUnaryFunction(AppConstants.tan),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.square,
                  onPressed: () => calculatorNotifier
                      .applyUnaryFunction(AppConstants.square),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.squareRoot,
                  onPressed: () => calculatorNotifier
                      .applyUnaryFunction(AppConstants.squareRoot),
                  type: ButtonType.function,
                ),
              ],
            ),
          ),

          // Row 3: asin, acos, atan, x³, ³√x
          SizedBox(
            height: 60,
            child: Row(
              children: [
                CalculatorButton(
                  label: AppConstants.asin,
                  onPressed: () =>
                      calculatorNotifier.applyUnaryFunction(AppConstants.asin),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.acos,
                  onPressed: () =>
                      calculatorNotifier.applyUnaryFunction(AppConstants.acos),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.atan,
                  onPressed: () =>
                      calculatorNotifier.applyUnaryFunction(AppConstants.atan),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.cube,
                  onPressed: () =>
                      calculatorNotifier.applyUnaryFunction(AppConstants.cube),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.cubeRoot,
                  onPressed: () => calculatorNotifier
                      .applyUnaryFunction(AppConstants.cubeRoot),
                  type: ButtonType.function,
                ),
              ],
            ),
          ),

          // Row 4: log, ln, e^x, 10^x, x^y
          SizedBox(
            height: 60,
            child: Row(
              children: [
                CalculatorButton(
                  label: AppConstants.log,
                  onPressed: () =>
                      calculatorNotifier.applyUnaryFunction(AppConstants.log),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.ln,
                  onPressed: () =>
                      calculatorNotifier.applyUnaryFunction(AppConstants.ln),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.exp,
                  onPressed: () =>
                      calculatorNotifier.applyUnaryFunction(AppConstants.exp),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.power10,
                  onPressed: () => calculatorNotifier
                      .applyUnaryFunction(AppConstants.power10),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.power,
                  onPressed: calculatorNotifier.applyPower,
                  type: ButtonType.function,
                ),
              ],
            ),
          ),

          // Row 5: AC, +/-, x!, %, ÷
          SizedBox(
            height: 60,
            child: Row(
              children: [
                CalculatorButton(
                  label: AppConstants.allClear,
                  onPressed: calculatorNotifier.allClear,
                  type: ButtonType.clear,
                ),
                CalculatorButton(
                  label: AppConstants.negate,
                  onPressed: calculatorNotifier.toggleSign,
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.factorial,
                  onPressed: () => calculatorNotifier
                      .applyUnaryFunction(AppConstants.factorial),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.percent,
                  onPressed: calculatorNotifier.calculatePercentage,
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.divide,
                  onPressed: () => calculatorNotifier.appendOperator('÷'),
                  type: ButtonType.operator,
                ),
              ],
            ),
          ),

          // Row 6: 7, 8, 9, ×
          SizedBox(
            height: 60,
            child: Row(
              children: [
                CalculatorButton(
                  label: '7',
                  onPressed: () => calculatorNotifier.appendNumber('7'),
                ),
                CalculatorButton(
                  label: '8',
                  onPressed: () => calculatorNotifier.appendNumber('8'),
                ),
                CalculatorButton(
                  label: '9',
                  onPressed: () => calculatorNotifier.appendNumber('9'),
                ),
                CalculatorButton(
                  label: AppConstants.multiply,
                  onPressed: () => calculatorNotifier.appendOperator('×'),
                  type: ButtonType.operator,
                ),
              ],
            ),
          ),

          // Row 7: 4, 5, 6, -
          SizedBox(
            height: 60,
            child: Row(
              children: [
                CalculatorButton(
                  label: '4',
                  onPressed: () => calculatorNotifier.appendNumber('4'),
                ),
                CalculatorButton(
                  label: '5',
                  onPressed: () => calculatorNotifier.appendNumber('5'),
                ),
                CalculatorButton(
                  label: '6',
                  onPressed: () => calculatorNotifier.appendNumber('6'),
                ),
                CalculatorButton(
                  label: AppConstants.subtract,
                  onPressed: () => calculatorNotifier.appendOperator('-'),
                  type: ButtonType.operator,
                ),
              ],
            ),
          ),

          // Row 8: 1, 2, 3, +
          SizedBox(
            height: 60,
            child: Row(
              children: [
                CalculatorButton(
                  label: '1',
                  onPressed: () => calculatorNotifier.appendNumber('1'),
                ),
                CalculatorButton(
                  label: '2',
                  onPressed: () => calculatorNotifier.appendNumber('2'),
                ),
                CalculatorButton(
                  label: '3',
                  onPressed: () => calculatorNotifier.appendNumber('3'),
                ),
                CalculatorButton(
                  label: AppConstants.add,
                  onPressed: () => calculatorNotifier.appendOperator('+'),
                  type: ButtonType.operator,
                ),
              ],
            ),
          ),

          // Row 9: 0, ., ⌫, =
          SizedBox(
            height: 60,
            child: Row(
              children: [
                CalculatorButton(
                  label: '0',
                  onPressed: () => calculatorNotifier.appendNumber('0'),
                ),
                CalculatorButton(
                  label: AppConstants.decimal,
                  onPressed: calculatorNotifier.appendDecimal,
                ),
                CalculatorButton(
                  label: AppConstants.delete,
                  onPressed: calculatorNotifier.delete,
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.equals,
                  onPressed: calculatorNotifier.calculateResult,
                  type: ButtonType.equals,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
