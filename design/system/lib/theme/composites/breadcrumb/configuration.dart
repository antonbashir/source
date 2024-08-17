import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class BreadcrumbConfiguration implements ThemeComponent<BreadcrumbConfiguration> {
  final double gap;
  final double itemGap;
  final TextStyle itemTextStyle;
  final TextStyle currentItemTextStyle;
  final TextStyle showMoreItemTextStyle;
  final double showMoreItemsTextSize;
  final double iconSize;
  final double minTouchTargetSize;
  final int visibleItems;

  const BreadcrumbConfiguration({
    required this.gap,
    required this.itemGap,
    required this.itemTextStyle,
    required this.currentItemTextStyle,
    required this.showMoreItemTextStyle,
    required this.iconSize,
    required this.visibleItems,
    required this.minTouchTargetSize,
    required this.showMoreItemsTextSize,
  });

  @override
  BreadcrumbConfiguration copyWith({
    double? gap,
    double? itemGap,
    double? showMoreItemsTextSize,
    TextStyle? itemTextStyle,
    TextStyle? currentItemTextStyle,
    TextStyle? showMoreItemTextStyle,
    double? iconSize,
    int? visibleItems,
    double? minTouchTargetSize,
  }) =>
      BreadcrumbConfiguration(
        gap: gap ?? this.gap,
        showMoreItemsTextSize: showMoreItemsTextSize ?? this.showMoreItemsTextSize,
        itemGap: itemGap ?? this.itemGap,
        itemTextStyle: itemTextStyle ?? this.itemTextStyle,
        currentItemTextStyle: currentItemTextStyle ?? this.currentItemTextStyle,
        showMoreItemTextStyle: showMoreItemTextStyle ?? this.showMoreItemTextStyle,
        iconSize: iconSize ?? this.iconSize,
        visibleItems: visibleItems ?? this.visibleItems,
        minTouchTargetSize: minTouchTargetSize ?? this.minTouchTargetSize,
      );

  @override
  BreadcrumbConfiguration lerp(ThemeComponent<BreadcrumbConfiguration>? other, double t) {
    if (other is! BreadcrumbConfiguration) return this;
    return BreadcrumbConfiguration(
      gap: lerpDouble(gap, other.gap, t)!,
      itemGap: lerpDouble(itemGap, other.itemGap, t)!,
      showMoreItemsTextSize: lerpDouble(showMoreItemsTextSize, other.showMoreItemsTextSize, t)!,
      itemTextStyle: TextStyle.lerp(itemTextStyle, other.itemTextStyle, t)!,
      currentItemTextStyle: TextStyle.lerp(currentItemTextStyle, other.currentItemTextStyle, t)!,
      showMoreItemTextStyle: TextStyle.lerp(showMoreItemTextStyle, other.showMoreItemTextStyle, t)!,
      iconSize: lerpDouble(iconSize, other.iconSize, t)!,
      visibleItems: lerpDouble(visibleItems, other.visibleItems, t)!.toInt(),
      minTouchTargetSize: lerpDouble(minTouchTargetSize, other.minTouchTargetSize, t)!,
    );
  }
}
