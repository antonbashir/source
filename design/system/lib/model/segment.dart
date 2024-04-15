import 'package:flutter/widgets.dart';

class Segment {
  final bool autoFocus;
  final bool isFocusable;
  final bool showFocusEffect;
  final FocusNode? focusNode;
  final Color? backgroundColor;
  final Color? selectedSegmentColor;
  final Color? textColor;
  final Color? selectedTextColor;
  final Color? focusEffectColor;
  final Decoration? decoration;
  final String? semanticLabel;
  final ValueChanged<bool>? isSelected;
  final Widget? leading;
  final Widget? label;
  final Widget? trailing;
  final BorderRadiusGeometry? borderRadius;
  final double? gap;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? iconSizeValue;
  final TextStyle? textStyle;
  final Color? selectedColor;

  const Segment({
    this.autoFocus = false,
    this.isFocusable = true,
    this.showFocusEffect = true,
    this.borderRadius,
    this.gap,
    this.padding,
    this.height,
    this.iconSizeValue,
    this.textStyle,
    this.selectedColor,
    this.backgroundColor,
    this.selectedSegmentColor,
    this.textColor,
    this.selectedTextColor,
    this.focusEffectColor,
    this.decoration,
    this.focusNode,
    this.semanticLabel,
    this.isSelected,
    this.leading,
    this.label,
    this.trailing,
  });
}
