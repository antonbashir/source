import 'package:design/constants/breakpoints.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/primitives/indicators/linear.dart';
import 'package:flutter/widgets.dart';

class LinearLoader extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final Color? backgroundColor;
  final double? height;
  final BreakpointSize? size;
  final double? width;

  const LinearLoader({
    super.key,
    this.borderRadius,
    this.color,
    this.backgroundColor,
    this.height,
    this.width,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveLoaderConfiguration = context.theme.linearLoaderTheme().configuration.select(size);
    final effectiveBorderRadius = borderRadius ?? effectiveLoaderConfiguration.borderRadius;
    final effectiveColor = color ?? context.theme.linearLoaderTheme().style.color;
    final effectiveBackgroundColor = backgroundColor ?? context.theme.linearLoaderTheme().style.backgroundColor;
    final effectiveHeight = height ?? effectiveLoaderConfiguration.loaderHeight;

    if (width != null) {
      return SizedBox(
        width: width,
        child: LinearProgressIndicator(
          color: effectiveColor,
          backgroundColor: effectiveBackgroundColor,
          containerRadius: effectiveBorderRadius,
          progressRadius: effectiveBorderRadius,
          minHeight: effectiveHeight,
        ),
      );
    }

    return LinearProgressIndicator(
      color: effectiveColor,
      backgroundColor: effectiveBackgroundColor,
      containerRadius: effectiveBorderRadius,
      progressRadius: effectiveBorderRadius,
      minHeight: effectiveHeight,
    );
  }
}
