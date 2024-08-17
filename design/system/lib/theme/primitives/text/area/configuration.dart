import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class TextAreaConfiguration implements ThemeComponent<TextAreaConfiguration> {
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry helperPadding;
  final EdgeInsetsGeometry textPadding;
  final TextStyle textStyle;
  final TextStyle helperTextStyle;

  const TextAreaConfiguration({
    required this.borderRadius,
    required this.helperPadding,
    required this.textPadding,
    required this.textStyle,
    required this.helperTextStyle,
  });

  @override
  TextAreaConfiguration copyWith({
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? helperPadding,
    EdgeInsetsGeometry? textPadding,
    TextStyle? textStyle,
    TextStyle? helperTextStyle,
  }) =>
      TextAreaConfiguration(
        borderRadius: borderRadius ?? this.borderRadius,
        helperPadding: helperPadding ?? this.helperPadding,
        textPadding: textPadding ?? this.textPadding,
        textStyle: textStyle ?? this.textStyle,
        helperTextStyle: helperTextStyle ?? this.helperTextStyle,
      );

  @override
  TextAreaConfiguration lerp(TextAreaConfiguration? other, double t) {
    if (other is! TextAreaConfiguration) return this;
    return TextAreaConfiguration(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      helperPadding: EdgeInsetsGeometry.lerp(helperPadding, other.helperPadding, t)!,
      textPadding: EdgeInsetsGeometry.lerp(textPadding, other.textPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      helperTextStyle: TextStyle.lerp(helperTextStyle, other.helperTextStyle, t)!,
    );
  }
}
