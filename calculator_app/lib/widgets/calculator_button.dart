import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calculator_app/utils/constants.dart';

/// Custom calculator button widget
class CalculatorButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType type;
  final int flex;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = ButtonType.number,
    this.flex = 1,
  });

  Color _getBackgroundColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (type) {
      case ButtonType.operator:
        return colorScheme.primaryContainer;
      case ButtonType.function:
        return colorScheme.secondaryContainer;
      case ButtonType.equals:
        return colorScheme.primary;
      case ButtonType.clear:
        return colorScheme.errorContainer;
      case ButtonType.number:
        return colorScheme.surfaceContainerHighest;
    }
  }

  Color _getTextColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (type) {
      case ButtonType.operator:
        return colorScheme.onPrimaryContainer;
      case ButtonType.function:
        return colorScheme.onSecondaryContainer;
      case ButtonType.equals:
        return colorScheme.onPrimary;
      case ButtonType.clear:
        return colorScheme.onErrorContainer;
      case ButtonType.number:
        return colorScheme.onSurface;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.buttonSpacing / 2),
        child: Material(
          color: _getBackgroundColor(context),
          borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
          child: InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              onPressed();
            },
            borderRadius:
                BorderRadius.circular(AppConstants.buttonBorderRadius),
            child: Container(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: _getTextColor(context),
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
