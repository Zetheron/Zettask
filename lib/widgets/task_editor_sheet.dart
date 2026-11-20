import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n_helpers.dart';
import '../models/project_model.dart';
import '../models/repeating_task_model.dart';
import '../models/tag_model.dart';
import '../models/task_model.dart';
import '../models/task_template_model.dart';
import '../providers/locale_provider.dart';
import '../providers/task_provider.dart';
import '../providers/workspace_provider.dart';

sealed class TaskEditorResult {
  const TaskEditorResult();
}

final class TaskEditorSaved extends TaskEditorResult {
  const TaskEditorSaved(
    this.task, {
    this.repeatConfig,
  });

  final TaskModel task;
  final RepeatConfig? repeatConfig;
}

final class TaskEditorDeleted extends TaskEditorResult {
  const TaskEditorDeleted(this.task);

  final TaskModel task;
}

class TaskEditorSheet extends StatefulWidget {
  const TaskEditorSheet({
    super.key,
    this.initialTask,
    this.initialRepeatingRule,
    this.initialTemplate,
    this.defaultDate,
    this.defaultProjectId,
    this.defaultTagId,
    this.allowRepeatPicker = true,
    this.requireRepeat = false,
    this.onRequestNotificationPermission,
  });

  final TaskModel? initialTask;
  final RepeatingTaskRule? initialRepeatingRule;
  final TaskTemplateModel? initialTemplate;
  final DateTime? defaultDate;
  final int? defaultProjectId;
  final int? defaultTagId;
  final bool allowRepeatPicker;
  final bool requireRepeat;
  final Future<bool> Function()? onRequestNotificationPermission;

  static Future<TaskEditorResult?> show(
    BuildContext context, {
    TaskModel? initialTask,
    RepeatingTaskRule? initialRepeatingRule,
    TaskTemplateModel? initialTemplate,
    DateTime? defaultDate,
    int? defaultProjectId,
    int? defaultTagId,
    bool allowRepeatPicker = true,
    bool requireRepeat = false,
    Future<bool> Function()? onRequestNotificationPermission,
  }) {
    return showModalBottomSheet<TaskEditorResult>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) => TaskEditorSheet(
        initialTask: initialTask,
        initialRepeatingRule: initialRepeatingRule,
        initialTemplate: initialTemplate,
        defaultDate: defaultDate,
        defaultProjectId: defaultProjectId,
        defaultTagId: defaultTagId,
        allowRepeatPicker: allowRepeatPicker,
        requireRepeat: requireRepeat,
        onRequestNotificationPermission: onRequestNotificationPermission,
      ),
    );
  }

  @override
  State<TaskEditorSheet> createState() => _TaskEditorSheetState();
}

