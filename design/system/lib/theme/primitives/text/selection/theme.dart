import 'dart:ui';

import 'package:design/model/mixins.dart';

class TextSelectionTheme implements ThemeComponent<TextSelectionTheme> {
  final Color cursorColor;
  final Color selectionColor;
  final Color selectionHandleColor;

  const TextSelectionTheme({
    required this.cursorColor,
    required this.selectionColor,
    required this.selectionHandleColor,
  });

  @override
  TextSelectionTheme copyWith({
    Color? cursorColor,
    Color? selectionColor,
    Color? selectionHandleColor,
  }) =>
      TextSelectionTheme(
        cursorColor: cursorColor ?? this.cursorColor,
        selectionColor: selectionColor ?? this.selectionColor,
        selectionHandleColor: selectionHandleColor ?? this.selectionHandleColor,
      );

  @override
  TextSelectionTheme lerp(TextSelectionTheme? other, double t) {
    if (other is! TextSelectionTheme) return this;
    return TextSelectionTheme(
      cursorColor: Color.lerp(cursorColor, other.cursorColor, t)!,
      selectionColor: Color.lerp(selectionColor, other.selectionColor, t)!,
      selectionHandleColor: Color.lerp(selectionHandleColor, other.selectionHandleColor, t)!,
    );
  }
}
