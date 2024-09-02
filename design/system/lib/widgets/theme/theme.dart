import 'package:design/defaults/defaults.dart';
import 'package:design/theme/theme.dart';
import 'package:flutter/widgets.dart';

class Theme extends StatelessWidget {
  final ThemeConfiguration configuration;
  final Widget child;

  const Theme({super.key, required this.configuration, required this.child});

  static ThemeConfiguration of(BuildContext context) {
    final _InheritedTheme? inheritedTheme = context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    return inheritedTheme?.theme.configuration ?? Defaults.lightTheme;
  }

  @override
  Widget build(BuildContext context) => _InheritedTheme(theme: this, child: child);
}

class _InheritedTheme extends InheritedTheme {
  const _InheritedTheme({
    required this.theme,
    required super.child,
  });

  final Theme theme;

  @override
  Widget wrap(BuildContext context, Widget child) => Theme(configuration: theme.configuration, child: child);

  @override
  bool updateShouldNotify(_InheritedTheme old) => theme.configuration != old.theme.configuration;
}
