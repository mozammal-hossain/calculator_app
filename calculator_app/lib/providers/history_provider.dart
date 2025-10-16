import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator_app/models/calculation_history.dart';
import 'package:calculator_app/services/storage_service.dart';

/// Provider for calculation history management
final historyProvider =
    StateNotifierProvider<HistoryNotifier, HistoryState>((ref) {
  return HistoryNotifier();
});

/// StateNotifier for managing calculation history
class HistoryNotifier extends StateNotifier<HistoryState> {
  HistoryNotifier() : super(const HistoryState()) {
    _loadHistory();
  }

  /// Loads history from storage
  Future<void> _loadHistory() async {
    final entries = await StorageService.loadHistory();
    state = HistoryState(entries: entries);
  }

  /// Adds a new calculation to history
  Future<void> addCalculation(String expression, String result) async {
    // Don't add if result is an error
    if (result.contains('Error')) return;

    // Don't add if expression and result are the same (no calculation)
    if (expression == result) return;

    final newEntry = CalculationEntry(
      expression: expression,
      result: result,
      timestamp: DateTime.now(),
    );

    final updatedEntries = [newEntry, ...state.entries];

    // Keep only the last 100 entries
    final limitedEntries = updatedEntries.take(100).toList();

    state = HistoryState(entries: limitedEntries);
    await StorageService.saveHistory(limitedEntries);
  }

  /// Clears all history
  Future<void> clearHistory() async {
    state = const HistoryState();
    await StorageService.clearHistory();
  }

  /// Deletes a specific entry
  Future<void> deleteEntry(CalculationEntry entry) async {
    final updatedEntries = state.entries.where((e) => e != entry).toList();
    state = HistoryState(entries: updatedEntries);
    await StorageService.saveHistory(updatedEntries);
  }
}
