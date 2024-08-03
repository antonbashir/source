import 'package:design/model/mixins.dart';
import 'package:design/theme/composites/toast/configuration.dart';
import 'package:design/theme/composites/toast/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class ToastTheme implements ThemeComponent<ToastTheme> {
  final ToastStyle style;
  final ToastConfiguration configuration;

  const ToastTheme({required this.style, required this.configuration});

  @override
  ToastTheme copyWith({
    ToastStyle? style,
    ToastConfiguration? configuration,
  }) =>
      ToastTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  ToastTheme lerp(ThemeComponent<ToastTheme>? other, double t) {
    if (other is! ToastTheme) return this;
    return ToastTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
