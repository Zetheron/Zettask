import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../models/project_model.dart';
import '../providers/task_provider.dart';
import '../providers/workspace_provider.dart';
import '../widgets/task_editor_sheet.dart';
import '../widgets/task_search_sheet.dart';
import 'project_detail_screen.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  int? _selectedProjectId;
  bool _isSearching = false;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openProjectEditor({ProjectModel? project}) async {
    final workspaceProvider = context.read<WorkspaceProvider>();
    final result = await _ProjectEditorSheet.show(
      context,
      initialProject: project,
    );
    if (!mounted || result == null) return;

    if (project == null) {
      await workspaceProvider.addProject(result);
    } else {
      await workspaceProvider.updateProject(result);
    }
  }

  Future<void> _deleteProject(ProjectModel project) async {
    final id = project.id;
    if (id == null) return;
    final workspaceProvider = context.read<WorkspaceProvider>();
    final taskProvider = context.read<TaskProvider>();

    if (_selectedProjectId == id) {
      setState(() => _selectedProjectId = null);
    }
    await workspaceProvider.deleteProject(id);
    await taskProvider.loadTasksForSelectedDate(showLoading: false);

    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l10n.projectDeleted(project.name)),
        ),
      );
  }

  Future<void> _openTaskSearch() async {
    final taskProvider = context.read<TaskProvider>();
    await TaskSearchSheet.show(
      context,
      onSelectTask: (task) async {
        final result = await TaskEditorSheet.show(
          context,
          initialTask: task,
          onRequestNotificationPermission:
              taskProvider.requestNotificationPermission,
        );
        if (!mounted || result == null) return;
        if (result is TaskEditorSaved) {
          await taskProvider.updateTask(result.task);
        } else if (result is TaskEditorDeleted && result.task.id != null) {
          await taskProvider.deleteTask(result.task.id!);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Consumer<WorkspaceProvider>(
      builder: (context, workspaceProvider, _) {
        final allProjects = workspaceProvider.projects;

        if (_selectedProjectId != null &&
            !allProjects.any((p) => p.id == _selectedProjectId)) {
          _selectedProjectId = null;
        }

        final visibleProjects = allProjects.where((project) {
          final matchesChip =
              _selectedProjectId == null || project.id == _selectedProjectId;
          final matchesSearch = _searchQuery.isEmpty ||
              project.name.toLowerCase().contains(_searchQuery.toLowerCase());
          return matchesChip && matchesSearch;
        }).toList();

        final selectedProject = workspaceProvider.findProject(_selectedProjectId);

        return Scaffold(
          appBar: AppBar(
            title: _isSearching
                ? TextField(
                    controller: _searchController,
                    autofocus: true,
                    onChanged: (value) =>
                        setState(() => _searchQuery = value.trim()),
                    decoration: InputDecoration(
                      hintText: l10n.searchProjectHint,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.zero,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.boardTitle),
                      Text(
                        selectedProject?.name ?? l10n.allProjects,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
            actions: [
              IconButton(
                tooltip: _isSearching
                    ? l10n.closeSearchTooltip
                    : l10n.searchProjectTooltip,
                onPressed: () {
                  setState(() {
                    if (_isSearching) {
                      _isSearching = false;
                      _searchQuery = '';
                      _searchController.clear();
                    } else {
                      _isSearching = true;
                    }
                  });
                },
                style: IconButton.styleFrom(minimumSize: const Size(48, 48)),
                icon: Icon(
                  _isSearching ? Icons.close_rounded : Icons.search_rounded,
                ),
              ),
              if (!_isSearching)
                IconButton(
                  tooltip: l10n.searchTasksTooltip,
                  onPressed: _openTaskSearch,
                  style: IconButton.styleFrom(minimumSize: const Size(48, 48)),
                  icon: const Icon(Icons.manage_search_rounded),
                ),
              const SizedBox(width: 4),
            ],
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (allProjects.isNotEmpty) ...[
                  SizedBox(
                    height: 48,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 8),
                          child: ChoiceChip(
                            label: Text(l10n.all),
                            selected: _selectedProjectId == null,
                            showCheckmark: false,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            onSelected: (_) =>
                                setState(() => _selectedProjectId = null),
                          ),
                        ),
                        ...allProjects.map((project) {
                          final isSelected = _selectedProjectId == project.id;
                          final projectColor = AppTheme.resolveTagColor(
                            project.colorHex,
                            theme.brightness,
                          );
                          return Padding(
                            padding: const EdgeInsetsDirectional.only(end: 8),
                            child: ChoiceChip(
                              label: Text(project.name),
                              selected: isSelected,
                              showCheckmark: false,
                              side: BorderSide(
                                color: isSelected
                                    ? projectColor
                                    : projectColor.withValues(alpha: 0.55),
                                width: 1,
                              ),
                              selectedColor:
                                  projectColor.withValues(alpha: 0.14),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              onSelected: (_) => setState(
                                () => _selectedProjectId =
                                    isSelected ? null : project.id,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                Expanded(
                  child: visibleProjects.isEmpty
                      ? _BoardEmptyState(
                          isFiltered:
                              allProjects.isNotEmpty && _searchQuery.isNotEmpty,
                          query: _searchQuery,
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                          itemCount: visibleProjects.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final project = visibleProjects[index];
                            final progress = project.id != null
                                ? workspaceProvider
                                    .progressForProject(project.id!)
                                : const ProjectProgress();
                            return _ProjectCard(
                              project: project,
                              progress: progress,
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) =>
                                      ProjectDetailScreen(project: project),
                                ),
                              ),
                              onEdit: () =>
                                  _openProjectEditor(project: project),
                              onDelete: () => _deleteProject(project),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'board_fab',
            onPressed: () => _openProjectEditor(),
            tooltip: l10n.createProject,
            child: const Icon(Icons.create_new_folder_outlined),
          ),
        );
      },
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    required this.progress,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final ProjectModel project;
  final ProjectProgress progress;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final accentColor = AppTheme.resolveTagColor(
      project.colorHex,
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
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 4,
                color: accentColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 6, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              project.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          PopupMenuButton<String>(
                            tooltip: l10n.projectOptionsTooltip,
                            onSelected: (value) {
                              if (value == 'edit') {
                                onEdit();
                              } else if (value == 'delete') {
                                onDelete();
                              }
                            },
                            itemBuilder: (_) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: Text(l10n.editProject),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text(l10n.deleteProject),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: progress.ratio,
                            minHeight: 5,
                            backgroundColor: colorScheme.outline,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(accentColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 10),
                        child: Row(
                          children: [
                            Text(
                              l10n.projectsCompletedRatio(
                                progress.completedCount,
                                progress.totalCount,
                              ),
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${progress.percentage}%',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: accentColor,
                                fontWeight: FontWeight.w700,
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BoardEmptyState extends StatelessWidget {
  const _BoardEmptyState({
    required this.isFiltered,
    required this.query,
  });

  final bool isFiltered;
  final String query;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Center(
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
                border: Border.all(color: colorScheme.outline, width: 1),
              ),
              child: Icon(
                Icons.dashboard_outlined,
                size: 26,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              isFiltered ? l10n.projectNotFound : l10n.noProjectsYet,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              isFiltered
                  ? l10n.projectSearchEmpty(query)
                  : l10n.noProjectsSubtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectEditorSheet extends StatefulWidget {
  const _ProjectEditorSheet({this.initialProject});

  final ProjectModel? initialProject;

  static Future<ProjectModel?> show(
    BuildContext context, {
    ProjectModel? initialProject,
  }) {
    return showModalBottomSheet<ProjectModel>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _ProjectEditorSheet(initialProject: initialProject),
    );
  }

  @override
  State<_ProjectEditorSheet> createState() => _ProjectEditorSheetState();
}

class _ProjectEditorSheetState extends State<_ProjectEditorSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late String _colorHex;

  bool get _isEditing => widget.initialProject != null;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.initialProject?.name ?? '');
    _colorHex =
        widget.initialProject?.colorHex ?? AppTheme.tagPalette.first.hex;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final project = ProjectModel(
      id: widget.initialProject?.id,
      name: _nameController.text.trim(),
      colorHex: _colorHex,
      createdAt: widget.initialProject?.createdAt,
    );
    Navigator.of(context).pop(project);
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
                      _isEditing ? l10n.editProject : l10n.newProject,
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
                        labelText: l10n.projectNameLabel,
                        hintText: l10n.projectNameHint,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.projectNameRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.projectColorLabel,
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
                        _isEditing ? l10n.saveChanges : l10n.createProject,
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
