import 'package:design/constants/breakpoints.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/primitives/indicators/circular.dart';
import 'package:flutter/widgets.dart';

class CircularProgress extends StatelessWidget {
  final double value;
  final Color? color;
  final Color? backgroundColor;
  final double? sizeValue;
  final double? strokeWidth;
  final BreakpointSize? size;
  final String? semanticLabel;
  final StrokeCap? strokeCap;
  final bool active;

  const CircularProgress({
    super.key,
    required this.value,
    this.active = true,
    this.color,
    this.backgroundColor,
    this.sizeValue,
    this.strokeWidth,
    this.size,
    this.semanticLabel,
    this.strokeCap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? context.theme.circularProgressTheme().style.color;
    final effectiveBackgroundColor = backgroundColor ?? context.theme.circularProgressTheme().style.backgroundColor;
    final effectiveCircularProgressSize = context.theme.circularProgressTheme().configuration.select(size);
    final effectiveSize = sizeValue ?? effectiveCircularProgressSize.progressSizeValue;
    final effectiveStrokeWidth = strokeWidth ?? effectiveCircularProgressSize.progressStrokeWidth;
    final effectiveStrokeCap = strokeCap ?? StrokeCap.butt;

    return Semantics(
      label: semanticLabel,
      value: "${value * 100}%",
      child: SizedBox(
        height: effectiveSize,
        width: effectiveSize,
        child: CircularProgressIndicator(
          active: active,
          color: effectiveColor,
          backgroundColor: effectiveBackgroundColor,
          strokeWidth: effectiveStrokeWidth,
          value: value,
          strokeCap: effectiveStrokeCap,
        ),
      ),
    );
  }
}
