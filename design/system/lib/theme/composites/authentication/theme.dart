import 'package:design/model/mixins.dart';
import 'package:design/theme/composites/authentication/configuration.dart';
import 'package:design/theme/composites/authentication/style.dart';
import 'package:flutter/foundation.dart';

@immutable
class AuthenticationCodeTheme implements ThemeComponent<AuthenticationCodeTheme> {
  final AuthenticationCodeStyle style;
  final AuthenticationCodeConfiguration configuration;

  const AuthenticationCodeTheme({
    required this.style,
    required this.configuration,
  });

  @override
  AuthenticationCodeTheme copyWith({
    AuthenticationCodeStyle? style,
    AuthenticationCodeConfiguration? configuration,
  }) =>
      AuthenticationCodeTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  AuthenticationCodeTheme lerp(ThemeComponent<AuthenticationCodeTheme>? other, double t) {
    if (other is! AuthenticationCodeTheme) return this;
    return AuthenticationCodeTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
