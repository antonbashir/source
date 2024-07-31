import 'package:design/constants/breakpoints.dart';
import 'package:design/constants/buttons.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/primitives/buttons/base.dart';
import 'package:flutter/widgets.dart';

class FilledButton extends StatelessWidget {
  final bool autofocus;
  final bool isFocusable;
  final bool isFullWidth;
  final bool showPulseEffect;
  final bool showScaleEffect;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Decoration? decoration;
  final double? height;
  final double? width;
  final double? minTouchTargetSize;
  final FocusNode? focusNode;
  final BreakpointSize? size;
  final String? semanticLabel;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? leading;
  final Widget? label;
  final Widget? trailing;

  const FilledButton({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.isFullWidth = false,
    this.showPulseEffect = false,
    this.showScaleEffect = true,
    this.borderRadius,
    this.backgroundColor,
    this.decoration,
    this.height,
    this.width,
    this.minTouchTargetSize,
    this.focusNode,
    this.size,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.leading,
    this.label,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) => Button(
        backgroundColor: context.theme.buttonTheme().style.selectColors(ButtonVariant.filled).background,
        autofocus: autofocus,
        isFocusable: isFocusable,
        isFullWidth: isFullWidth,
        showPulseEffect: showPulseEffect,
        showScaleEffect: showScaleEffect,
        variant: ButtonVariant.filled,
        borderRadius: borderRadius,
        height: height,
        width: width,
        minTouchTargetSize: minTouchTargetSize,
        focusNode: focusNode,
        size: size,
        decoration: decoration,
        semanticLabel: semanticLabel,
        onTap: onTap,
        onLongPress: onLongPress,
        label: label,
        leading: leading,
        trailing: trailing,
      );
}
