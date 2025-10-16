import 'package:flutter/material.dart';
import 'package:calculator_app/utils/constants.dart';

/// Display widget for showing expression and result
class CalculatorDisplay extends StatelessWidget {
  final String expression;
  final String result;
  final bool hasError;

  const CalculatorDisplay({
    super.key,
    required this.expression,
    required this.result,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.displayPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Expression display
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              expression,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontSize: AppConstants.expressionFontSize,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 8),
          // Result display
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              result,
              style: theme.textTheme.displayLarge?.copyWith(
                fontSize: AppConstants.resultFontSize,
                fontWeight: FontWeight.bold,
                color: hasError
                    ? theme.colorScheme.error
                    : theme.colorScheme.onSurface,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
