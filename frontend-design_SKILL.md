---
name: frontend-design
description: Craft refined, production-grade Flutter mobile UI for Zettask (and clean static web pages in docs/) with flagship minimalist precision, avoiding generic Material boilerplate and "AI slop" aesthetics.
---

This skill guides the design and refinement of **Zettask**—a fast, calm, offline-first productivity app. Every visual decision must serve clarity, speed, and daily comfort while avoiding both generic default Material UI and loud, distracting web-style gimmicks.

Always respect the project architecture and constraints in `GEMINI.md`.

## Design Thinking (Locked Aesthetic Direction)

Before writing UI code, align every component with Zettask's core identity:
- **Purpose**: Help users capture, organize, and complete daily tasks in seconds without visual fatigue.
- **Tone**: **Refined Swiss Minimalism** (think Things 3, Linear, or iA Writer)—calm, tactile, disciplined, and razor-sharp. Restraint and precision beat decoration.
- **Consistency**: All screens (Timeline/Home, Board, Stats, Paywall, Settings) must feel like one cohesive instrument, never a patchwork of different styles.
- **Constraints**: Flutter Android mobile ergonomics, 60fps performance, 16-language localization (`.arb`), system font scaling, and lean APK size.

## Mobile Aesthetics Guidelines

- **Typography & Hierarchy**:
  - Prioritize crisp hierarchy using weight, letter-spacing, opacity, and scale rather than cluttering the screen with boxes or extra icons.
  - Use tabular figures (`FontFeature.tabularFigures()`) for timestamps, task counts, progress percentages, and statistics so numbers never jitter.
  - Keep typography legible across all 16 supported languages and large system font settings (`MediaQuery.textScalerOf`). Do NOT add heavy decorative font files that bloat the APK or lack multilingual glyphs.
- **Color, Surface & Theme**:
  - Design natively for **Light**, **Dark**, and **AMOLED Pure Black** (`#000000` canvas, `#0A0A0A` elevated surface, `#1E1E1E` subtle borders).
  - Respect the active `Theme.of(context).colorScheme` and Zettask's 5 custom accents (`Monochrome`, `Sage`, `Indigo`, `Terracotta`, `Amber`). Use the accent color sparingly for high-intent focal points (primary CTA, active state, completion check).
  - Prefer crisp `1px` hairline borders and subtle tonal surface shifts over heavy, muddy drop shadows.
  - Guarantee WCAG AA text contrast on every surface and accent button.
- **Spatial Composition & Ergonomics**:
  - Follow a strict `4dp / 8dp` spacing rhythm with generous breathing room around primary content.
  - Keep interactive touch targets thumb-friendly (minimum `48x48dp`) and reachable for one-handed use.
  - Never use grid-breaking overlaps, diagonal flows, or experimental asymmetry that obscure task titles, checkboxes, or swipe gestures.
- **Motion & Micro-Interactions**:
  - Keep transitions crisp and snappy (`180ms–300ms`, `Curves.easeOutCubic`) so power users never feel slowed down.
  - Reuse Zettask's existing custom components (`lib/widgets/zettask_loaders.dart` and `lib/widgets/zettask_motion.dart`) instead of default `CircularProgressIndicator` or inconsistent ad-hoc animations.
  - Always respect `MediaQuery.disableAnimationsOf(context)` and dispose every `AnimationController` cleanly.

## Strict Anti-Patterns (NEVER DO)

- **No Generic AI Slop**: Never use cliched purple-on-white gradients, loud neon glows, gratuitous glassmorphism on dense lists, or unstyled default Material cards with thick elevation shadows.
- **No Unnecessary Dependencies**: Do not add new `pub.dev` UI/animation packages when Flutter's built-in widgets, `CustomPainter`, and `Sliver` APIs can achieve a cleaner, lighter result.
- **No Widget Regressions**: When touching Android Home Screen Widgets, stick strictly to `@RemoteView`-compatible XML layouts and drawable resources listed in `keep.xml`.

## Web Exception (`docs/` Only)

When explicitly editing static web pages inside `docs/` (landing page, Privacy Policy, Delete Account), you may apply more expressive editorial typography, subtle atmospheric backgrounds, and CSS variables—while still staying faithful to Zettask's calm, high-contrast minimalist brand.