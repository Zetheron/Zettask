import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../models/note_model.dart';
import '../models/tag_model.dart';
import '../providers/locale_provider.dart';
import '../providers/workspace_provider.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatUpdatedAt(DateTime date, String intlLocale) {
    try {
      return DateFormat('d MMM, HH:mm', intlLocale).format(date);
    } catch (_) {
      return DateFormat('d MMM, HH:mm').format(date);
    }
  }

  Future<void> _openNoteEditor({NoteModel? note}) async {
    final workspaceProvider = context.read<WorkspaceProvider>();
    final result = await _NoteEditorSheet.show(
      context,
      initialNote: note,
      tags: workspaceProvider.tags,
    );
    if (!mounted || result == null) return;

    switch (result) {
      case _NoteSaved(:final note):
        if (note.id == null) {
          await workspaceProvider.addNote(note);
        } else {
          await workspaceProvider.updateNote(note);
        }
      case _NoteDeleted(:final note):
        await _deleteWithUndo(note);
    }
  }

  Future<void> _deleteWithUndo(NoteModel note) async {
    final id = note.id;
    if (id == null) return;
    final workspaceProvider = context.read<WorkspaceProvider>();
    await workspaceProvider.deleteNote(id);

    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l10n.noteDeleted),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: l10n.undo,
            onPressed: () => workspaceProvider.restoreNote(note),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final intlLocale =
        LocaleProvider.intlLocaleTag(Localizations.localeOf(context));

    return Consumer<WorkspaceProvider>(
      builder: (context, workspaceProvider, _) {
        final notes = workspaceProvider.notes.where((note) {
          if (_query.isEmpty) return true;
          final q = _query.toLowerCase();
          return note.title.toLowerCase().contains(q) ||
              note.content.toLowerCase().contains(q);
        }).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.notesTitle),
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _query = value.trim()),
                    decoration: InputDecoration(
                      hintText: l10n.searchNotesHint,
                      prefixIcon: const Icon(Icons.search_rounded, size: 20),
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                              tooltip: l10n.clear,
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _query = '');
                              },
                              icon: const Icon(Icons.close_rounded, size: 18),
                            )
                          : null,
                    ),
                  ),
                ),
                Expanded(
                  child: notes.isEmpty
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
                                    Icons.sticky_note_2_outlined,
                                    size: 26,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  _query.isNotEmpty
                                      ? l10n.noteNotFound
                                      : l10n.noNotesYet,
                                  style: theme.textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _query.isNotEmpty
                                      ? l10n.noteSearchEmpty(_query)
                                      : l10n.noNotesSubtitle,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
                          itemCount: notes.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final note = notes[index];
                            final tag = workspaceProvider.findTag(note.tagId);
                            final accentColor = AppTheme.resolveTagColor(
                              note.colorHex,
                              theme.brightness,
                            );

                            return Dismissible(
                              key: ValueKey('note_${note.id ?? note.hashCode}'),
                              direction: DismissDirection.endToStart,
                              onDismissed: (_) => _deleteWithUndo(note),
                              background: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                alignment: AlignmentDirectional.centerEnd,
                                decoration: BoxDecoration(
                                  color:
                                      colorScheme.error.withValues(alpha: 0.14),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: colorScheme.error
                                        .withValues(alpha: 0.4),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      l10n.delete,
                                      style:
                                          theme.textTheme.labelMedium?.copyWith(
                                        color: colorScheme.error,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.delete_outline_rounded,
                                      color: colorScheme.error,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                              child: Material(
                                color: colorScheme.surface,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  side: BorderSide(
                                    color: colorScheme.outline,
                                    width: 1,
                                  ),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () => _openNoteEditor(note: note),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          width: 3.5,
                                          color: accentColor,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                              14,
                                              12,
                                              14,
                                              12,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  note.title,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: theme
                                                      .textTheme.titleMedium
                                                      ?.copyWith(fontSize: 15),
                                                ),
                                                if (note.content
                                                    .trim()
                                                    .isNotEmpty) ...[
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    note.content.trim(),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: theme
                                                        .textTheme.bodySmall,
                                                  ),
                                                ],
                                                const SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    if (tag != null) ...[
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 7,
                                                          vertical: 2,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppTheme
                                                                  .resolveTagColor(
                                                                    tag.colorHex,
                                                                    theme
                                                                        .brightness,
                                                                  )
                                                              .withValues(
                                                                alpha: 0.12,
                                                              ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                        ),
                                                        child: Text(
                                                          tag.name,
                                                          style: theme.textTheme
                                                              .labelSmall
                                                              ?.copyWith(
                                                            color: AppTheme
                                                                .resolveTagColor(
                                                              tag.colorHex,
                                                              theme.brightness,
                                                            ),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 10.5,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                    ],
                                                    Text(
                                                      _formatUpdatedAt(
                                                        note.updatedAt,
                                                        intlLocale,
                                                      ),
                                                      style: theme
                                                          .textTheme.labelSmall
                                                          ?.copyWith(
                                                        color: colorScheme
                                                            .onSurfaceVariant
                                                            .withValues(
                                                          alpha: 0.75,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
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
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'notes_fab',
            onPressed: () => _openNoteEditor(),
            tooltip: l10n.newNote,
            child: const Icon(Icons.add_rounded),
          ),
        );
      },
    );
  }
}

sealed class _NoteEditorResult {
  const _NoteEditorResult();
}

final class _NoteSaved extends _NoteEditorResult {
  const _NoteSaved(this.note);

  final NoteModel note;
}

final class _NoteDeleted extends _NoteEditorResult {
  const _NoteDeleted(this.note);

  final NoteModel note;
}

class _NoteEditorSheet extends StatefulWidget {
  const _NoteEditorSheet({
    this.initialNote,
    required this.tags,
  });

  final NoteModel? initialNote;
  final List<TagModel> tags;

  static Future<_NoteEditorResult?> show(
    BuildContext context, {
    NoteModel? initialNote,
    required List<TagModel> tags,
  }) {
    return showModalBottomSheet<_NoteEditorResult>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _NoteEditorSheet(
        initialNote: initialNote,
        tags: tags,
      ),
    );
  }

  @override
  State<_NoteEditorSheet> createState() => _NoteEditorSheetState();
}

class _NoteEditorSheetState extends State<_NoteEditorSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late String _colorHex;
  int? _tagId;

  bool get _isEditing => widget.initialNote != null;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.initialNote?.title ?? '');
    _contentController =
        TextEditingController(text: widget.initialNote?.content ?? '');
    _colorHex = widget.initialNote?.colorHex ?? AppTheme.tagPalette.first.hex;
    _tagId = widget.initialNote?.tagId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.of(context).pop(
      _NoteSaved(
        NoteModel(
          id: widget.initialNote?.id,
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
          colorHex: _colorHex,
          tagId: _tagId,
          updatedAt: DateTime.now(),
        ),
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
    final checkColor = theme.brightness == Brightness.dark
        ? const Color(0xFF0A0A0A)
        : Colors.white;

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
                      _isEditing ? l10n.editNote : l10n.newNote,
                      style: theme.textTheme.titleLarge?.copyWith(fontSize: 19),
                    ),
                  ),
                  if (_isEditing)
                    IconButton(
                      tooltip: l10n.deleteNoteTooltip,
                      onPressed: () => Navigator.of(context)
                          .pop(_NoteDeleted(widget.initialNote!)),
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
                      TextFormField(
                        controller: _titleController,
                        autofocus: !_isEditing,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: l10n.noteTitleLabel,
                          hintText: l10n.noteTitleHint,
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? l10n.noteTitleRequired
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _contentController,
                        textCapitalization: TextCapitalization.sentences,
                        minLines: 4,
                        maxLines: 8,
                        decoration: InputDecoration(
                          labelText: l10n.noteContentLabel,
                          hintText: l10n.noteContentHint,
                          alignLabelWithHint: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.colorLabel,
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
                                  width: 28,
                                  height: 28,
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
                                          size: 15,
                                          color: checkColor,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
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
                child: Text(_isEditing ? l10n.saveChanges : l10n.saveNote),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
