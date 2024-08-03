import 'package:design/model/breakpoints.dart';
import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/avatar/configuration.dart';
import 'package:design/theme/primitives/avatar/style.dart';
import 'package:flutter/foundation.dart';

@immutable
class AvatarTheme implements ThemeComponent<AvatarTheme> {
  final AvatarStyle style;
  final Breakpoints<AvatarConfiguration> sizes;

  const AvatarTheme({required this.style, required this.sizes});

  @override
  AvatarTheme copyWith({
    AvatarStyle? style,
    Breakpoints<AvatarConfiguration>? sizes,
  }) =>
      AvatarTheme(
        style: style ?? this.style,
        sizes: sizes ?? this.sizes,
      );

  @override
  AvatarTheme lerp(AvatarTheme? other, double t) {
    if (other is! AvatarTheme) return this;
    return AvatarTheme(
      style: style.lerp(other.style, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }
}
