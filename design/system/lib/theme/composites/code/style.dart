import 'package:design/extensions/extensions.dart';
import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class CodeStyle implements ThemeComponent<CodeStyle> {
  final Map<String, TextStyle> styles;

  const CodeStyle({required this.styles});

  @override
  CodeStyle copyWith({Map<String, TextStyle>? styles}) => CodeStyle(
        styles: styles ?? this.styles,
      );

  @override
  CodeStyle lerp(CodeStyle? other, double t) {
    if (other is! CodeStyle) return this;
    return CodeStyle(
      styles: styles.mapValues((key, value) => TextStyle.lerp(value, other.styles[key], t)!),
    );
  }
}
