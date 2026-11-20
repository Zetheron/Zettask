import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../models/task_model.dart';
import '../providers/theme_provider.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  ThemeData _resolvePreviewTheme(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    final platformBrightness = MediaQuery.platformBrightnessOf(context);
    final isDark = switch (themeProvider.themeMode) {
      ThemeMode.dark => true,
      ThemeMode.light => false,
      ThemeMode.system => platformBrightness == Brightness.dark,
    };
    return isDark ? themeProvider.darkTheme : themeProvider.lightTheme;
  }

  (String, String) _presetCopy(AppThemePreset preset, AppLocalizations l10n) {
    return switch (preset) {
      AppThemePreset.defaultIndigo => (l10n.presetDefault, l10n.presetDefaultDesc),
      AppThemePreset.ocean => (l10n.presetOcean, l10n.presetOceanDesc),
      AppThemePreset.forest => (l10n.presetForest, l10n.presetForestDesc),
      AppThemePreset.terracotta =>
        (l10n.presetTerracotta, l10n.presetTerracottaDesc),
      AppThemePreset.plum => (l10n.presetPlum, l10n.presetPlumDesc),
      AppThemePreset.monochrome =>
        (l10n.presetMonochrome, l10n.presetMonochromeDesc),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final themeProvider = context.watch<ThemeProvider>();
    final previewTheme = _resolvePreviewTheme(context, themeProvider);
    final activePresetName = _presetCopy(themeProvider.preset, l10n).$1;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.themeAndColorsTitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          children: [
            _SectionHeader(title: l10n.livePreviewSection),
            const SizedBox(height: 8),
            Theme(
              data: previewTheme,
              child: _TimelineLivePreviewCard(
                key: const ValueKey('theme_live_preview'),
                presetLabel: activePresetName,
                l10n: l10n,
              ),
            ),
            const SizedBox(height: 22),
            _SectionHeader(title: l10n.appearanceModeSection),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: colorScheme.outline, width: 1),
              ),
              child: Row(
                children: [
                  for (final option in [
                    (ThemeMode.light, l10n.themeLight, Icons.light_mode_outlined),
                    (ThemeMode.dark, l10n.themeDark, Icons.dark_mode_outlined),
                    (
                      ThemeMode.system,
                      l10n.themeSystem,
                      Icons.brightness_auto_outlined,
                    ),
                  ])
                    Expanded(
                      child: _ModeOptionButton(
                        label: option.$2,
                        icon: option.$3,
                        isSelected: themeProvider.themeMode == option.$1,
                        onTap: () => themeProvider.setThemeMode(option.$1),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            _SectionHeader(title: l10n.colorPaletteSection),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: AppThemePreset.values.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.75,
              ),
              itemBuilder: (context, index) {
                final preset = AppThemePreset.values[index];
                final isSelected = themeProvider.preset == preset;
                final (label, desc) = _presetCopy(preset, l10n);
                return _PresetCard(
                  preset: preset,
                  label: label,
                  description: desc,
                  isSelected: isSelected,
                  onTap: () => themeProvider.setPreset(preset),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 4),
      child: Text(
        title,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontSize: 12.5,
        ),
      ),
    );
  }
}

class _ModeOptionButton extends StatelessWidget {
  const _ModeOptionButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: isSelected ? colorScheme.surface : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: isSelected
            ? BorderSide(color: colorScheme.outline, width: 1)
            : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
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

class _PresetCard extends StatelessWidget {
  const _PresetCard({
    required this.preset,
    required this.label,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  final AppThemePreset preset;
  final String label;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primarySwatch = preset.previewPrimary(theme.brightness);
    final containerSwatch = preset.previewContainer(theme.brightness);

    return Material(
      color: colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isSelected ? primarySwatch : colorScheme.outline,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: primarySwatch,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: containerSwatch,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.outline,
                        width: 1,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (isSelected)
                    Container(
                      key: ValueKey('preset_check_${preset.key}'),
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: primarySwatch,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        size: 14,
                        color: theme.brightness == Brightness.dark
                            ? preset.tokens.onPrimaryDark
                            : preset.tokens.onPrimaryLight,
                      ),
                    ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 11.5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineLivePreviewCard extends StatelessWidget {
  const _TimelineLivePreviewCard({
    super.key,
    required this.presetLabel,
    required this.l10n,
  });

  final String presetLabel;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final priorityColor =
        AppTheme.priorityColor(TaskPriority.high, theme.brightness);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                l10n.today,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  presetLabel,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.outline, width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.primary,
                        width: 1.75,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.previewActiveTask,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: [
                          _PreviewChip(
                            label: '09:00',
                            background: colorScheme.primaryContainer,
                            foreground: colorScheme.onPrimaryContainer,
                          ),
                          _PreviewChip(
                            label: l10n.priorityHigh,
                            background: priorityColor.withValues(alpha: 0.12),
                            foreground: priorityColor,
                          ),
                          _PreviewChip(
                            label: '#${l10n.tagLabel}',
                            background: colorScheme.surfaceContainerHighest,
                            foreground: colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.outline, width: 1),
            ),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.primary,
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    size: 13,
                    color: colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.previewCompletedTask,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 13.5,
                      decoration: TextDecoration.lineThrough,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Text(
                  '08:00',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewChip extends StatelessWidget {
  const _PreviewChip({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w600,
          fontSize: 10.5,
        ),
      ),
    );
  }
}
