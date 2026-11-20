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
import '../providers/task_provider.dart';
import '../providers/workspace_provider.dart';
import '../widgets/task_editor_sheet.dart';

class TemplatesScreen extends StatelessWidget {
  const TemplatesScreen({super.key});

  Future<void> _openTemplateEditor(
    BuildContext context, {
    TaskTemplateModel? template,
  }) async {
    final workspaceProvider = context.read<WorkspaceProvider>();
    final result = await _TemplateEditorSheet.show(
      context,
      initialTemplate: template,
      projects: workspaceProvider.projects,
      tags: workspaceProvider.tags,
    );
    if (!context.mounted || result == null) return;

    if (template == null) {
      await workspaceProvider.addTemplate(result);
    } else {
      await workspaceProvider.updateTemplate(result);
    }
  }

  Future<void> _useTemplate(
    BuildContext context,
    TaskTemplateModel template,
  ) async {
    final taskProvider = context.read<TaskProvider>();
    final result = await TaskEditorSheet.show(
      context,
      initialTemplate: template,
      defaultDate: taskProvider.currentToday,
      onRequestNotificationPermission:
          taskProvider.requestNotificationPermission,
    );

    if (!context.mounted || result == null) return;
    if (result is TaskEditorSaved) {
      final task = result.task;
      if (result.repeatConfig != null && task.date != null) {
        await taskProvider.addRepeatingTask(
          RepeatingTaskRule(
            title: task.title,
            description: task.description,
            startTime: task.startTime,
            priority: task.priority,
            colorHex: task.colorHex,
            checklistItems: task.checklistItems
                .map((i) => ChecklistItem(title: i.title, isDone: false))
                .toList(),
            reminderMinutesBefore: task.reminderMinutesBefore,
            frequency: result.repeatConfig!.frequency,
            weekdays: result.repeatConfig!.weekdays,
            startDate: task.date!,
            projectId: task.projectId,
            tagId: task.tagId,
          ),
        );
      } else {
        await taskProvider.addTask(task);
      }

      if (context.mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(l10n.taskFromTemplateSaved)),
          );
      }
    }
  }

  Future<void> _deleteTemplate(
    BuildContext context,
    TaskTemplateModel template,
  ) async {
    final id = template.id;
    if (id == null) return;
    await context.read<WorkspaceProvider>().deleteTemplate(id);
    if (!context.mounted) return;
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(l10n.templateDeletedNamed(template.name))),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Consumer<WorkspaceProvider>(
      builder: (context, workspaceProvider, _) {
        final templates = workspaceProvider.templates;

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.templatesTitle),
          ),
          body: SafeArea(
            child: templates.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: colorScheme.outline,
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.content_copy_outlined,
                              size: 26,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            l10n.noTemplatesYet,
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.noTemplatesSubtitle,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
                    itemCount: templates.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final template = templates[index];
                      final tag = workspaceProvider.findTag(template.tagId);
                      final project =
                          workspaceProvider.findProject(template.projectId);
                      final accentColor = AppTheme.resolveTagColor(
                        template.colorHex,
                        theme.brightness,
                      );

                      return Material(
                        color: colorScheme.surface,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(color: colorScheme.outline, width: 1),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            14,
                            12,
                            8,
                            12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: accentColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      template.name,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(fontSize: 15.5),
                                    ),
                                  ),
                                  PopupMenuButton<String>(
                                    tooltip: l10n.templateOptionsTooltip,
                                    onSelected: (value) {
                                      if (value == 'edit') {
                                        _openTemplateEditor(
                                          context,
                                          template: template,
                                        );
                                      } else if (value == 'delete') {
                                        _deleteTemplate(context, template);
                                      }
                                    },
                                    itemBuilder: (_) => [
                                      PopupMenuItem(
                                        value: 'edit',
                                        child: Text(l10n.editTemplate),
                                      ),
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: Text(l10n.deleteTemplate),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 6),
                                child: Text(
                                  template.title,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 4,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  if (template.hasStartTime)
                                    Text(
                                      template.startTime!,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  Text(
                                    localizedPriorityLabel(
                                      l10n,
                                      template.priority,
                                    ),
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  if (template.checklistItems.isNotEmpty)
                                    Text(
                                      l10n.subtasksTotalCount(
                                        template.checklistItems.length,
                                      ),
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  if (project != null)
                                    Text(
                                      project.name,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  if (tag != null)
                                    Text(
                                      '#${tag.name}',
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        color: AppTheme.resolveTagColor(
                                          tag.colorHex,
                                          theme.brightness,
                                        ),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 6),
                                child: Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: FilledButton.tonal(
                                    onPressed: () =>
                                        _useTemplate(context, template),
                                    style: FilledButton.styleFrom(
                                      minimumSize: const Size(104, 48),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(l10n.useAction),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'templates_fab',
            onPressed: () => _openTemplateEditor(context),
            tooltip: l10n.createTemplateTooltip,
            child: const Icon(Icons.add_rounded),
          ),
        );
      },
    );
  }
}

class _TemplateEditorSheet extends StatefulWidget {
  const _TemplateEditorSheet({
    this.initialTemplate,
    required this.projects,
    required this.tags,
  });

  final TaskTemplateModel? initialTemplate;
  final List<ProjectModel> projects;
  final List<TagModel> tags;

  static Future<TaskTemplateModel?> show(
    BuildContext context, {
    TaskTemplateModel? initialTemplate,
    required List<ProjectModel> projects,
    required List<TagModel> tags,
  }) {
    return showModalBottomSheet<TaskTemplateModel>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _TemplateEditorSheet(
        initialTemplate: initialTemplate,
        projects: projects,
        tags: tags,
      ),
    );
  }

  @override
  State<_TemplateEditorSheet> createState() => _TemplateEditorSheetState();
}

class _TemplateEditorSheetState extends State<_TemplateEditorSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _checklistController;

  TimeOfDay? _startTime;
  late TaskPriority _priority;
  late String _colorHex;
  int? _projectId;
  int? _tagId;
  late List<ChecklistItem> _checklistItems;

  bool get _isEditing => widget.initialTemplate != null;

  @override
  void initState() {
    super.initState();
    final t = widget.initialTemplate;
    _nameController = TextEditingController(text: t?.name ?? '');
    _titleController = TextEditingController(text: t?.title ?? '');
    _descriptionController = TextEditingController(text: t?.description ?? '');
    _checklistController = TextEditingController();
    _startTime = _parseTime(t?.startTime);
    _priority = t?.priority ?? TaskPriority.medium;
    _colorHex = t?.colorHex ?? AppTheme.tagPalette.first.hex;
    _projectId = t?.projectId;
    _tagId = t?.tagId;
    _checklistItems = List<ChecklistItem>.from(t?.checklistItems ?? const []);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _checklistController.dispose();
    super.dispose();
  }

  static TimeOfDay? _parseTime(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    final parts = raw.trim().split(':');
    if (parts.length != 2) return null;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null) return null;
    return TimeOfDay(hour: h, minute: m);
  }

  static String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void _addChecklist() {
    final text = _checklistController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _checklistItems.add(ChecklistItem(title: text));
      _checklistController.clear();
    });
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child ?? const SizedBox.shrink(),
      ),
    );
    if (picked != null && mounted) {
      setState(() => _startTime = picked);
    }
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final pending = _checklistController.text.trim();
    final items = [
      ..._checklistItems,
      if (pending.isNotEmpty) ChecklistItem(title: pending),
    ];

    Navigator.of(context).pop(
      TaskTemplateModel(
        id: widget.initialTemplate?.id,
        name: _nameController.text.trim(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        startTime: _startTime != null ? _formatTime(_startTime!) : null,
        priority: _priority,
        colorHex: _colorHex,
        checklistItems: items,
        projectId: _projectId,
        tagId: _tagId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final maxHeight =
        (screenHeight - viewInsets.bottom).clamp(260.0, screenHeight * 0.9);

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
                      _isEditing ? l10n.editTemplate : l10n.newTemplate,
                      style: theme.textTheme.titleLarge?.copyWith(fontSize: 19),
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
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        autofocus: !_isEditing,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: l10n.templateNameLabel,
                          hintText: l10n.templateNameHint,
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? l10n.templateNameRequired
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _titleController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: l10n.defaultTaskTitleLabel,
                          hintText: l10n.defaultTaskTitleHint,
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? l10n.taskTitleRequired
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _descriptionController,
                        minLines: 2,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: l10n.descriptionLabel,
                          alignLabelWithHint: true,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _pickTime,
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size.fromHeight(48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: const Icon(Icons.schedule_rounded, size: 16),
                              label: Text(
                                _startTime != null
                                    ? _formatTime(_startTime!)
                                    : l10n.timeOptionalLabel,
                              ),
                            ),
                          ),
                          if (_startTime != null) ...[
                            const SizedBox(width: 8),
                            IconButton(
                              tooltip: l10n.clearTimeTooltip,
                              onPressed: () => setState(() => _startTime = null),
                              style: IconButton.styleFrom(
                                minimumSize: const Size(48, 48),
                              ),
                              icon: const Icon(Icons.close_rounded),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 8,
                        children: TaskPriority.values.map((priority) {
                          return ChoiceChip(
                            label: Text(localizedPriorityLabel(l10n, priority)),
                            selected: _priority == priority,
                            showCheckmark: false,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            onSelected: (_) =>
                                setState(() => _priority = priority),
                          );
                        }).toList(),
                      ),
                      if (widget.projects.isNotEmpty) ...[
                        const SizedBox(height: 14),
                        Text(
                          l10n.projectOptionalLabel,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: widget.projects.map((project) {
                            final selected = _projectId == project.id;
                            return ChoiceChip(
                              label: Text(project.name),
                              selected: selected,
                              showCheckmark: false,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              onSelected: (_) => setState(
                                () => _projectId = selected ? null : project.id,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                      if (widget.tags.isNotEmpty) ...[
                        const SizedBox(height: 14),
                        Text(
                          l10n.tagOptionalLabel,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: widget.tags.map((tag) {
                            final selected = _tagId == tag.id;
                            return ChoiceChip(
                              label: Text(tag.name),
                              selected: selected,
                              showCheckmark: false,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              onSelected: (_) => setState(
                                () => _tagId = selected ? null : tag.id,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                      const SizedBox(height: 14),
                      Text(
                        l10n.defaultSubtasksLabel,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (_checklistItems.isNotEmpty) ...[
                        for (var i = 0; i < _checklistItems.length; i++)
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(_checklistItems[i].title),
                            trailing: IconButton(
                              tooltip: l10n.removeSubtaskTooltip,
                              onPressed: () =>
                                  setState(() => _checklistItems.removeAt(i)),
                              icon: const Icon(Icons.close_rounded, size: 18),
                            ),
                          ),
                      ],
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _checklistController,
                              onSubmitted: (_) => _addChecklist(),
                              decoration: InputDecoration(
                                hintText: l10n.addTemplateSubtaskHint,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton.filledTonal(
                            tooltip: l10n.addSubtaskTooltip,
                            onPressed: _addChecklist,
                            style: IconButton.styleFrom(
                              minimumSize: const Size(48, 48),
                            ),
                            icon: const Icon(Icons.add_rounded),
                          ),
                        ],
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
                ),
                child: Text(_isEditing ? l10n.saveChanges : l10n.saveTemplate),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
