import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator_app/providers/calculator_provider.dart';
import 'package:calculator_app/providers/memory_provider.dart';
import 'package:calculator_app/widgets/calculator_display.dart';
import 'package:calculator_app/widgets/calculator_button.dart';
import 'package:calculator_app/widgets/scientific_buttons.dart';
import 'package:calculator_app/utils/constants.dart';
import 'package:calculator_app/screens/history_screen.dart';
import 'package:calculator_app/screens/settings_screen.dart';

/// Main calculator screen with basic arithmetic operations
class CalculatorScreen extends ConsumerWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calculatorState = ref.watch(calculatorProvider);
    final calculatorNotifier = ref.read(calculatorProvider.notifier);
    final memoryState = ref.watch(memoryProvider);
    final memoryNotifier = ref.read(memoryProvider.notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Calculator'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.history),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HistoryScreen()),
          ),
          tooltip: 'History',
        ),
        actions: [
          if (memoryState.hasValue)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Chip(
                label: const Text('M'),
                labelStyle: Theme.of(context).textTheme.labelSmall,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                side: BorderSide.none,
              ),
            ),
          IconButton(
            icon: Icon(
              calculatorState.isScientificMode
                  ? Icons.calculate
                  : Icons.science,
            ),
            onPressed: calculatorNotifier.toggleMode,
            tooltip: 'Toggle Scientific Mode',
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              } else if (value == 'copy') {
                _copyResult(context, calculatorState.result);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'copy',
                child: Row(
                  children: [
                    Icon(Icons.copy),
                    SizedBox(width: 8),
                    Text('Copy Result'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 8),
                    Text('Settings'),
                  ],
                ),
              ),
            ],
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
              flex: 5,
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
      bottomNavigationBar: calculatorState.isScientificMode
          ? null
          : _buildMemoryBar(
              context, ref, memoryNotifier, calculatorState.result),
    );
  }

  Widget _buildMemoryBar(
    BuildContext context,
    WidgetRef ref,
    MemoryNotifier memoryNotifier,
    String currentResult,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildMemoryButton(context, 'MC', () => memoryNotifier.clearMemory()),
          _buildMemoryButton(context, 'MR', () {
            final value = memoryNotifier.recallMemory();
            ref
                .read(calculatorProvider.notifier)
                .appendNumber(value.toString());
          }),
          _buildMemoryButton(context, 'M+', () async {
            final value = double.tryParse(currentResult) ?? 0;
            await memoryNotifier.addToMemory(value);
            HapticFeedback.mediumImpact();
          }),
          _buildMemoryButton(context, 'M-', () async {
            final value = double.tryParse(currentResult) ?? 0;
            await memoryNotifier.subtractFromMemory(value);
            HapticFeedback.mediumImpact();
          }),
        ],
      ),
    );
  }

  Widget _buildMemoryButton(
      BuildContext context, String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  void _copyResult(BuildContext context, String result) {
    if (result == '0' || result.contains('Error')) return;

    Clipboard.setData(ClipboardData(text: result));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Result copied to clipboard'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
