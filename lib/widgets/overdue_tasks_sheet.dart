import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../models/task_model.dart';
import '../providers/locale_provider.dart';
import '../providers/task_provider.dart';

class OverdueTasksSheet extends StatelessWidget {
  const OverdueTasksSheet({
    super.key,
    required this.onEditTask,
  });

  final ValueChanged<TaskModel> onEditTask;

  static Future<void> show(
    BuildContext context, {
    required ValueChanged<TaskModel> onEditTask,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => OverdueTasksSheet(onEditTask: onEditTask),
    );
  }

  String _formatDateBadge(DateTime? date, String intlLocale) {
    if (date == null) return '';
    try {
      return DateFormat('d MMM', intlLocale).format(date);
    } catch (_) {
      return DateFormat('d MMM').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final intlLocale =
        LocaleProvider.intlLocaleTag(Localizations.localeOf(context));
    final maxHeight = MediaQuery.sizeOf(context).height * 0.82;

    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        final overdueTasks = taskProvider.overdueTasks;

        return ConstrainedBox(
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
                padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 8, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.overdueTasksTitle,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 19,
                        ),
                      ),
                    ),
                    if (overdueTasks.length > 1)
                      TextButton(
                        onPressed: () async {
                          await taskProvider.moveAllOverdueToToday();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text(l10n.moveAllOverdueMoved),
                                ),
                              );
                          }
                        },
                        style: TextButton.styleFrom(
                          minimumSize: const Size(48, 48),
                        ),
                        child: Text(l10n.moveAllShort),
                      ),
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
              if (overdueTasks.isEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 36),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: 36,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.noOverdueTasks,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.noOverdueTasksSubtitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                )
              else
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
                    itemCount: overdueTasks.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final task = overdueTasks[index];
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
                            onEditTask(task);
                          },
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              14,
                              12,
                              12,
                              10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: tagColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            task.title,
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(fontSize: 15),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            task.hasStartTime
                                                ? '${_formatDateBadge(task.date, intlLocale)} · ${task.startTime}'
                                                : _formatDateBadge(
                                                    task.date,
                                                    intlLocale,
                                                  ),
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                              color: colorScheme.error,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () =>
                                          taskProvider.toggleTaskComplete(task),
                                      style: TextButton.styleFrom(
                                        minimumSize: const Size(48, 48),
                                        foregroundColor:
                                            colorScheme.onSurfaceVariant,
                                      ),
                                      child: Text(l10n.completedLabel),
                                    ),
                                    const SizedBox(width: 4),
                                    FilledButton.tonal(
                                      onPressed: () async {
                                        await taskProvider.moveTaskToDate(
                                          task,
                                          DateTime.now(),
                                        );
                                      },
                                      style: FilledButton.styleFrom(
                                        minimumSize: const Size(48, 48),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(l10n.moveToToday),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
