part of '../defaults.dart';

final _lightEffects = ThemeMutable(
  (Tokens tokens) => EffectsTheme(
    focus: FocusEffectStyle(
      color: tokens.colors.mainContent.withOpacity(0.25),
      extent: 4,
      duration: _transitions.transitionDuration,
      curve: _transitions.transitionCurve,
    ),
    hover: HoverEffectStyle(
      color: tokens.colors.hover,
      duration: _transitions.transitionDuration,
      curve: _transitions.transitionCurve,
    ),
    pulse: PulseEffectStyle(
      color: tokens.colors.main,
      duration: const Duration(milliseconds: 1400),
      curve: _transitions.transitionCurve,
      extent: 24,
      scalar: 0,
    ),
    scale: ScaleEffectStyle(
      duration: const Duration(milliseconds: 100),
      curve: _transitions.transitionCurve,
      upscale: 0.15,
      downscale: 0.12,
      color: Colors.transparent,
      extent: 0,
    ),
  ),
);

final _darkEffects = ThemeMutable(
  (Tokens tokens) => EffectsTheme(
    focus: FocusEffectStyle(
      color: tokens.colors.main.withOpacity(0.25),
      extent: 1,
      duration: _transitions.transitionDuration,
      curve: _transitions.transitionCurve,
    ),
    hover: HoverEffectStyle(
      color: tokens.colors.hover,
      duration: _transitions.transitionDuration,
      curve: _transitions.transitionCurve,
    ),
    pulse: PulseEffectStyle(
      color: tokens.colors.main,
      duration: const Duration(milliseconds: 1400),
      curve: _transitions.transitionCurve,
      extent: 24,
      scalar: 0,
    ),
    scale: ScaleEffectStyle(
      duration: const Duration(milliseconds: 100),
      curve: _transitions.transitionCurve,
      upscale: 0.15,
      downscale: 0.12,
      color: Colors.transparent,
      extent: 0,
    ),
  ),
);