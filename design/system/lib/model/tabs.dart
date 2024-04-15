import 'package:flutter/widgets.dart';

class Tab {
  final bool disabled;
  final bool autoFocus;
  final bool isFocusable;
  final bool showFocusEffect;
  final FocusNode? focusNode;
  final Color? focusEffectColor;
  final Color? indicatorColor;
  final Color? textColor;
  final Color? selectedTextColor;
  final Decoration? decoration;
  final double? indicatorHeight;
  final double? gap;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final String? semanticLabel;
  final ValueChanged<bool>? isSelected;
  final Widget? leading;
  final Widget? label;
  final Widget? trailing;
  final double? minTouchTargetSize;

  const Tab({
    this.disabled = false,
    this.autoFocus = false,
    this.isFocusable = true,
    this.showFocusEffect = true,
    this.focusNode,
    this.minTouchTargetSize,
    this.focusEffectColor,
    this.indicatorColor,
    this.textColor,
    this.selectedTextColor,
    this.decoration,
    this.indicatorHeight,
    this.gap,
    this.padding,
    this.textStyle,
    this.semanticLabel,
    this.isSelected,
    this.leading,
    this.label,
    this.trailing,
  });
}

class PillTab {
  final bool disabled;
  final bool autoFocus;
  final bool isFocusable;
  final bool showFocusEffect;
  final FocusNode? focusNode;
  final BorderRadiusGeometry? borderRadius;
  final Color? focusEffectColor;
  final Color? selectedTabColor;
  final Color? textColor;
  final Color? selectedTextColor;
  final Decoration? decoration;
  final double? gap;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final String? semanticLabel;
  final ValueChanged<bool>? isSelected;
  final Widget? leading;
  final Widget? label;
  final Widget? trailing;
  final double? minTouchTargetSize;

  const PillTab({
    this.disabled = false,
    this.autoFocus = false,
    this.isFocusable = true,
    this.showFocusEffect = true,
    this.focusNode,
    this.minTouchTargetSize,
    this.borderRadius,
    this.focusEffectColor,
    this.selectedTabColor,
    this.textColor,
    this.selectedTextColor,
    this.decoration,
    this.gap,
    this.padding,
    this.textStyle,
    this.semanticLabel,
    this.isSelected,
    this.leading,
    this.label,
    this.trailing,
  });
}

class SidebarTab {
  final bool disabled;
  final bool autoFocus;
  final bool isFocusable;
  final bool showFocusEffect;
  final FocusNode? focusNode;
  final BorderRadiusGeometry? borderRadius;
  final Color? focusEffectColor;
  final Color? selectedTabColor;
  final Color? textColor;
  final Color? selectedTextColor;
  final Decoration? decoration;
  final double? gap;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final String? semanticLabel;
  final ValueChanged<bool>? isSelected;
  final Widget? leading;
  final Widget? label;
  final Widget? trailing;
  final double? minTouchTargetSize;

  SidebarTab({
    this.disabled = false,
    this.autoFocus = false,
    this.isFocusable = true,
    this.showFocusEffect = true,
    this.focusNode,
    this.minTouchTargetSize,
    this.borderRadius,
    this.focusEffectColor,
    this.selectedTabColor,
    this.textColor,
    this.selectedTextColor,
    this.decoration,
    this.gap,
    this.padding,
    this.textStyle,
    this.semanticLabel,
    this.isSelected,
    this.leading,
    this.label,
    this.trailing,
  });
}
