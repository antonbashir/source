import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class SidebarStyle implements ThemeComponent<SidebarStyle> {
  final Color tabBarBackgroundColor;
  final List<BoxShadow> shadows;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final Color tabTextColor;
  final Color selectedTextColor;
  final Color selectedTabColor;
  final Color tabBarBorderColor;

  const SidebarStyle({
    required this.tabTextColor,
    required this.selectedTextColor,
    required this.selectedTabColor,
    required this.tabBarBackgroundColor,
    required this.shadows,
    required this.transitionCurve,
    required this.transitionDuration,
    required this.tabBarBorderColor,
  });

  @override
  SidebarStyle copyWith({
    Color? contentColor,
    Color? iconColor,
    Color? tabBarBackgroundColor,
    Color? barrierColor,
    List<BoxShadow>? shadows,
    Duration? transitionDuration,
    Curve? transitionCurve,
    Color? tabTextColor,
    Color? selectedTextColor,
    Color? selectedTabColor,
    Color? tabBarBorderColor,
  }) =>
      SidebarStyle(
        tabTextColor: tabTextColor ?? this.tabTextColor,
        selectedTextColor: selectedTextColor ?? this.selectedTextColor,
        selectedTabColor: selectedTabColor ?? this.selectedTabColor,
        tabBarBackgroundColor: tabBarBackgroundColor ?? this.tabBarBackgroundColor,
        shadows: shadows ?? this.shadows,
        transitionDuration: transitionDuration ?? this.transitionDuration,
        transitionCurve: transitionCurve ?? this.transitionCurve,
        tabBarBorderColor: tabBarBorderColor ?? this.tabBarBorderColor,
      );

  @override
  SidebarStyle lerp(ThemeComponent<SidebarStyle>? other, double t) {
    if (other is! SidebarStyle) return this;
    return SidebarStyle(
      tabTextColor: Color.lerp(tabTextColor, other.tabTextColor, t)!,
      selectedTextColor: Color.lerp(selectedTextColor, other.selectedTextColor, t)!,
      selectedTabColor: Color.lerp(selectedTabColor, other.selectedTabColor, t)!,
      tabBarBackgroundColor: Color.lerp(tabBarBackgroundColor, other.tabBarBackgroundColor, t)!,
      shadows: BoxShadow.lerpList(shadows, other.shadows, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      tabBarBorderColor: Color.lerp(tabBarBorderColor, other.tabBarBorderColor, t)!,
    );
  }
}
