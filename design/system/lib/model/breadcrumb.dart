import 'package:flutter/widgets.dart';

class BreadcrumbItem {
  final Widget label;
  final double? gap;
  final double? minTouchTargetSize;
  final String? semanticLabel;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;

  const BreadcrumbItem({
    required this.label,
    this.gap,
    this.minTouchTargetSize,
    this.semanticLabel,
    this.onTap,
    this.leading,
    this.trailing,
  });
}
