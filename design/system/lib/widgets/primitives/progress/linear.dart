import 'package:design/constants/breakpoints.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/primitives/indicators/linear.dart';
import 'package:design/widgets/primitives/pins/progress.dart';
import 'package:flutter/widgets.dart';

class LinearProgress extends StatelessWidget {
  final bool showPin;
  final bool showMinLabel;
  final bool showMaxLabel;
  final double value;
  final bool pinAffectsHeight;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? verticalGap;
  final BreakpointSize? size;
  final String? semanticLabel;
  final Widget? minLabel;
  final Widget? maxLabel;
  final TextStyle? textStyle;
  final double? pinShadowElevation;
  final double? pinArrowHeight;
  final double? pinArrowWidth;
  final double? pinDistance;
  final double? pinWidth;
  final double? pinBorderWidth;
  final double? pinThumbSizeValue;
  final bool? pinShowShadow;
  final Color? pinColor;
  final Color? pinBorderColor;
  final Color? pinThumbColor;
  final Color? pinShadowColor;
  final Color? pinTextColor;
  final TextStyle? pinTextStyle;
  final Duration? indeterminateDuration;

  const LinearProgress({
    super.key,
    required this.value,
    this.showPin = false,
    this.showMinLabel = false,
    this.showMaxLabel = false,
    this.pinAffectsHeight = true,
    this.borderRadius,
    this.color,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
    this.verticalGap,
    this.size,
    this.semanticLabel,
    this.minLabel,
    this.maxLabel,
    this.textStyle,
    this.pinShadowElevation,
    this.pinArrowHeight,
    this.pinArrowWidth,
    this.pinDistance,
    this.pinWidth,
    this.pinBorderWidth,
    this.pinThumbSizeValue,
    this.pinShowShadow,
    this.pinColor,
    this.pinBorderColor,
    this.pinThumbColor,
    this.pinShadowColor,
    this.pinTextColor,
    this.pinTextStyle,
    this.indeterminateDuration,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveProgressSize = context.theme.linearProgressTheme().configuration.select(size);
    final effectiveBorderRadius = borderRadius ?? effectiveProgressSize.borderRadius;
    final progressRadius = switch (effectiveBorderRadius) {
      BorderRadiusDirectional() when showPin == true => BorderRadiusDirectional.only(
          topStart: effectiveBorderRadius.topStart,
          bottomStart: effectiveBorderRadius.bottomStart,
        ),
      BorderRadius() when showPin == true => BorderRadiusDirectional.only(
          topStart: effectiveBorderRadius.topLeft,
          bottomStart: effectiveBorderRadius.bottomLeft,
        ),
      _ => effectiveBorderRadius,
    };
    final effectiveTextStyle = textStyle ?? effectiveProgressSize.textStyle;
    final effectiveColor = color ?? context.theme.linearProgressTheme().style.color;
    final effectiveBackgroundColor = backgroundColor ?? context.theme.linearProgressTheme().style.backgroundColor;
    final effectiveTextColor = textColor ?? context.theme.linearProgressTheme().style.textColor;
    final effectiveHeight = height ?? effectiveProgressSize.progressHeight;
    final effectiveVerticalGap = verticalGap ?? effectiveProgressSize.verticalGap;
    final effectivePinThumbSizeValue = pinThumbSizeValue ?? effectiveProgressSize.thumbSizeValue;
    final effectivePinWidth = pinWidth ?? context.theme.progressPinTheme().configuration.pinWidth;
    final effectivePinBorderWidth = pinBorderWidth ?? context.theme.progressPinTheme().configuration.pinBorderWidth;
    final effectivePinDistance = pinDistance ?? context.theme.progressPinTheme().configuration.pinDistance;
    final effectivePinArrowHeight = pinArrowHeight ?? context.theme.progressPinTheme().configuration.arrowHeight;
    final effectivePinArrowWidth = pinArrowWidth ?? context.theme.progressPinTheme().configuration.arrowWidth;
    final effectivePinColor = pinColor ?? context.theme.progressPinTheme().style.pinColor;
    final effectivePinBorderColor = pinBorderColor ?? context.theme.progressPinTheme().style.pinBorderColor;
    final effectivePinThumbColor = pinThumbColor ?? context.theme.progressPinTheme().style.thumbColor;
    final effectivePinShowShadow = pinShowShadow ?? context.theme.progressPinTheme().style.showShadow;
    final effectivePinShadowColor = pinShadowColor ?? context.theme.progressPinTheme().style.shadowColor;
    final effectivePinTextColor = pinTextColor ?? context.theme.progressPinTheme().style.textColor;
    final effectivePinShadowElevation = pinShadowElevation ?? context.theme.progressPinTheme().style.shadowElevation;
    final effectivePinTextStyle = pinTextStyle ?? context.theme.progressPinTheme().configuration.textStyle;
    final double resolvedPaddingValue = effectivePinThumbSizeValue - effectiveHeight > 0 ? effectivePinThumbSizeValue / 2 - effectiveHeight / 2 : 0;
    final heightWithPin = effectivePinWidth + effectivePinArrowHeight + effectivePinDistance + effectivePinThumbSizeValue;

    Widget child = LinearProgressIndicator(
      value: value,
      color: effectiveColor,
      backgroundColor: effectiveBackgroundColor,
      containerRadius: effectiveBorderRadius,
      progressRadius: showPin ? progressRadius : effectiveBorderRadius,
      minHeight: effectiveHeight,
    );

    if (showPin) {
      child = ProgressPin(
        progressValue: value,
        text: '${(value * 100).round()}%',
        showShadow: effectivePinShowShadow,
        color: effectivePinColor,
        borderColor: effectivePinBorderColor,
        thumbColor: effectivePinThumbColor,
        shadowColor: effectivePinShadowColor,
        textColor: effectivePinTextColor,
        shadowElevation: effectivePinShadowElevation,
        arrowHeight: effectivePinArrowHeight,
        arrowWidth: effectivePinArrowWidth,
        distance: effectivePinDistance,
        width: effectivePinWidth,
        borderWidth: effectivePinBorderWidth,
        textStyle: effectivePinTextStyle,
        child: child,
      );
    }

    if (showMinLabel || showMaxLabel) {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showMinLabel)
                Expanded(
                  child: DefaultTextStyle(
                    style: effectiveTextStyle.copyWith(color: effectiveTextColor),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: minLabel ?? const Text("0%"),
                    ),
                  ),
                ),
              if (showMaxLabel)
                Expanded(
                  child: DefaultTextStyle(
                    style: effectiveTextStyle.copyWith(color: effectiveTextColor),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: maxLabel ?? const Text("100%"),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: effectiveVerticalGap),
          child,
        ],
      );
    }

    if (showPin && pinAffectsHeight) {
      child = Container(
        height: heightWithPin,
        padding: EdgeInsets.only(bottom: resolvedPaddingValue),
        alignment: Alignment.bottomCenter,
        child: child,
      );
    }

    if (width != null) {
      child = SizedBox(width: width, child: child);
    }

    return Semantics(
      label: semanticLabel,
      value: "${value * 100}%",
      child: child,
    );
  }
}
