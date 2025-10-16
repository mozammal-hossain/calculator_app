import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator_app/providers/calculator_provider.dart';
import 'package:calculator_app/widgets/calculator_display.dart';
import 'package:calculator_app/widgets/calculator_button.dart';
import 'package:calculator_app/widgets/scientific_buttons.dart';
import 'package:calculator_app/utils/constants.dart';

/// Main calculator screen with basic arithmetic operations
class CalculatorScreen extends ConsumerWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calculatorState = ref.watch(calculatorProvider);
    final calculatorNotifier = ref.read(calculatorProvider.notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Calculator'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              calculatorState.isScientificMode
                  ? Icons.calculate
                  : Icons.science,
            ),
            onPressed: calculatorNotifier.toggleMode,
            tooltip: 'Toggle Scientific Mode',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display area
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CalculatorDisplay(
                  expression: calculatorState.expression,
                  result: calculatorState.result,
                  hasError: calculatorState.hasError,
                ),
              ),
            ),

            // Button grid
            Expanded(
              flex: calculatorState.isScientificMode ? 7 : 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: calculatorState.isScientificMode
                    ? const ScientificButtons()
                    : Column(
                        children: [
                          // Row 1: AC, +/-, %, ÷
                          Expanded(
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
                                  label: AppConstants.percent,
                                  onPressed:
                                      calculatorNotifier.calculatePercentage,
                                  type: ButtonType.function,
                                ),
                                CalculatorButton(
                                  label: AppConstants.divide,
                                  onPressed: () =>
                                      calculatorNotifier.appendOperator('÷'),
                                  type: ButtonType.operator,
                                ),
                              ],
                            ),
                          ),

                          // Row 2: 7, 8, 9, ×
                          Expanded(
                            child: Row(
                              children: [
                                CalculatorButton(
                                  label: '7',
                                  onPressed: () =>
                                      calculatorNotifier.appendNumber('7'),
                                ),
                                CalculatorButton(
                                  label: '8',
                                  onPressed: () =>
                                      calculatorNotifier.appendNumber('8'),
                                ),
                                CalculatorButton(
                                  label: '9',
                                  onPressed: () =>
                                      calculatorNotifier.appendNumber('9'),
                                ),
                                CalculatorButton(
                                  label: AppConstants.multiply,
                                  onPressed: () =>
                                      calculatorNotifier.appendOperator('×'),
                                  type: ButtonType.operator,
                                ),
                              ],
                            ),
                          ),

                          // Row 3: 4, 5, 6, -
                          Expanded(
                            child: Row(
                              children: [
                                CalculatorButton(
                                  label: '4',
                                  onPressed: () =>
                                      calculatorNotifier.appendNumber('4'),
                                ),
                                CalculatorButton(
                                  label: '5',
                                  onPressed: () =>
                                      calculatorNotifier.appendNumber('5'),
                                ),
                                CalculatorButton(
                                  label: '6',
                                  onPressed: () =>
                                      calculatorNotifier.appendNumber('6'),
                                ),
                                CalculatorButton(
                                  label: AppConstants.subtract,
                                  onPressed: () =>
                                      calculatorNotifier.appendOperator('-'),
                                  type: ButtonType.operator,
                                ),
                              ],
                            ),
                          ),

                          // Row 4: 1, 2, 3, +
                          Expanded(
                            child: Row(
                              children: [
                                CalculatorButton(
                                  label: '1',
                                  onPressed: () =>
                                      calculatorNotifier.appendNumber('1'),
                                ),
                                CalculatorButton(
                                  label: '2',
                                  onPressed: () =>
                                      calculatorNotifier.appendNumber('2'),
                                ),
                                CalculatorButton(
                                  label: '3',
                                  onPressed: () =>
                                      calculatorNotifier.appendNumber('3'),
                                ),
                                CalculatorButton(
                                  label: AppConstants.add,
                                  onPressed: () =>
                                      calculatorNotifier.appendOperator('+'),
                                  type: ButtonType.operator,
                                ),
                              ],
                            ),
                          ),

                          // Row 5: 0, ., ⌫, =
                          Expanded(
                            child: Row(
                              children: [
                                CalculatorButton(
                                  label: '0',
                                  onPressed: () =>
                                      calculatorNotifier.appendNumber('0'),
                                  flex: 2,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
