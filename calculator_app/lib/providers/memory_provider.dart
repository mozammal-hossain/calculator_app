import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator_app/models/memory_state.dart';
import 'package:calculator_app/services/storage_service.dart';

/// Provider for memory management
final memoryProvider =
    StateNotifierProvider<MemoryNotifier, MemoryState>((ref) {
  return MemoryNotifier();
});

/// StateNotifier for managing calculator memory
class MemoryNotifier extends StateNotifier<MemoryState> {
  MemoryNotifier() : super(const MemoryState()) {
    _loadMemory();
  }

  /// Loads memory from storage
  Future<void> _loadMemory() async {
    final data = await StorageService.loadMemory();
    state = MemoryState(
      value: data['value'] as double,
      hasValue: data['hasValue'] as bool,
    );
  }

  /// Adds value to memory (M+)
  Future<void> addToMemory(double value) async {
    final newValue = state.value + value;
    state = MemoryState(value: newValue, hasValue: true);
    await StorageService.saveMemory(newValue, true);
  }

  /// Subtracts value from memory (M-)
  Future<void> subtractFromMemory(double value) async {
    final newValue = state.value - value;
    state = MemoryState(value: newValue, hasValue: true);
    await StorageService.saveMemory(newValue, true);
  }

  /// Clears memory (MC)
  Future<void> clearMemory() async {
    state = const MemoryState();
    await StorageService.saveMemory(0.0, false);
  }

  /// Returns memory value (MR)
  double recallMemory() {
    return state.value;
  }

  /// Sets memory to a specific value
  Future<void> setMemory(double value) async {
    state = MemoryState(value: value, hasValue: true);
    await StorageService.saveMemory(value, true);
  }
}
