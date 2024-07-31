import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class DividerStyle implements ThemeComponent<DividerStyle> {
  final Color color;

  const DividerStyle({required this.color});

  @override
  DividerStyle copyWith({Color? color}) => DividerStyle(
        color: color ?? this.color,
      );

  @override
  DividerStyle lerp(DividerStyle? other, double t) {
    if (other is! DividerStyle) return this;
    return DividerStyle(
      color: Color.lerp(color, other.color, t)!,
    );
  }
}
