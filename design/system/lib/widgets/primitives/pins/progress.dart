import 'package:design/extensions/extensions.dart';
import 'package:design/painters/progress/pin.dart';
import 'package:flutter/widgets.dart';

class ProgressPin extends StatelessWidget {
  final double progressValue;
  final String text;
  final Widget child;
  final bool? showShadow;
  final Color? color;
  final Color? borderColor;
  final Color? thumbColor;
  final Color? shadowColor;
  final Color? textColor;
  final double? shadowElevation;
  final double? arrowHeight;
  final double? arrowWidth;
  final double? distance;
  final double? width;
  final double? borderWidth;
  final TextStyle? textStyle;

  const ProgressPin({
    super.key,
    required this.progressValue,
    required this.text,
    required this.child,
    this.showShadow,
    this.color,
    this.borderColor,
    this.thumbColor,
    this.shadowColor,
    this.textColor,
    this.shadowElevation,
    this.arrowHeight,
    this.arrowWidth,
    this.distance,
    this.width,
    this.borderWidth,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final effectivePinColor = color ?? context.theme.progressPinTheme().style.pinColor;
    final effectivePinBorderColor = borderColor ?? context.theme.progressPinTheme().style.pinBorderColor;
    final effectiveThumbColor = thumbColor ?? context.theme.progressPinTheme().style.thumbColor;
    final effectiveShadowColor = shadowColor ?? context.theme.progressPinTheme().style.shadowColor;
    final effectiveTextColor = textColor ?? context.theme.progressPinTheme().style.textColor;
    final effectiveTextStyle = textStyle ?? context.theme.progressPinTheme().configuration.textStyle;
    final effectivePinWidth = width ?? context.theme.progressPinTheme().configuration.pinWidth;
    final effectivePinBorderWidth = borderWidth ?? context.theme.progressPinTheme().configuration.pinBorderWidth;
    final effectivePinDistance = distance ?? context.theme.progressPinTheme().configuration.pinDistance;
    final effectiveArrowHeight = arrowHeight ?? context.theme.progressPinTheme().configuration.arrowHeight;
    final effectiveArrowWidth = arrowWidth ?? context.theme.progressPinTheme().configuration.arrowWidth;
    final effectiveShadowElevation = shadowElevation ?? context.theme.progressPinTheme().style.shadowElevation;
    final effectiveTextDirection = Directionality.of(context);

    return CustomPaint(
      foregroundPainter: ProgressPinPainter(
        showShadow: showShadow ?? true,
        pinColor: effectivePinColor,
        thumbColor: effectiveThumbColor,
        shadowColor: effectiveShadowColor,
        pinBorderColor: effectivePinBorderColor,
        pinBorderWidth: effectivePinBorderWidth,
        arrowHeight: effectiveArrowHeight,
        arrowWidth: effectiveArrowWidth,
        pinDistance: effectivePinDistance,
        pinWidth: effectivePinWidth,
        progressValue: progressValue,
        shadowElevation: effectiveShadowElevation,
        pinText: text,
        textDirection: effectiveTextDirection,
        textStyle: effectiveTextStyle.copyWith(color: effectiveTextColor),
      ),
      child: child,
    );
  }
}
