import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../models/tag_model.dart';
import '../models/task_model.dart';
import '../providers/locale_provider.dart';
import '../providers/task_provider.dart';
import '../providers/workspace_provider.dart';
import '../widgets/task_editor_sheet.dart';
import '../widgets/zettask_loaders.dart';

class TagsScreen extends StatelessWidget {
  const TagsScreen({super.key});

  Future<void> _openTagEditor(
    BuildContext context, {
    TagModel? tag,
  }) async {
    final workspaceProvider = context.read<WorkspaceProvider>();
    final result = await _TagEditorSheet.show(context, initialTag: tag);
    if (!context.mounted || result == null) return;

    if (tag == null) {
      await workspaceProvider.addTag(result);
    } else {
      await workspaceProvider.updateTag(result);
    }
  }

  Future<void> _deleteTag(BuildContext context, TagModel tag) async {
    final id = tag.id;
    if (id == null) return;
    final workspaceProvider = context.read<WorkspaceProvider>();
    final taskProvider = context.read<TaskProvider>();

    await workspaceProvider.deleteTag(id);
    await taskProvider.loadTasksForSelectedDate(showLoading: false);

    if (!context.mounted) return;
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(l10n.tagDeletedNamed(tag.name))),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Consumer<WorkspaceProvider>(
      builder: (context, workspaceProvider, _) {
        final tags = workspaceProvider.tags;

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.tagsTitle),
          ),
          body: SafeArea(
            child: tags.isEmpty
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
                              Icons.label_outline_rounded,
                              size: 26,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            l10n.noTagsYet,
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.noTagsSubtitle,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
                    itemCount: tags.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final tag = tags[index];
                      final count = tag.id != null
                          ? workspaceProvider.taskCountForTag(tag.id!)
                          : 0;
                      final tagColor = AppTheme.resolveTagColor(
                        tag.colorHex,
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
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => _TagTasksScreen(tag: tag),
                            ),
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 60),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                14,
                                8,
                                6,
                                8,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: tagColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          tag.name,
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(fontSize: 15),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          l10n.tagTasksCount(count),
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                            fontFeatures: const [
                                              FontFeature.tabularFigures(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuButton<String>(
                                    tooltip: l10n.tagOptionsTooltip,
                                    onSelected: (value) {
                                      if (value == 'edit') {
                                        _openTagEditor(context, tag: tag);
                                      } else if (value == 'delete') {
                                        _deleteTag(context, tag);
                                      }
                                    },
                                    itemBuilder: (_) => [
                                      PopupMenuItem(
                                        value: 'edit',
                                        child: Text(l10n.editTag),
                                      ),
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: Text(l10n.deleteTag),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'tags_fab',
            onPressed: () => _openTagEditor(context),
            tooltip: l10n.addTagTooltip,
            child: const Icon(Icons.add_rounded),
          ),
        );
      },
    );
  }
}

class _TagTasksScreen extends StatefulWidget {
  const _TagTasksScreen({required this.tag});

  final TagModel tag;

  @override
  State<_TagTasksScreen> createState() => _TagTasksScreenState();
}

class _TagTasksScreenState extends State<_TagTasksScreen> {
  List<TaskModel> _tasks = const [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tagId = widget.tag.id;
    if (tagId == null) {
      setState(() => _isLoading = false);
      return;
    }
    final fetched =
        await context.read<WorkspaceProvider>().getTasksByTag(tagId);
    if (!mounted) return;
    setState(() {
      _tasks = fetched;
      _isLoading = false;
    });
  }

  String _formatDateLabel(
    DateTime? date,
    AppLocalizations l10n,
    String intlLocale,
  ) {
    if (date == null) return l10n.unplanned;
    try {
      return DateFormat('d MMM', intlLocale).format(date);
    } catch (_) {
      return DateFormat('d MMM').format(date);
    }
  }