class _TaskEditorSheetState extends State<TaskEditorSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _checklistInputController;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int? _reminderMinutesBefore;
  bool _permissionRequested = false;
  bool _permissionDenied = false;
  RepeatFrequency? _repeatFrequency;
  late Set<int> _selectedWeekdays;
  late TaskPriority _priority;
  late String _colorHex;
  int? _selectedProjectId;
  int? _selectedTagId;
  late List<ChecklistItem> _checklistItems;

  bool get _isEditing =>
      widget.initialTask?.id != null || widget.initialRepeatingRule != null;

  @override
  void initState() {
    super.initState();
    final task = widget.initialTask;
    final rule = widget.initialRepeatingRule;
    final template = widget.initialTemplate;

    _titleController = TextEditingController(
      text: task?.title ?? rule?.title ?? template?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text:
          task?.description ?? rule?.description ?? template?.description ?? '',
    );
    _checklistInputController = TextEditingController();

    final initialDate = task != null
        ? task.date
        : (rule?.startDate ?? widget.defaultDate);
    _selectedDate =
        initialDate != null ? TaskProvider.normalizeDate(initialDate) : null;
    if (widget.requireRepeat && _selectedDate == null) {
      _selectedDate = TaskProvider.normalizeDate(DateTime.now());
    }

    final initialStartTime =
        task?.startTime ?? rule?.startTime ?? template?.startTime;
    _selectedTime =
        _selectedDate != null ? _parseTimeOfDay(initialStartTime) : null;
    final initialReminder =
        task?.reminderMinutesBefore ?? rule?.reminderMinutesBefore;
    _reminderMinutesBefore = _selectedTime != null ? initialReminder : null;

    if (rule != null) {
      _repeatFrequency = rule.frequency;
      _selectedWeekdays = Set<int>.from(rule.effectiveWeekdays);
    } else if (widget.requireRepeat) {
      _repeatFrequency = RepeatFrequency.daily;
      _selectedWeekdays = {(_selectedDate ?? DateTime.now()).weekday};
    } else {
      _repeatFrequency = null;
      _selectedWeekdays = {(_selectedDate ?? DateTime.now()).weekday};
    }

    _priority = task?.priority ??
        rule?.priority ??
        template?.priority ??
        TaskPriority.medium;
    _colorHex = task?.colorHex ??
        rule?.colorHex ??
        template?.colorHex ??
        AppTheme.tagPalette.first.hex;
    _selectedProjectId = task?.projectId ??
        rule?.projectId ??
        template?.projectId ??
        widget.defaultProjectId;
    _selectedTagId = task?.tagId ??
        rule?.tagId ??
        template?.tagId ??
        widget.defaultTagId;
    _checklistItems = List<ChecklistItem>.from(
      task?.checklistItems ??
          rule?.checklistItems ??
          template?.checklistItems
              .map((item) => ChecklistItem(title: item.title, isDone: false))
              .toList() ??
          const [],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _checklistInputController.dispose();
    super.dispose();
  }

  static TimeOfDay? _parseTimeOfDay(String? rawTime) {
    if (rawTime == null || rawTime.trim().isEmpty) return null;
    final parts = rawTime.trim().split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null ||
        minute == null ||
        hour < 0 ||
        hour > 23 ||
        minute < 0 ||
        minute > 59) {
      return null;
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  static String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _formatDateLabel(DateTime date, String intlLocale) {
    try {
      return DateFormat('EEE, d MMM yyyy', intlLocale).format(date);
    } catch (_) {
      return DateFormat('EEE, d MMM yyyy').format(date);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && mounted) {
      setState(() {
        _selectedDate = TaskProvider.normalizeDate(picked);
        if (_selectedWeekdays.isEmpty) {
          _selectedWeekdays = {_selectedDate!.weekday};
        }
      });
    }
  }

  void _clearDate() {
    if (widget.requireRepeat) return;
    setState(() {
      _selectedDate = null;
      _selectedTime = null;
      _reminderMinutesBefore = null;
      _repeatFrequency = null;
      _permissionDenied = false;
    });
  }

  Future<void> _pickTime() async {
    if (_selectedDate == null) return;
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (picked != null && mounted) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _clearTime() {
    setState(() {
      _selectedTime = null;
      _reminderMinutesBefore = null;
      _permissionDenied = false;
    });
  }

  Future<void> _selectReminder(int? minutes) async {
    setState(() {
      _reminderMinutesBefore = minutes;
      if (minutes == null) {
        _permissionDenied = false;
      }
    });

    if (minutes != null &&
        !_permissionRequested &&
        widget.onRequestNotificationPermission != null) {
      _permissionRequested = true;
      final granted = await widget.onRequestNotificationPermission!();
      if (mounted) {
        setState(() {
          _permissionDenied = !granted;
        });
      }
    }
  }

  void _selectRepeatFrequency(RepeatFrequency? frequency) {
    setState(() {
      _repeatFrequency = frequency;
      if (frequency == RepeatFrequency.weekly && _selectedWeekdays.isEmpty) {
        _selectedWeekdays = {(_selectedDate ?? DateTime.now()).weekday};
      }
    });
  }

  void _toggleWeekday(int weekday) {
    setState(() {
      if (_selectedWeekdays.contains(weekday)) {
        if (_selectedWeekdays.length > 1) {
          _selectedWeekdays.remove(weekday);
        }
      } else {
        _selectedWeekdays.add(weekday);
      }
    });
  }

  void _addChecklistItem() {
    final text = _checklistInputController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _checklistItems.add(ChecklistItem(title: text));
      _checklistInputController.clear();
    });
  }

  void _toggleChecklistItem(int index) {
    setState(() {
      final current = _checklistItems[index];
      _checklistItems[index] = current.copyWith(isDone: !current.isDone);
    });
  }

  void _removeChecklistItem(int index) {
    setState(() {
      _checklistItems.removeAt(index);
    });
  }

  void _applyTemplate(TaskTemplateModel template) {
    setState(() {
      _titleController.text = template.title;
      _descriptionController.text = template.description;
      if (_selectedDate != null) {
        _selectedTime = _parseTimeOfDay(template.startTime);
      }
      _priority = template.priority;
      _colorHex = template.colorHex;
      _selectedProjectId = template.projectId ?? _selectedProjectId;
      _selectedTagId = template.tagId ?? _selectedTagId;
      _checklistItems = template.checklistItems
          .map((item) => ChecklistItem(title: item.title, isDone: false))
          .toList();
    });
  }

  Future<void> _pickTemplate(List<TaskTemplateModel> templates) async {
    final chosen = await showModalBottomSheet<TaskTemplateModel>(
      context: context,
      useSafeArea: true,
      builder: (sheetContext) {
        final theme = Theme.of(sheetContext);
        final colorScheme = theme.colorScheme;
        final sheetL10n = AppLocalizations.of(sheetContext);
        return SafeArea(
          top: false,
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
                        sheetL10n.pickTemplateTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: sheetL10n.close,
                      onPressed: () => Navigator.of(sheetContext).pop(),
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
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                  itemCount: templates.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (_, index) {
                    final template = templates[index];
                    final dotColor = AppTheme.resolveTagColor(
                      template.colorHex,
                      theme.brightness,
                    );
                    return Material(
                      color: colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: colorScheme.outline, width: 1),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () => Navigator.of(sheetContext).pop(template),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: dotColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      template.name,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(fontSize: 14.5),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      template.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
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

    if (chosen != null && mounted) {
      _applyTemplate(chosen);
    }
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final pendingChecklistText = _checklistInputController.text.trim();
    final finalChecklist = [
      ..._checklistItems,
      if (pendingChecklistText.isNotEmpty)
        ChecklistItem(title: pendingChecklistText),
    ];

    final existing = widget.initialTask;
    final formattedTime = (_selectedDate != null && _selectedTime != null)
        ? _formatTimeOfDay(_selectedTime!)
        : null;

    final task = TaskModel(
      id: existing?.id,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      date: _selectedDate,
      startTime: formattedTime,
      isCompleted: existing?.isCompleted ?? false,
      isCancelled: existing?.isCancelled ?? false,
      priority: _priority,
      colorHex: _colorHex,
      checklistItems: finalChecklist,
      reminderMinutesBefore:
          formattedTime != null ? _reminderMinutesBefore : null,
      repeatingRuleId:
          existing?.repeatingRuleId ?? widget.initialRepeatingRule?.id,
      projectId: _selectedProjectId,
      tagId: _selectedTagId,
      completedAt: existing?.completedAt,
    );

    final RepeatConfig? repeatConfig =
        (widget.allowRepeatPicker && _selectedDate != null && _repeatFrequency != null)
            ? RepeatConfig(
                frequency: _repeatFrequency!,
                weekdays: _repeatFrequency == RepeatFrequency.weekly
                    ? (_selectedWeekdays.toList()..sort())
                    : const [],
              )
            : null;

    Navigator.of(context).pop(
      TaskEditorSaved(task, repeatConfig: repeatConfig),
    );
  }

  void _delete() {
    final existing = widget.initialTask ??
        (widget.initialRepeatingRule != null
            ? TaskModel(
                id: widget.initialRepeatingRule!.id,
                title: widget.initialRepeatingRule!.title,
                date: widget.initialRepeatingRule!.startDate,
                repeatingRuleId: widget.initialRepeatingRule!.id,
              )
            : null);
    if (existing == null) return;
    Navigator.of(context).pop(TaskEditorDeleted(existing));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final intlLocale =
        LocaleProvider.intlLocaleTag(Localizations.localeOf(context));
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final availableHeight = screenHeight - viewInsets.bottom;
    final maxHeight = availableHeight.clamp(240.0, screenHeight * 0.9);

    final sheetTitle = widget.requireRepeat
        ? (_isEditing ? l10n.editRepeatingTask : l10n.newRepeatingTask)
        : (_isEditing ? l10n.editTask : l10n.newTask);

    WorkspaceProvider? workspaceProvider;
    try {
      workspaceProvider = context.watch<WorkspaceProvider>();
    } catch (_) {
      workspaceProvider = null;
    }
    final projects = workspaceProvider?.projects ?? const <ProjectModel>[];
    final tags = workspaceProvider?.tags ?? const <TagModel>[];
    final templates = workspaceProvider?.templates ?? const <TaskTemplateModel>[];

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
              padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 8, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      sheetTitle,
                      style: theme.textTheme.titleLarge?.copyWith(fontSize: 19),
                    ),
                  ),
                  if (_isEditing)
                    IconButton(
                      tooltip: l10n.deleteTaskTooltip,
                      onPressed: _delete,
                      style: IconButton.styleFrom(
                        minimumSize: const Size(48, 48),
                        foregroundColor: colorScheme.error,
                      ),
                      icon: const Icon(Icons.delete_outline_rounded),
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
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!_isEditing && templates.isNotEmpty) ...[
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: OutlinedButton.icon(
                            onPressed: () => _pickTemplate(templates),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(48, 44),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: const Icon(
                              Icons.content_copy_outlined,
                              size: 16,
                            ),
                            label: Text(l10n.useTemplateButton),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      TextFormField(
                        controller: _titleController,
                        autofocus: !_isEditing,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: l10n.taskTitleLabel,
                          hintText: l10n.taskTitleHint,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.taskTitleRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _descriptionController,
                        textCapitalization: TextCapitalization.sentences,
                        minLines: 2,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: l10n.descriptionLabel,
                          hintText: l10n.descriptionHint,
                          alignLabelWithHint: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _SectionLabel(
                        label: widget.requireRepeat
                            ? l10n.startAndTimeLabel
                            : l10n.scheduleLabel,
                      ),
                      const SizedBox(height: 8),
                      _DateTimePickerRow(
                        dateLabel: _selectedDate != null
                            ? _formatDateLabel(_selectedDate!, intlLocale)
                            : l10n.noDate,
                        hasDate: _selectedDate != null,
                        allowClearDate: !widget.requireRepeat,
                        timeLabel: _selectedDate == null
                            ? l10n.dateRequiredForTime
                            : (_selectedTime != null
                                ? _formatTimeOfDay(_selectedTime!)
                                : l10n.allDay),
                        hasTime: _selectedDate != null && _selectedTime != null,
                        onPickDate: _pickDate,
                        onClearDate: _clearDate,
                        onPickTime: _pickTime,
                        onClearTime: _clearTime,
                      ),
                      const SizedBox(height: 16),
                      _SectionLabel(label: l10n.reminderLabel),
                      const SizedBox(height: 8),
                      _ReminderSelector(
                        enabled: _selectedDate != null && _selectedTime != null,
                        selectedMinutes: _reminderMinutesBefore,
                        permissionDenied: _permissionDenied,
                        onSelected: _selectReminder,
                      ),
                      if (widget.allowRepeatPicker) ...[
                        const SizedBox(height: 16),
                        _SectionLabel(label: l10n.repeatLabel),
                        const SizedBox(height: 8),
                        _RepeatSelector(
                          enabled: _selectedDate != null,
                          allowNone: !widget.requireRepeat,
                          selectedFrequency: _repeatFrequency,
                          selectedWeekdays: _selectedWeekdays,
                          onSelectFrequency: _selectRepeatFrequency,
                          onToggleWeekday: _toggleWeekday,
                        ),
                      ],
                      const SizedBox(height: 16),
                      _SectionLabel(label: l10n.priorityLabel),
                      const SizedBox(height: 8),
                      _PrioritySelector(
                        selected: _priority,
                        onChanged: (value) => setState(() => _priority = value),
                      ),
                      if (projects.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        _SectionLabel(label: l10n.projectLabel),
                        const SizedBox(height: 8),
                        _ProjectSelector(
                          projects: projects,
                          selectedProjectId: _selectedProjectId,
                          onChanged: (id) =>
                              setState(() => _selectedProjectId = id),
                        ),
                      ],
                      if (tags.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        _SectionLabel(label: l10n.tagLabel),
                        const SizedBox(height: 8),
                        _TagSelector(
                          tags: tags,
                          selectedTagId: _selectedTagId,
                          onChanged: (id) =>
                              setState(() => _selectedTagId = id),
                        ),
                      ],
                      const SizedBox(height: 16),
                      _SectionLabel(label: l10n.tagColorLabel),
                      const SizedBox(height: 8),
                      _TagColorSelector(
                        selectedHex: _colorHex,
                        onChanged: (hex) => setState(() => _colorHex = hex),
                      ),
                      const SizedBox(height: 16),
                      _SectionLabel(
                        label: _checklistItems.isEmpty
                            ? l10n.subtasksLabel
                            : l10n.subtasksWithCount(_checklistItems.length),
                      ),
                      const SizedBox(height: 8),
                      _ChecklistBuilder(
                        items: _checklistItems,
                        controller: _checklistInputController,
                        accentColor: AppTheme.resolveTagColor(
                          _colorHex,
                          theme.brightness,
                        ),
                        onAdd: _addChecklistItem,
                        onToggle: _toggleChecklistItem,
                        onRemove: _removeChecklistItem,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: FilledButton(
                onPressed: _submit,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: Text(_isEditing ? l10n.saveChanges : l10n.saveTask),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      label,
      style: theme.textTheme.labelMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        fontSize: 12.5,
      ),
    );
  }
}

class _DateTimePickerRow extends StatelessWidget {
  const _DateTimePickerRow({
    required this.dateLabel,
    required this.hasDate,
    required this.allowClearDate,
    required this.timeLabel,
    required this.hasTime,
    required this.onPickDate,
    required this.onClearDate,
    required this.onPickTime,
    required this.onClearTime,
  });

  final String dateLabel;
  final bool hasDate;
  final bool allowClearDate;
  final String timeLabel;
  final bool hasTime;
  final VoidCallback onPickDate;
  final VoidCallback onClearDate;
  final VoidCallback onPickTime;
  final VoidCallback onClearTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: Material(
            color: colorScheme.surfaceContainerHighest,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: colorScheme.outline, width: 1),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onPickDate,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 48),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                          12,
                          0,
                          (hasDate && allowClearDate) ? 4 : 12,
                          0,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 16,
                              color: hasDate
                                  ? colorScheme.primary
                                  : colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                dateLabel,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 13.5,
                                  fontWeight: hasDate
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: hasDate
                                      ? colorScheme.onSurface
                                      : colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (hasDate && allowClearDate)
                  IconButton(
                    tooltip: l10n.clearDateTooltip,
                    onPressed: onClearDate,
                    style: IconButton.styleFrom(
                      minimumSize: const Size(48, 48),
                      padding: EdgeInsets.zero,
                    ),
                    icon: Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Material(
            color: hasDate
                ? colorScheme.surfaceContainerHighest
                : colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: colorScheme.outline, width: 1),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: hasDate ? onPickTime : null,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 48),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                          12,
                          0,
                          hasTime ? 4 : 12,
                          0,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 16,
                              color: !hasDate
                                  ? colorScheme.onSurfaceVariant
                                      .withValues(alpha: 0.45)
                                  : hasTime
                                      ? colorScheme.primary
                                      : colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                timeLabel,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 13.5,
                                  fontWeight: hasTime
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: !hasDate
                                      ? colorScheme.onSurfaceVariant
                                          .withValues(alpha: 0.5)
                                      : hasTime
                                          ? colorScheme.onSurface
                                          : colorScheme.onSurfaceVariant,
                                  fontFeatures: const [
                                    FontFeature.tabularFigures(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (hasTime)
                  IconButton(
                    tooltip: l10n.clearTimeTooltip,
                    onPressed: onClearTime,
                    style: IconButton.styleFrom(
                      minimumSize: const Size(48, 48),
                      padding: EdgeInsets.zero,
                    ),
                    icon: Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ReminderOption {
  const _ReminderOption({
    required this.minutesBefore,
    required this.label,
  });

  final int? minutesBefore;
  final String label;
}

class _ReminderSelector extends StatelessWidget {
  const _ReminderSelector({
    required this.enabled,
    required this.selectedMinutes,
    required this.permissionDenied,
    required this.onSelected,
  });

  final bool enabled;
  final int? selectedMinutes;
  final bool permissionDenied;
  final ValueChanged<int?> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final options = <_ReminderOption>[
      _ReminderOption(minutesBefore: null, label: l10n.noReminder),
      _ReminderOption(minutesBefore: 0, label: l10n.atTime),
      _ReminderOption(minutesBefore: 10, label: l10n.reminderShort10m),
      _ReminderOption(minutesBefore: 30, label: l10n.reminderShort30m),
      _ReminderOption(minutesBefore: 60, label: l10n.reminderShort1h),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: options.map((option) {
            final isSelected =
                enabled && selectedMinutes == option.minutesBefore;
            return ChoiceChip(
              label: Text(option.label),
              selected: isSelected,
              showCheckmark: false,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              onSelected:
                  enabled ? (_) => onSelected(option.minutesBefore) : null,
            );
          }).toList(),
        ),
        if (!enabled) ...[
          const SizedBox(height: 2),
          Text(
            l10n.pickTimeFirstReminder,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ] else if (permissionDenied) ...[
          const SizedBox(height: 4),
          Text(
            l10n.notificationPermissionDenied,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
}

class _RepeatSelector extends StatelessWidget {
  const _RepeatSelector({
    required this.enabled,
    required this.allowNone,
    required this.selectedFrequency,
    required this.selectedWeekdays,
    required this.onSelectFrequency,
    required this.onToggleWeekday,
  });

  final bool enabled;
  final bool allowNone;
  final RepeatFrequency? selectedFrequency;
  final Set<int> selectedWeekdays;
  final ValueChanged<RepeatFrequency?> onSelectFrequency;
  final ValueChanged<int> onToggleWeekday;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final intlLocale =
        LocaleProvider.intlLocaleTag(Localizations.localeOf(context));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            if (allowNone)
              ChoiceChip(
                label: Text(l10n.noRepeat),
                selected: enabled && selectedFrequency == null,
                showCheckmark: false,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                onSelected: enabled ? (_) => onSelectFrequency(null) : null,
              ),
            ...RepeatFrequency.values.map((frequency) {
              final isSelected = enabled && selectedFrequency == frequency;
              return ChoiceChip(
                label: Text(localizedRepeatFrequencyLabel(l10n, frequency)),
                selected: isSelected,
                showCheckmark: false,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                onSelected:
                    enabled ? (_) => onSelectFrequency(frequency) : null,
              );
            }),
          ],
        ),
        if (!enabled) ...[
          const SizedBox(height: 2),
          Text(
            l10n.pickDateFirstRepeat,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ] else if (selectedFrequency == RepeatFrequency.weekly) ...[
          const SizedBox(height: 10),
          Row(
            children: List.generate(7, (index) {
              final day = index + 1;
              final isPicked = selectedWeekdays.contains(day);
              final label = localizedWeekdayShort(intlLocale, day);

              return Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: index < 6 ? 6 : 0),
                  child: Material(
                    color: isPicked
                        ? colorScheme.primary
                        : colorScheme.surfaceContainerHighest,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color:
                            isPicked ? colorScheme.primary : colorScheme.outline,
                        width: 1,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => onToggleWeekday(day),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 44),
                        child: Center(
                          child: Text(
                            label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: isPicked
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }
}

class _ProjectSelector extends StatelessWidget {
  const _ProjectSelector({
    required this.projects,
    required this.selectedProjectId,
    required this.onChanged,
  });

  final List<ProjectModel> projects;
  final int? selectedProjectId;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final l10n = AppLocalizations.of(context);
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        ChoiceChip(
          label: Text(l10n.noProject),
          selected: selectedProjectId == null,
          showCheckmark: false,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          onSelected: (_) => onChanged(null),
        ),
        ...projects.map((project) {
          final isSelected = project.id != null && selectedProjectId == project.id;
          final color = AppTheme.resolveTagColor(project.colorHex, brightness);
          return ChoiceChip(
            avatar: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            label: Text(project.name),
            selected: isSelected,
            showCheckmark: false,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            onSelected: (_) => onChanged(isSelected ? null : project.id),
          );
        }),
      ],
    );
  }
}

class _TagSelector extends StatelessWidget {
  const _TagSelector({
    required this.tags,
    required this.selectedTagId,
    required this.onChanged,
  });

  final List<TagModel> tags;
  final int? selectedTagId;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final l10n = AppLocalizations.of(context);
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        ChoiceChip(
          label: Text(l10n.noTag),
          selected: selectedTagId == null,
          showCheckmark: false,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          onSelected: (_) => onChanged(null),
        ),
        ...tags.map((tag) {
          final isSelected = tag.id != null && selectedTagId == tag.id;
          final color = AppTheme.resolveTagColor(tag.colorHex, brightness);
          return ChoiceChip(
            avatar: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            label: Text(tag.name),
            selected: isSelected,
            showCheckmark: false,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            onSelected: (_) => onChanged(isSelected ? null : tag.id),
          );
        }),
      ],
    );
  }
}

class _PrioritySelector extends StatelessWidget {
  const _PrioritySelector({
    required this.selected,
    required this.onChanged,
  });

  final TaskPriority selected;
  final ValueChanged<TaskPriority> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Row(
      children: List.generate(TaskPriority.values.length, (index) {
        final priority = TaskPriority.values[index];
        final isSelected = priority == selected;
        final priorityColor = AppTheme.priorityColor(priority, theme.brightness);

        return Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              end: index < TaskPriority.values.length - 1 ? 8 : 0,
            ),
            child: Material(
              color: isSelected
                  ? priorityColor.withValues(alpha: 0.14)
                  : colorScheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected ? priorityColor : colorScheme.outline,
                  width: 1,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => onChanged(priority),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: priorityColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          localizedPriorityLabel(l10n, priority),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: isSelected
                                ? priorityColor
                                : colorScheme.onSurface,
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _TagColorSelector extends StatelessWidget {
  const _TagColorSelector({
    required this.selectedHex,
    required this.onChanged,
  });

  final String selectedHex;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final checkColor =
        brightness == Brightness.dark ? const Color(0xFF0A0A0A) : Colors.white;

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: AppTheme.tagPalette.map((tag) {
        final isSelected = tag.hex.toUpperCase() == selectedHex.toUpperCase();
        final resolvedColor = tag.resolve(brightness);

        return Semantics(
          button: true,
          selected: isSelected,
          label: 'Warna ${tag.label}',
          child: SizedBox(
            width: 48,
            height: 48,
            child: InkWell(
              onTap: () => onChanged(tag.hex),
              customBorder: const CircleBorder(),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 140),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: resolvedColor,
                    border: isSelected
                        ? Border.all(
                            color: Theme.of(context).colorScheme.onSurface,
                            width: 2,
                          )
                        : null,
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check_rounded,
                          size: 16,
                          color: checkColor,
                        )
                      : null,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ChecklistBuilder extends StatelessWidget {
  const _ChecklistBuilder({
    required this.items,
    required this.controller,
    required this.accentColor,
    required this.onAdd,
    required this.onToggle,
    required this.onRemove,
  });

  final List<ChecklistItem> items;
  final TextEditingController controller;
  final Color accentColor;
  final VoidCallback onAdd;
  final ValueChanged<int> onToggle;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final checkColor = theme.brightness == Brightness.dark
        ? const Color(0xFF0A0A0A)
        : Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (items.isNotEmpty) ...[
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.outline, width: 1),
            ),
            child: Column(
              children: List.generate(items.length, (index) {
                final item = items[index];
                return Column(
                  children: [
                    if (index > 0) const Divider(),
                    Row(
                      children: [
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: InkWell(
                            onTap: () => onToggle(index),
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 140),
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: item.isDone
                                      ? accentColor
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: item.isDone
                                        ? accentColor
                                        : colorScheme.onSurfaceVariant,
                                    width: 1.5,
                                  ),
                                ),
                                child: item.isDone
                                    ? Icon(
                                        Icons.check_rounded,
                                        size: 12,
                                        color: checkColor,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => onToggle(index),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                item.title,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                  decoration: item.isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: item.isDone
                                      ? colorScheme.onSurfaceVariant
                                      : colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: AppLocalizations.of(context).removeSubtaskTooltip,
                          onPressed: () => onRemove(index),
                          style: IconButton.styleFrom(
                            minimumSize: const Size(48, 48),
                            foregroundColor: colorScheme.onSurfaceVariant,
                          ),
                          icon: const Icon(Icons.close_rounded, size: 18),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(height: 8),
        ],
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => onAdd(),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).addChecklistHint,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filledTonal(
              tooltip: AppLocalizations.of(context).addSubtaskTooltip,
              onPressed: onAdd,
              style: IconButton.styleFrom(
                minimumSize: const Size(48, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.add_rounded),
            ),
          ],
        ),
      ],
    );
  }
}
