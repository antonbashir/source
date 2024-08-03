import 'package:design/constants/breakpoints.dart';
import 'package:design/constants/buttons.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/primitives/buttons/base.dart';
import 'package:flutter/widgets.dart';

class TextButton extends StatelessWidget {
  final bool autofocus;
  final bool isFocusable;
  final bool isFullWidth;
  final bool showPulseEffect;
  final bool showScaleEffect;
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

  const TextButton({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.isFullWidth = false,
    this.showPulseEffect = false,
    this.showScaleEffect = true,
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
  Widget build(BuildContext context) {
    final effectiveTextColor = context.theme.buttonTheme().style.selectColors(ButtonVariant.text).content;
    final effectiveHoverTextColor = context.theme.buttonTheme().style.selectColors(ButtonVariant.text).hoverContent;
    final effectiveHoverColor = context.theme.buttonTheme().style.selectColors(ButtonVariant.text).hover;
    final effectiveFocusColor = context.theme.buttonTheme().style.selectColors(ButtonVariant.text).focus;
    return Button(
      autofocus: autofocus,
      isFocusable: isFocusable,
      isFullWidth: isFullWidth,
      showPulseEffect: showPulseEffect,
      showScaleEffect: showScaleEffect,
      contentColor: effectiveTextColor,
      hoverContentColor: effectiveHoverTextColor,
      hoverEffectColor: effectiveHoverColor,
      focusEffectColor: effectiveFocusColor,
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
      variant: ButtonVariant.text,
    );
  }
}
