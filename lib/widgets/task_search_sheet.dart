import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../models/task_model.dart';
import '../providers/locale_provider.dart';
import '../providers/task_provider.dart';
import 'zettask_loaders.dart';

class TaskSearchSheet extends StatefulWidget {
  const TaskSearchSheet({
    super.key,
    required this.onSelectTask,
  });

  final ValueChanged<TaskModel> onSelectTask;

  static Future<void> show(
    BuildContext context, {
    required ValueChanged<TaskModel> onSelectTask,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => TaskSearchSheet(onSelectTask: onSelectTask),
    );
  }

  @override
  State<TaskSearchSheet> createState() => _TaskSearchSheetState();
}

class _TaskSearchSheetState extends State<TaskSearchSheet> {
  final _searchController = TextEditingController();
  List<TaskModel> _results = const [];
  bool _isSearching = false;
  String _lastQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onQueryChanged(String value) async {
    final trimmed = value.trim();
    setState(() {
      _lastQuery = trimmed;
      _isSearching = trimmed.isNotEmpty;
    });

    if (trimmed.isEmpty) {
      setState(() {
        _results = const [];
        _isSearching = false;
      });
      return;
    }

    final found = await context.read<TaskProvider>().searchTasks(trimmed);
    if (!mounted || _lastQuery != trimmed) return;

    setState(() {
      _results = found;
      _isSearching = false;
    });
  }

  String _formatDateLabel(
    DateTime? date,
    AppLocalizations l10n,
    String intlLocale,
  ) {
    if (date == null) return l10n.unplanned;
    try {
      return DateFormat('d MMM yyyy', intlLocale).format(date);
    } catch (_) {
      return DateFormat('d MMM yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final maxHeight =
        (screenHeight - viewInsets.bottom).clamp(280.0, screenHeight * 0.88);

    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outline,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 8, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      onChanged: _onQueryChanged,
                      decoration: InputDecoration(
                        hintText: l10n.searchTasksHint,
                        prefixIcon: const Icon(Icons.search_rounded, size: 20),
                        suffixIcon: _lastQuery.isNotEmpty
                            ? IconButton(
                                tooltip: l10n.clear,
                                onPressed: () {
                                  _searchController.clear();
                                  _onQueryChanged('');
                                },
                                icon: const Icon(Icons.close_rounded, size: 18),
                              )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    tooltip: l10n.close,
                    onPressed: () => Navigator.of(context).pop(),
                    style: IconButton.styleFrom(
                      minimumSize: const Size(48, 48),
                    ),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            const Divider(),
            Flexible(
              child: _buildResultsBody(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsBody(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final intlLocale =
        LocaleProvider.intlLocaleTag(Localizations.localeOf(context));

    if (_isSearching) {
      return const ZettaskTaskListSkeleton(
        itemCount: 3,
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(16, 12, 16, 20),
      );
    }

    if (_lastQuery.isEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 36),
        child: Text(
          l10n.searchTasksEmpty,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall,
        ),
      );
    }

    if (_results.isEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 36),
        child: Text(
          l10n.searchNoResults(_lastQuery),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall,
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: _results.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final task = _results[index];
        final tagColor = AppTheme.resolveTagColor(
          task.colorHex,
          theme.brightness,
        );

        return Material(
          color: colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: colorScheme.outline, width: 1),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
              widget.onSelectTask(task);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: task.isCompleted
                          ? tagColor.withValues(alpha: 0.45)
                          : tagColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 14.5,
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: task.isCompleted
                                ? colorScheme.onSurfaceVariant
                                : colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          task.hasStartTime
                              ? '${_formatDateLabel(task.date, l10n, intlLocale)} · ${task.startTime}'
                              : _formatDateLabel(task.date, l10n, intlLocale),
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
