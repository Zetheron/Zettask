import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../models/project_model.dart';
import '../models/tag_model.dart';
import '../models/task_model.dart';
import '../providers/locale_provider.dart';
import '../providers/task_provider.dart';
import '../providers/workspace_provider.dart';

sealed class QuickAddResult {
  const QuickAddResult();
}

final class QuickAddSaved extends QuickAddResult {
  const QuickAddSaved(this.task);

  final TaskModel task;
}

final class QuickAddExpand extends QuickAddResult {
  const QuickAddExpand(this.draftTask);

  final TaskModel draftTask;
}

class QuickAddTaskSheet extends StatefulWidget {
  const QuickAddTaskSheet({
    super.key,
    this.defaultDate,
    this.onRequestNotificationPermission,
  });

  final DateTime? defaultDate;
  final Future<bool> Function()? onRequestNotificationPermission;

  static Future<QuickAddResult?> show(
    BuildContext context, {
    DateTime? defaultDate,
    Future<bool> Function()? onRequestNotificationPermission,
  }) {
    return showModalBottomSheet<QuickAddResult>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => QuickAddTaskSheet(
        defaultDate: defaultDate,
        onRequestNotificationPermission: onRequestNotificationPermission,
      ),
    );
  }

  @override
  State<QuickAddTaskSheet> createState() => _QuickAddTaskSheetState();
}

class _QuickAddTaskSheetState extends State<QuickAddTaskSheet> {
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int? _reminderMinutesBefore;
  int? _selectedProjectId;
  int? _selectedTagId;
  TaskPriority _priority = TaskPriority.medium;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.defaultDate != null
        ? TaskProvider.normalizeDate(widget.defaultDate!)
        : null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _dateChipLabel(AppLocalizations l10n, String localeTag) {
    final date = _selectedDate;
    if (date == null) return l10n.noDate;
    final today = TaskProvider.normalizeDate(DateTime.now());
    final diff = date.difference(today).inDays;
    if (diff == 0) return l10n.today;
    if (diff == 1) return l10n.tomorrow;
    try {
      return DateFormat('d MMM', localeTag).format(date);
    } catch (_) {
      return DateFormat('d MMM').format(date);
    }
  }

  String _reminderChipLabel(AppLocalizations l10n) {
    return switch (_reminderMinutesBefore) {
      null => l10n.reminderLabel,
      0 => l10n.atTime,
      10 => l10n.reminderShort10m,
      30 => l10n.reminderShort30m,
      60 => l10n.reminderShort1h,
      final mins => '${mins}m',
    };
  }

  String _priorityLabel(TaskPriority priority, AppLocalizations l10n) {
    return switch (priority) {
      TaskPriority.low => l10n.priorityLow,
      TaskPriority.medium => l10n.priorityMedium,
      TaskPriority.high => l10n.priorityHigh,
    };
  }

  TaskModel _buildDraftTask() {
    final hasDate = _selectedDate != null;
    final startTime = hasDate && _selectedTime != null
        ? _formatTimeOfDay(_selectedTime!)
        : null;
    final reminder = startTime != null ? _reminderMinutesBefore : null;

    return TaskModel(
      title: _titleController.text.trim(),
      date: _selectedDate,
      startTime: startTime,
      reminderMinutesBefore: reminder,
      projectId: _selectedProjectId,
      tagId: _selectedTagId,
      priority: _priority,
      colorHex: AppTheme.tagPalette.first.hex,
    );
  }

  void _save() {
    if (_titleController.text.trim().isEmpty) return;
    Navigator.of(context).pop(QuickAddSaved(_buildDraftTask()));
  }

  void _expand() {
    Navigator.of(context).pop(QuickAddExpand(_buildDraftTask()));
  }

