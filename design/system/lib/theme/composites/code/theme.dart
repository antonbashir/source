import 'package:design/model/mixins.dart';
import 'package:design/theme/composites/code/style.dart';
import 'package:flutter/widgets.dart';

@immutable
class CodeTheme implements ThemeComponent<CodeTheme> {
  final CodeStyle style;

  const CodeTheme({required this.style});

  @override
  CodeTheme copyWith({CodeStyle? style}) => CodeTheme(
        style: style ?? this.style,
      );

  @override
  CodeTheme lerp(CodeTheme? other, double t) {
    if (other is! CodeTheme) return this;
    return CodeTheme(style: style.lerp(other.style, t));
  }
}
