import 'package:design/constants/breakpoints.dart';
import 'package:design/constants/buttons.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/primitives/buttons/base.dart';
import 'package:flutter/widgets.dart';

class OutlinedButton extends StatelessWidget {
  final bool autofocus;
  final bool isFocusable;
  final bool isFullWidth;
  final bool showPulseEffect;
  final bool showScaleEffect;
  final bool invertColors;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final Decoration? decoration;
  final double? height;
  final double? width;
  final double? minTouchTargetSize;
  final FocusNode? focusNode;
  final BreakpointSize? buttonSize;
  final String? semanticLabel;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? leading;
  final Widget? label;
  final Widget? trailing;

  const OutlinedButton({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.isFullWidth = false,
    this.showPulseEffect = false,
    this.showScaleEffect = true,
    this.invertColors = true,
    this.borderRadius,
    this.borderColor,
    this.decoration,
    this.height,
    this.width,
    this.minTouchTargetSize,
    this.focusNode,
    this.buttonSize,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.label,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) => Button(
        autofocus: autofocus,
        isFocusable: isFocusable,
        isFullWidth: isFullWidth,
        showPulseEffect: showPulseEffect,
        showScaleEffect: showScaleEffect,
        showBorder: true,
        borderRadius: borderRadius,
        borderColor: borderColor,
        height: height,
        width: width,
        minTouchTargetSize: minTouchTargetSize,
        focusNode: focusNode,
        size: buttonSize,
        decoration: decoration,
        semanticLabel: semanticLabel,
        onTap: onTap,
        onLongPress: onLongPress,
        label: label,
        leading: leading,
        trailing: trailing,
        hoverEffectColor: invertColors ? context.theme.buttonTheme().style.selectColors(ButtonVariant.filled).background : null,
        hoverContentColor: invertColors ? context.theme.buttonTheme().style.selectColors(ButtonVariant.filled).content : null,
        variant: ButtonVariant.outline,
      );
}