  Future<void> _pickDateOption() async {
    final l10n = AppLocalizations.of(context);
    final today = TaskProvider.normalizeDate(DateTime.now());
    final tomorrow = today.add(const Duration(days: 1));

    final choice = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return _QuickOptionSheet(
          title: l10n.pickDate,
          options: [
            _QuickOptionItem(
              value: 'today',
              label: l10n.today,
              icon: Icons.today_rounded,
              isSelected: _selectedDate != null &&
                  TaskProvider.isSameDay(_selectedDate!, today),
            ),
            _QuickOptionItem(
              value: 'tomorrow',
              label: l10n.tomorrow,
              icon: Icons.wb_sunny_outlined,
              isSelected: _selectedDate != null &&
                  TaskProvider.isSameDay(_selectedDate!, tomorrow),
            ),
            _QuickOptionItem(
              value: 'custom',
              label: l10n.pickOnCalendar,
              icon: Icons.calendar_month_outlined,
              isSelected: false,
            ),
            _QuickOptionItem(
              value: 'none',
              label: l10n.noDateUnplanned,
              icon: Icons.inbox_outlined,
              isSelected: _selectedDate == null,
            ),
          ],
        );
      },
    );

    if (!mounted || choice == null) return;
    if (choice == 'today') {
      setState(() => _selectedDate = today);
    } else if (choice == 'tomorrow') {
      setState(() => _selectedDate = tomorrow);
    } else if (choice == 'none') {
      setState(() {
        _selectedDate = null;
        _selectedTime = null;
        _reminderMinutesBefore = null;
      });
    } else if (choice == 'custom') {
      final picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? today,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );
      if (picked != null && mounted) {
        setState(() => _selectedDate = TaskProvider.normalizeDate(picked));
      }
    }
  }

  Future<void> _pickTime() async {
    final l10n = AppLocalizations.of(context);
    if (_selectedTime != null) {
      final action = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (_) => _QuickOptionSheet(
          title: l10n.taskTime,
          options: [
            _QuickOptionItem(
              value: 'change',
              label: l10n.changeTime,
              icon: Icons.schedule_rounded,
              isSelected: false,
            ),
            _QuickOptionItem(
              value: 'clear',
              label: l10n.clearTimeAllDay,
              icon: Icons.close_rounded,
              isSelected: false,
            ),
          ],
        ),
      );
      if (!mounted || action == null) return;
      if (action == 'clear') {
        setState(() {
          _selectedTime = null;
          _reminderMinutesBefore = null;
        });
        return;
      }
    }

    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && mounted) {
      setState(() {
        _selectedDate ??= TaskProvider.normalizeDate(DateTime.now());
        _selectedTime = picked;
      });
    }
  }

  Future<void> _pickReminder() async {
    final l10n = AppLocalizations.of(context);
    if (_selectedTime == null) {
      await _pickTime();
      if (!mounted || _selectedTime == null) return;
    }

    final chosen = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _QuickOptionSheet<int>(
        title: l10n.reminderLabel,
        options: [
          _QuickOptionItem<int>(
            value: -1,
            label: l10n.noReminder,
            icon: Icons.notifications_off_outlined,
            isSelected: _reminderMinutesBefore == null,
          ),
          _QuickOptionItem<int>(
            value: 0,
            label: l10n.atTime,
            icon: Icons.notifications_active_outlined,
            isSelected: _reminderMinutesBefore == 0,
          ),
          _QuickOptionItem<int>(
            value: 10,
            label: l10n.minutesBefore10,
            icon: Icons.notifications_outlined,
            isSelected: _reminderMinutesBefore == 10,
          ),
          _QuickOptionItem<int>(
            value: 30,
            label: l10n.minutesBefore30,
            icon: Icons.notifications_outlined,
            isSelected: _reminderMinutesBefore == 30,
          ),
          _QuickOptionItem<int>(
            value: 60,
            label: l10n.hourBefore1,
            icon: Icons.notifications_outlined,
            isSelected: _reminderMinutesBefore == 60,
          ),
        ],
      ),
    );

    if (!mounted || chosen == null) return;
    if (chosen == -1) {
      setState(() => _reminderMinutesBefore = null);
      return;
    }

    if (widget.onRequestNotificationPermission != null) {
      await widget.onRequestNotificationPermission!.call();
    }
    if (!mounted) return;
    setState(() => _reminderMinutesBefore = chosen);
  }

  Future<void> _pickProject(List<ProjectModel> projects) async {
    final l10n = AppLocalizations.of(context);
    final chosen = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) {
        final brightness = Theme.of(sheetContext).brightness;
        return _QuickOptionSheet<int>(
          title: l10n.projectLabel,
          options: [
            _QuickOptionItem<int>(
              value: -1,
              label: l10n.noProject,
              icon: Icons.folder_off_outlined,
              isSelected: _selectedProjectId == null,
            ),
            for (final project in projects)
              if (project.id != null)
                _QuickOptionItem<int>(
                  value: project.id!,
                  label: project.name,
                  dotColor: AppTheme.resolveTagColor(
                    project.colorHex,
                    brightness,
                  ),
                  isSelected: _selectedProjectId == project.id,
                ),
          ],
        );
      },
    );

    if (!mounted || chosen == null) return;
    setState(() => _selectedProjectId = chosen == -1 ? null : chosen);
  }

  Future<void> _pickTag(List<TagModel> tags) async {
    final l10n = AppLocalizations.of(context);
    final chosen = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) {
        final brightness = Theme.of(sheetContext).brightness;
        return _QuickOptionSheet<int>(
          title: l10n.tagLabel,
          options: [
            _QuickOptionItem<int>(
              value: -1,
              label: l10n.noTag,
              icon: Icons.label_off_outlined,
              isSelected: _selectedTagId == null,
            ),
            for (final tag in tags)
              if (tag.id != null)
                _QuickOptionItem<int>(
                  value: tag.id!,
                  label: '#${tag.name}',
                  dotColor: AppTheme.resolveTagColor(tag.colorHex, brightness),
                  isSelected: _selectedTagId == tag.id,
                ),
          ],
        );
      },
    );

    if (!mounted || chosen == null) return;
    setState(() => _selectedTagId = chosen == -1 ? null : chosen);
  }

  Future<void> _pickPriority() async {
    final l10n = AppLocalizations.of(context);
    final chosen = await showModalBottomSheet<TaskPriority>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) {
        final brightness = Theme.of(sheetContext).brightness;
        return _QuickOptionSheet<TaskPriority>(
          title: l10n.priorityLabel,
          options: [
            for (final p in const [
              TaskPriority.high,
              TaskPriority.medium,
              TaskPriority.low,
            ])
              _QuickOptionItem<TaskPriority>(
                value: p,
                label: _priorityLabel(p, l10n),
                dotColor: AppTheme.priorityColor(p, brightness),
                isSelected: _priority == p,
              ),
          ],
        );
      },
    );

    if (!mounted || chosen == null) return;
    setState(() => _priority = chosen);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = theme.brightness;
    final l10n = AppLocalizations.of(context);
    final localeTag =
        LocaleProvider.intlLocaleTag(Localizations.localeOf(context));
    final workspace = context.watch<WorkspaceProvider>();
    final selectedProject = workspace.findProject(_selectedProjectId);
    final selectedTag = workspace.findTag(_selectedTagId);
    final canSave = _titleController.text.trim().isNotEmpty;
    final priorityColor = AppTheme.priorityColor(_priority, brightness);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      key: const ValueKey('quick_add_title_field'),
                      controller: _titleController,
                      autofocus: true,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.done,
                      onChanged: (_) => setState(() {}),
                      onSubmitted: (_) => _save(),
                      decoration: InputDecoration(
                        hintText: l10n.quickAddHint,
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  IconButton(
                    key: const ValueKey('quick_add_expand_button'),
                    tooltip: l10n.expandTooltip,
                    onPressed: _expand,
                    style: IconButton.styleFrom(
                      minimumSize: const Size(48, 48),
                    ),
                    icon: Icon(
                      Icons.open_in_full_rounded,
                      size: 20,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  FilledButton(
                    key: const ValueKey('quick_add_save_button'),
                    onPressed: canSave ? _save : null,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(48, 48),
                      padding: EdgeInsets.zero,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Tooltip(
                      message: l10n.saveTaskTooltip,
                      child: const Icon(Icons.arrow_upward_rounded, size: 22),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _QuickMetaChip(
                      icon: _selectedDate == null
                          ? Icons.inbox_outlined
                          : Icons.calendar_today_outlined,
                      label: _dateChipLabel(l10n, localeTag),
                      isActive: _selectedDate != null,
                      onTap: _pickDateOption,
                    ),
                    const SizedBox(width: 8),
                    _QuickMetaChip(
                      icon: Icons.schedule_rounded,
                      label: _selectedTime != null
                          ? _formatTimeOfDay(_selectedTime!)
                          : l10n.timeLabel,
                      isActive: _selectedTime != null,
                      onTap: _pickTime,
                    ),
                    const SizedBox(width: 8),
                    _QuickMetaChip(
                      icon: Icons.notifications_none_rounded,
                      label: _reminderChipLabel(l10n),
                      isActive: _reminderMinutesBefore != null,
                      onTap: _pickReminder,
                    ),
                    const SizedBox(width: 8),
                    _QuickMetaChip(
                      icon: Icons.folder_outlined,
                      dotColor: selectedProject != null
                          ? AppTheme.resolveTagColor(
                              selectedProject.colorHex,
                              brightness,
                            )
                          : null,
                      label: selectedProject?.name ?? l10n.projectLabel,
                      isActive: selectedProject != null,
                      onTap: () => _pickProject(workspace.projects),
                    ),
                    const SizedBox(width: 8),
                    _QuickMetaChip(
                      icon: Icons.label_outline_rounded,
                      dotColor: selectedTag != null
                          ? AppTheme.resolveTagColor(
                              selectedTag.colorHex,
                              brightness,
                            )
                          : null,
                      label: selectedTag != null
                          ? '#${selectedTag.name}'
                          : l10n.tagLabel,
                      isActive: selectedTag != null,
                      onTap: () => _pickTag(workspace.tags),
                    ),
                    const SizedBox(width: 8),
                    _QuickMetaChip(
                      dotColor: priorityColor,
                      label: _priorityLabel(_priority, l10n),
                      isActive: _priority != TaskPriority.medium,
                      onTap: _pickPriority,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickMetaChip extends StatelessWidget {
  const _QuickMetaChip({
    this.icon,
    this.dotColor,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData? icon;
  final Color? dotColor;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: isActive ? colorScheme.primaryContainer : colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isActive ? colorScheme.primary : colorScheme.outline,
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (dotColor != null) ...[
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                ] else if (icon != null) ...[
                  Icon(
                    icon,
                    size: 15,
                    color: isActive
                        ? colorScheme.onPrimaryContainer
                        : colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 5),
                ],
                Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontSize: 12.5,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    color: isActive
                        ? colorScheme.onPrimaryContainer
                        : colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickOptionItem<T> {
  const _QuickOptionItem({
    required this.value,
    required this.label,
    this.icon,
    this.dotColor,
    required this.isSelected,
  });

  final T value;
  final String label;
  final IconData? icon;
  final Color? dotColor;
  final bool isSelected;
}

class _QuickOptionSheet<T> extends StatelessWidget {
  const _QuickOptionSheet({
    required this.title,
    required this.options,
  });

  final String title;
  final List<_QuickOptionItem<T>> options;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
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
              padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 8, 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
                    ),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
              child: Column(
                children: [
                  for (final option in options)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Material(
                        color: option.isSelected
                            ? colorScheme.primaryContainer
                            : colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: option.isSelected
                                ? colorScheme.primary
                                : colorScheme.outline,
                            width: 1,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(option.value),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 48),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  if (option.dotColor != null) ...[
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: option.dotColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                  ] else if (option.icon != null) ...[
                                    Icon(
                                      option.icon,
                                      size: 18,
                                      color: option.isSelected
                                          ? colorScheme.primary
                                          : colorScheme.onSurfaceVariant,
                                    ),
                                    const SizedBox(width: 12),
                                  ],
                                  Expanded(
                                    child: Text(
                                      option.label,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(fontSize: 14.5),
                                    ),
                                  ),
                                  if (option.isSelected)
                                    Icon(
                                      Icons.check_rounded,
                                      size: 18,
                                      color: colorScheme.primary,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
