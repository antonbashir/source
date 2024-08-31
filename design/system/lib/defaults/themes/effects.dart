part of '../defaults.dart';

final _lightEffects = ThemeMutable(
  (Tokens tokens) => EffectsTheme(
    focus: FocusEffectStyle(
      color: tokens.colors.focus,
      extent: 2,
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
    ),
    scale: ScaleEffectStyle(
      duration: const Duration(milliseconds: 100),
      curve: _transitions.transitionCurve,
      upscale: 0.15,
      downscale: 0.15,
      color: Colors.transparent,
      extent: 0,
    ),
  ),
);

final _darkEffects = ThemeMutable(
  (Tokens tokens) => EffectsTheme(
    focus: FocusEffectStyle(
      color: tokens.colors.focus,
      extent: 2,
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
    ),
    scale: ScaleEffectStyle(
      duration: _transitions.transitionDuration,
      curve: _transitions.transitionCurve,
      upscale: 0.15,
      downscale: 0.15,
      color: Colors.transparent,
      extent: 0,
    ),
  ),
);
