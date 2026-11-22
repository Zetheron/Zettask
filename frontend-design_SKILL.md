---
name: frontend-design
description: Craft expressive, tactile, production-grade Material 3 Expressive Flutter UI for Zettask (and clean editorial static web pages in docs/) while preserving daily speed, readability, and 16-language stability.
---

This skill guides the design and evolution of **Zettask**—a fast, calm, offline-first Android productivity app built with **Material 3 Expressive**. Every visual decision must feel alive, tactile, and unmistakably modern Android without sacrificing task-capture speed or causing visual clutter.

Always respect the project architecture and constraints in `GEMINI.md`.

## Design Thinking (Locked Aesthetic Direction)

Align every screen and component with Zettask's updated visual identity:
- **Purpose**: Make capturing, organizing, and completing daily tasks feel rewarding, effortless, and tactile.
- **Tone**: **Material 3 Expressive**—confident typography, soft tonal surfaces (`surfaceContainer*`), generous rounded/pill geometry, and lively spring-based micro-interactions, balanced with calm breathing room for daily productivity.
- **Consistency**: Every screen (Timeline/Home, Board, Stats, Settings, Theme Settings, Onboarding) must share the same shape language, tonal surface hierarchy, and spring motion system.
- **Constraints**: Flutter Android mobile ergonomics, 60fps performance, 16-language localization (`.arb`), system font scaling (`MediaQuery.textScalerOf`), and lean APK size.

## Material 3 Expressive Guidelines

- **Typography & Hierarchy**:
  - Use bold, expressive display/headline weights (`Plus Jakarta Sans` bold/extra-bold with tight negative tracking `-0.5` to `-0.8`) for screen titles, dates, and hero stats.
  - Pair expressive headers with clean, highly legible body text and `FontFeature.tabularFigures()` for timestamps, task counters, streaks, and progress percentages.
  - Always guard expressive headings against text overflow (`maxLines`, `TextOverflow.ellipsis`, `Flexible`/`Expanded`) across all 16 `.arb` languages and large system text scales.
- **Tonal Surfaces, Color & Theme**:
  - Prioritize **tonal surface layering** (`surfaceContainerLowest`, `surfaceContainerLow`, `surfaceContainer`, `surfaceContainerHigh`, `surfaceContainerHighest`) over heavy drop shadows or rigid `1px` wireframe borders.
  - Design natively for **Light**, **Dark**, **AMOLED Pure Black**, **Material You (Dynamic Color)**, and Zettask's 5 custom accents (`Monochrome`, `Sage`, `Indigo`, `Terracotta`, `Amber`).
  - **AMOLED Pure Black Rule**: Keep scaffold canvas strictly `#000000`, primary cards `#0A0A0A` to `#121212`, and subtle hairline borders `#1E1E1E` only where tonal contrast needs gentle separation—never wash out AMOLED black into muddy gray.
  - Use high-contrast `primaryContainer` / `secondaryContainer` fills for active tabs, selected chips, and primary actions while maintaining WCAG AA readability.
- **Expressive Shape Language & Ergonomics**:
  - Use generous corner radii: cards & sheets (`20dp–28dp`), interactive tiles (`16dp–20dp`), chips, segmented controls, and primary buttons (`StadiumBorder` / full pill).
  - Emphasize primary actions with expressive FABs (`16dp–20dp` squircle or pill `ExtendedFloatingActionButton`) and clear `48x48dp` minimum thumb targets.
  - Keep layouts structured and scannable—never use chaotic overlaps or diagonal grids that obscure checkboxes, task titles, or swipe actions.
- **Spring Physics & Micro-Interactions**:
  - Replace rigid linear/standard curves on tactile controls (task checkboxes, FAB press, pill tab selection, bottom sheets, completion celebration) with responsive **spring physics** (`SpringSimulation` / expressive overshoot curves) inside `lib/widgets/zettask_motion.dart`.
  - Reuse Zettask's custom motion & loader components (`zettask_loaders.dart`, `zettask_motion.dart`).
  - Always respect `MediaQuery.disableAnimationsOf(context)` and dispose every `AnimationController` cleanly.

## Strict Anti-Patterns (NEVER DO)

- **No Generic Boilerplate or AI Slop**: Never use muddy default elevation shadows, unstyled Material 2 boxes, neon glows, or distracting gradients behind dense task lists.
- **No Unnecessary Dependencies**: Build expressive shapes and spring physics using Flutter's built-in `Material 3`, `SpringSimulation`, `AnimatedContainer`, and `CustomPainter`—do not bloat `pubspec.yaml` with heavy UI/animation packages.
- **No Widget Regressions**: Keep Android Home Screen Widgets strictly `@RemoteView`-compatible XML and preserve all resources in `keep.xml`.

## Web Exception (`docs/` Only)

Static web pages in `docs/` may use clean editorial typography and subtle expressive accents while remaining fast, zero-build HTML/CSS/JS aligned with Zettask's brand.