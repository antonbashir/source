import 'package:design/constants/buttons.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class ButtonColors implements ThemeComponent<ButtonColors> {
  final Color content;
  final Color background;
  final Color hover;
  final Color hoverContent;
  final Color focus;
  final Color border;

  const ButtonColors({
    required this.content,
    required this.border,
    required this.background,
    required this.hover,
    required this.hoverContent,
    required this.focus,
  });

  @override
  ButtonColors copyWith({
    Color? content,
    Color? border,
    Color? background,
    Color? hover,
    Color? hoverContent,
    Color? focus,
  }) =>
      ButtonColors(
        border: border ?? this.border,
        content: content ?? this.content,
        background: background ?? this.background,
        hover: hover ?? this.hover,
        hoverContent: hoverContent ?? this.hoverContent,
        focus: focus ?? this.focus,
      );

  @override
  ButtonColors lerp(ButtonColors? other, double t) {
    if (other is! ButtonColors) return this;
    return ButtonColors(
      content: Color.lerp(content, other.content, t)!,
      border: Color.lerp(border, other.border, t)!,
      background: Color.lerp(background, other.background, t)!,
      hover: Color.lerp(hover, other.hover, t)!,
      hoverContent: Color.lerp(hoverContent, other.hoverContent, t)!,
      focus: Color.lerp(focus, other.focus, t)!,
    );
  }
}

@immutable
class ButtonStyle implements ThemeComponent<ButtonStyle> {
  final ButtonColors fallbackColors;
  final Map<ButtonVariant, ButtonColors> variantColors;

  const ButtonStyle({
    required this.fallbackColors,
    required this.variantColors,
  });

  ButtonColors selectColors(ButtonVariant? variant) => variantColors[variant] ?? fallbackColors;

  @override
  ButtonStyle copyWith({
    ButtonColors? fallbackColors,
    Map<ButtonVariant, ButtonColors>? variantColors,
  }) =>
      ButtonStyle(
        fallbackColors: fallbackColors ?? this.fallbackColors,
        variantColors: variantColors ?? this.variantColors,
      );

  @override
  ButtonStyle lerp(ButtonStyle? other, double t) {
    if (other is! ButtonStyle) return this;
    return ButtonStyle(
      fallbackColors: fallbackColors.lerp(other.fallbackColors, t),
      variantColors: variantColors.mapValues((key, value) => value.lerp(other.variantColors[key], t)),
    );
  }
}
