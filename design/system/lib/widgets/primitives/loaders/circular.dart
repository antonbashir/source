import 'package:design/constants/breakpoints.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/primitives/indicators/circular.dart';
import 'package:flutter/widgets.dart';

class CircularLoader extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  final double? sizeValue;
  final double? strokeWidth;
  final BreakpointSize? size;
  final StrokeCap? strokeCap;
  final bool active;

  const CircularLoader({
    super.key,
    this.active = true,
    this.color,
    this.backgroundColor,
    this.sizeValue,
    this.strokeWidth,
    this.size,
    this.strokeCap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveLoaderSize = context.theme.circularLoaderTheme().configuration.select(size);
    final effectiveColor = color ?? context.theme.circularLoaderTheme().style.color;
    final effectiveBackgroundColor = backgroundColor ?? context.theme.circularLoaderTheme().style.backgroundColor;
    final effectiveSize = sizeValue ?? effectiveLoaderSize.loaderSizeValue;
    final effectiveStrokeWidth = strokeWidth ?? effectiveLoaderSize.loaderStrokeWidth;
    final effectiveStrokeCap = strokeCap ?? StrokeCap.butt;

    return SizedBox(
      height: effectiveSize,
      width: effectiveSize,
      child: CircularProgressIndicator(
        active: active,
        color: effectiveColor,
        backgroundColor: effectiveBackgroundColor,
        strokeWidth: effectiveStrokeWidth,
        strokeCap: effectiveStrokeCap,
      ),
    );
  }
}
