import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator_app/providers/history_provider.dart';
import 'package:calculator_app/models/calculation_history.dart';
import 'package:intl/intl.dart';

/// Screen displaying calculation history
class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyState = ref.watch(historyProvider);
    final historyNotifier = ref.read(historyProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          if (historyState.entries.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () => _showClearConfirmation(context, historyNotifier),
              tooltip: 'Clear History',
            ),
        ],
      ),
      body: historyState.entries.isEmpty
          ? _buildEmptyState(context)
          : _buildHistoryList(context, historyState.entries, historyNotifier),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No calculation history',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.5),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(
    BuildContext context,
    List<CalculationEntry> entries,
    HistoryNotifier notifier,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final entry = entries[index];
        return _buildHistoryItem(context, entry, notifier);
      },
    );
  }

  Widget _buildHistoryItem(
    BuildContext context,
    CalculationEntry entry,
    HistoryNotifier notifier,
  ) {
    final dateFormat = DateFormat('MMM dd, yyyy - HH:mm');

    return Dismissible(
      key: Key(entry.timestamp.toIso8601String()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Theme.of(context).colorScheme.error,
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
      onDismissed: (_) => notifier.deleteEntry(entry),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Row(
          children: [
            Expanded(
              child: Text(
                entry.expression,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '=',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.5),
                  ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                entry.result,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            dateFormat.format(entry.timestamp),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.5),
                ),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () => _copyToClipboard(context, entry.result),
          tooltip: 'Copy result',
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showClearConfirmation(BuildContext context, HistoryNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear History'),
        content: const Text(
            'Are you sure you want to clear all calculation history?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              notifier.clearHistory();
              Navigator.pop(context);
            },
            child: Text(
              'Clear',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
