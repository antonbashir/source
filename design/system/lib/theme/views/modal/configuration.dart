import 'package:design/constants/borders.dart';
import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class ModalConfiguration implements ThemeComponent<ModalConfiguration> {
  final BorderType borderType;
  final BorderRadiusGeometry borderRadius;
  final TextStyle textStyle;

  const ModalConfiguration({
    required this.borderType,
    required this.borderRadius,
    required this.textStyle,
  });

  @override
  ModalConfiguration copyWith({
    BorderType? borderType,
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
  }) =>
      ModalConfiguration(
        borderType: borderType ?? this.borderType,
        borderRadius: borderRadius ?? this.borderRadius,
        textStyle: textStyle ?? this.textStyle,
      );

  @override
  ModalConfiguration lerp(ThemeComponent<ModalConfiguration>? other, double t) {
    if (other is! ModalConfiguration) return this;
    return ModalConfiguration(
      borderType: other.borderType,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
