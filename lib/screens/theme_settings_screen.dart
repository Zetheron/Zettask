import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../models/subscription_model.dart';
import '../models/task_model.dart';
import '../providers/subscription_provider.dart';
import '../providers/theme_provider.dart';
import 'pro_paywall_screen.dart';

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
      AppThemePreset.defaultIndigo => (
          l10n.presetDefault,
          l10n.presetDefaultDesc,
        ),
      AppThemePreset.ocean => (l10n.presetOcean, l10n.presetOceanDesc),
      AppThemePreset.forest => (l10n.presetForest, l10n.presetForestDesc),
      AppThemePreset.terracotta => (
          l10n.presetTerracotta,
          l10n.presetTerracottaDesc,
        ),
      AppThemePreset.plum => (l10n.presetPlum, l10n.presetPlumDesc),
      AppThemePreset.monochrome => (
          l10n.presetMonochrome,
          l10n.presetMonochromeDesc,
        ),
    };
  }

  String _accentLabel(ProAccentColor accent, AppLocalizations l10n) {
    return switch (accent) {
      ProAccentColor.monochrome => l10n.accentMonochrome,
      ProAccentColor.sage => l10n.accentSage,
      ProAccentColor.indigo => l10n.accentIndigo,
      ProAccentColor.terracotta => l10n.accentTerracotta,
      ProAccentColor.amber => l10n.accentAmber,
    };
  }

  String _widgetStyleLabel(WidgetStyle style, AppLocalizations l10n) {
    return switch (style) {
      WidgetStyle.standard => l10n.widgetStyleStandard,
      WidgetStyle.amoled => l10n.widgetStyleAmoled,
      WidgetStyle.translucent => l10n.widgetStyleTranslucent,
    };
  }

  Future<void> _handleToggleAmoled(
    BuildContext context,
    ThemeProvider themeProvider,
    bool isPro,
    bool value,
  ) async {
    if (value && !isPro) {
      await showProPaywall(
        context,
        highlightedFeature: ProFeature.customThemes,
      );
      return;
    }
    await themeProvider.setAmoledBlack(value);
  }

  Future<void> _handleSelectAccent(
    BuildContext context,
    ThemeProvider themeProvider,
    bool isPro,
    ProAccentColor accent,
  ) async {
    if (accent.isPro && !isPro) {
      await showProPaywall(
        context,
        highlightedFeature: ProFeature.customThemes,
      );
      return;
    }
    await themeProvider.setAccentColor(accent);
  }

  Future<void> _handleSelectWidgetStyle(
    BuildContext context,
    ThemeProvider themeProvider,
    bool isPro,
    WidgetStyle style,
  ) async {
    if (style.isPro && !isPro) {
      await showProPaywall(
        context,
        highlightedFeature: ProFeature.widgetStyles,
      );
      return;
    }
    await themeProvider.setWidgetStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final themeProvider = context.watch<ThemeProvider>();
    final subscriptionProvider = context.watch<SubscriptionProvider?>();
    final isPro = subscriptionProvider?.isPro ?? false;
    final previewTheme = _resolvePreviewTheme(context, themeProvider);
    final activeBadgeName =
        themeProvider.accentColor == ProAccentColor.monochrome
            ? _presetCopy(themeProvider.preset, l10n).$1
            : _accentLabel(themeProvider.accentColor, l10n);

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
                presetLabel: activeBadgeName,
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
            const SizedBox(height: 22),
            Material(
              color: colorScheme.surface,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: colorScheme.outline, width: 1),
              ),
              clipBehavior: Clip.antiAlias,
              child: SwitchListTile(
                key: const ValueKey('amoled_black_switch'),
                value: themeProvider.isAmoledBlack,
                onChanged: (value) => _handleToggleAmoled(
                  context,
                  themeProvider,
                  isPro,
                  value,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                secondary: Icon(
                  Icons.contrast_rounded,
                  size: 20,
                  color: themeProvider.isAmoledBlack
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
                title: Row(
                  children: [
                    Flexible(
                      child: Text(
                        l10n.amoledPureBlackTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 14.5,
                        ),
                      ),
                    ),
                    if (!isPro) ...[
                      const SizedBox(width: 8),
                      _ProTagBadge(label: l10n.proBadge),
                    ],
                  ],
                ),
                subtitle: Text(
                  l10n.amoledPureBlackSubtitle,
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ),
            const SizedBox(height: 22),
            _SectionHeader(title: l10n.customAccentSection),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final accent in ProAccentColor.values)
                  _AccentColorChip(
                    key: ValueKey('accent_chip_${accent.key}'),
                    accent: accent,
                    label: _accentLabel(accent, l10n),
                    proBadgeLabel: l10n.proBadge,
                    isSelected: themeProvider.accentColor == accent,
                    showProBadge: accent.isPro && !isPro,
                    onTap: () => _handleSelectAccent(
                      context,
                      themeProvider,
                      isPro,
                      accent,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 22),
            _SectionHeader(title: l10n.widgetStyleSection),
            const SizedBox(height: 8),
            Row(
              children: [
                for (var i = 0; i < WidgetStyle.values.length; i++) ...[
                  Expanded(
                    child: _WidgetStyleCard(
                      key: ValueKey(
                        'widget_style_${WidgetStyle.values[i].key}',
                      ),
                      style: WidgetStyle.values[i],
                      label: _widgetStyleLabel(WidgetStyle.values[i], l10n),
                      proBadgeLabel: l10n.proBadge,
                      isSelected:
                          themeProvider.widgetStyle == WidgetStyle.values[i],
                      showProBadge: WidgetStyle.values[i].isPro && !isPro,
                      onTap: () => _handleSelectWidgetStyle(
                        context,
                        themeProvider,
                        isPro,
                        WidgetStyle.values[i],
                      ),
                    ),
                  ),
                  if (i < WidgetStyle.values.length - 1)
                    const SizedBox(width: 8),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProTagBadge extends StatelessWidget {
  const _ProTagBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: colorScheme.onPrimaryContainer,
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _AccentColorChip extends StatelessWidget {
  const _AccentColorChip({
    super.key,
    required this.accent,
    required this.label,
    required this.proBadgeLabel,
    required this.isSelected,
    required this.showProBadge,
    required this.onTap,
  });

  final ProAccentColor accent;
  final String label;
  final String proBadgeLabel;
  final bool isSelected;
  final bool showProBadge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final swatch = accent.previewColor(theme.brightness);
    final onSwatch = theme.brightness == Brightness.dark
        ? accent.tokens.onPrimaryDark
        : accent.tokens.onPrimaryLight;

    return Material(
      color: colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? swatch : colorScheme.outline,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: swatch,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.outline,
                      width: 1,
                    ),
                  ),
                  child: isSelected
                      ? Icon(Icons.check_rounded, size: 13, color: onSwatch)
                      : null,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
                if (showProBadge) ...[
                  const SizedBox(width: 6),
                  _ProTagBadge(label: proBadgeLabel),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WidgetStyleCard extends StatelessWidget {
  const _WidgetStyleCard({
    super.key,
    required this.style,
    required this.label,
    required this.proBadgeLabel,
    required this.isSelected,
    required this.showProBadge,
    required this.onTap,
  });

  final WidgetStyle style;
  final String label;
  final String proBadgeLabel;
  final bool isSelected;
  final bool showProBadge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final Color previewBg;
    final Color previewBorder;
    final Color previewLine;
    switch (style) {
      case WidgetStyle.standard:
        previewBg = colorScheme.surfaceContainerHighest;
        previewBorder = colorScheme.outline;
        previewLine = colorScheme.onSurfaceVariant;
      case WidgetStyle.amoled:
        previewBg = const Color(0xFF000000);
        previewBorder = const Color(0xFF1E1E1E);
        previewLine = const Color(0xFFFAFAFA);
      case WidgetStyle.translucent:
        previewBg = const Color(0xB3121212);
        previewBorder = const Color(0x4DFFFFFF);
        previewLine = const Color(0xFFFAFAFA);
    }

    return Material(
      color: colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isSelected ? colorScheme.primary : colorScheme.outline,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 46,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: previewBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: previewBorder, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 34,
                      height: 5,
                      decoration: BoxDecoration(
                        color: previewLine.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 4,
                      decoration: BoxDecoration(
                        color: previewLine.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: previewLine.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w600,
                      ),
                    ),
                  ),
                  if (showProBadge)
                    _ProTagBadge(label: proBadgeLabel)
                  else if (isSelected)
                    Icon(
                      Icons.check_circle_rounded,
                      size: 15,
                      color: colorScheme.primary,
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