  Future<void> _openEditor({TaskModel? task}) async {
    final taskProvider = context.read<TaskProvider>();
    final workspaceProvider = context.read<WorkspaceProvider>();
    final result = await TaskEditorSheet.show(
      context,
      initialTask: task,
      defaultDate: task == null ? taskProvider.selectedDate : null,
      defaultTagId: widget.tag.id,
      onRequestNotificationPermission:
          taskProvider.requestNotificationPermission,
    );

    if (!mounted || result == null) return;
    if (result is TaskEditorSaved) {
      if (result.task.id == null) {
        await taskProvider.addTask(result.task);
      } else {
        await taskProvider.updateTask(result.task);
      }
      await workspaceProvider.refreshCounts();
      await _loadTasks();
    } else if (result is TaskEditorDeleted && result.task.id != null) {
      await taskProvider.deleteTask(result.task.id!);
      await workspaceProvider.refreshCounts();
      await _loadTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final intlLocale =
        LocaleProvider.intlLocaleTag(Localizations.localeOf(context));
    final tagColor =
        AppTheme.resolveTagColor(widget.tag.colorHex, theme.brightness);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: tagColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Text(widget.tag.name),
          ],
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? const ZettaskTaskListSkeleton()
            : _tasks.isEmpty
                ? Center(
                    child: Text(
                      l10n.noTasksWithTag,
                      style: theme.textTheme.bodySmall,
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
                    itemCount: _tasks.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      final taskColor = AppTheme.resolveTagColor(
                        task.colorHex,
                        theme.brightness,
                      );
                      final checkColor = theme.brightness == Brightness.dark
                          ? const Color(0xFF0A0A0A)
                          : Colors.white;
                      final cancelledFill = theme.brightness == Brightness.dark
                          ? const Color(0xFF52525B)
                          : const Color(0xFF71717A);
                      final cancelledIconColor =
                          theme.brightness == Brightness.dark
                              ? const Color(0xFFFAFAFA)
                              : Colors.white;
                      final isMuted = task.isCompleted || task.isCancelled;

                      return Material(
                        color: task.isCancelled
                            ? colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.65)
                            : task.isCompleted
                                ? colorScheme.surfaceContainerHighest
                                    .withValues(alpha: 0.5)
                                : colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(color: colorScheme.outline, width: 1),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: ListTile(
                          onTap: () => _openEditor(task: task),
                          leading: SizedBox(
                            width: 48,
                            height: 48,
                            child: InkWell(
                              onTap: () async {
                                await context
                                    .read<TaskProvider>()
                                    .toggleTaskComplete(task);
                                await _loadTasks();
                              },
                              onLongPress: () async {
                                HapticFeedback.mediumImpact();
                                final taskProvider =
                                    context.read<TaskProvider>();
                                final nowCancelled = await taskProvider
                                    .toggleTaskCancelled(task);
                                await _loadTasks();
                                if (!context.mounted || !nowCancelled) return;
                                final cancelledSnapshot = task.copyWith(
                                  isCompleted: false,
                                  isCancelled: true,
                                  clearCompletedAt: true,
                                );
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    SnackBar(
                                      content: Text(l10n.taskCancelled),
                                      duration: const Duration(seconds: 4),
                                      action: SnackBarAction(
                                        label: l10n.undo,
                                        onPressed: () async {
                                          await taskProvider
                                              .toggleTaskCancelled(
                                            cancelledSnapshot,
                                          );
                                          if (mounted) await _loadTasks();
                                        },
                                      ),
                                    ),
                                  );
                              },
                              customBorder: const CircleBorder(),
                              child: Center(
                                child: Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: task.isCancelled
                                        ? cancelledFill
                                        : (task.isCompleted
                                            ? taskColor
                                            : Colors.transparent),
                                    border: Border.all(
                                      color: task.isCancelled
                                          ? cancelledFill
                                          : taskColor,
                                      width: 1.75,
                                    ),
                                  ),
                                  child: task.isCancelled
                                      ? Icon(
                                          Icons.close_rounded,
                                          size: 14,
                                          color: cancelledIconColor,
                                        )
                                      : task.isCompleted
                                          ? Icon(
                                              Icons.check_rounded,
                                              size: 14,
                                              color: checkColor,
                                            )
                                          : null,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            task.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontSize: 15,
                              decoration:
                                  isMuted ? TextDecoration.lineThrough : null,
                              color: isMuted
                                  ? colorScheme.onSurfaceVariant
                                      .withValues(alpha: 0.65)
                                  : colorScheme.onSurface,
                            ),
                          ),
                          subtitle: Text(
                            task.hasStartTime
                                ? '${_formatDateLabel(task.date, l10n, intlLocale)} · ${task.startTime}'
                                : _formatDateLabel(task.date, l10n, intlLocale),
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'tag_tasks_fab',
        onPressed: () => _openEditor(),
        tooltip: l10n.addTaskWithTagTooltip,
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}

class _TagEditorSheet extends StatefulWidget {
  const _TagEditorSheet({this.initialTag});

  final TagModel? initialTag;

  static Future<TagModel?> show(
    BuildContext context, {
    TagModel? initialTag,
  }) {
    return showModalBottomSheet<TagModel>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _TagEditorSheet(initialTag: initialTag),
    );
  }

  @override
  State<_TagEditorSheet> createState() => _TagEditorSheetState();
}

class _TagEditorSheetState extends State<_TagEditorSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late String _colorHex;

  bool get _isEditing => widget.initialTag != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialTag?.name ?? '');
    _colorHex = widget.initialTag?.colorHex ?? AppTheme.tagPalette[1].hex;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.of(context).pop(
      TagModel(
        id: widget.initialTag?.id,
        name: _nameController.text.trim(),
        colorHex: _colorHex,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final checkColor = theme.brightness == Brightness.dark
        ? const Color(0xFF0A0A0A)
        : Colors.white;

    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      child: SafeArea(
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
              padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 8, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _isEditing ? l10n.editTag : l10n.newTag,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
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
                        labelText: l10n.tagNameLabel,
                        hintText: l10n.tagNameHint,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.tagNameRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.tagColorLabel,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: AppTheme.tagPalette.map((tag) {
                        final isSelected =
                            tag.hex.toUpperCase() == _colorHex.toUpperCase();
                        final resolved = tag.resolve(theme.brightness);
                        return SizedBox(
                          width: 48,
                          height: 48,
                          child: InkWell(
                            onTap: () => setState(() => _colorHex = tag.hex),
                            customBorder: const CircleBorder(),
                            child: Center(
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: resolved,
                                  border: isSelected
                                      ? Border.all(
                                          color: colorScheme.onSurface,
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
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: _submit,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        _isEditing ? l10n.saveChanges : l10n.createTag,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
