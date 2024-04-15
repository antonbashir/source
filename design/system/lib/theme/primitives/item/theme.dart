import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/item/configuration.dart';
import 'package:design/theme/primitives/item/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class ListItemTheme implements ThemeComponent<ListItemTheme> {
  final ListItemStyle style;
  final ListItemConfiguration configuration;

  const ListItemTheme({
    required this.style,
    required this.configuration,
  });

  @override
  ListItemTheme copyWith({
    ListItemStyle? style,
    ListItemConfiguration? configuration,
  }) =>
      ListItemTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  ListItemTheme lerp(ThemeComponent<ListItemTheme>? other, double t) {
    if (other is! ListItemTheme) return this;
    return ListItemTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
