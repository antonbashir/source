import 'package:design/borders/squircle/border.dart';
import 'package:design/borders/squircle/border_radius.dart';
import 'package:flutter/widgets.dart';

class SquircleClipRect extends StatelessWidget {
  final SquircleBorderRadius radius;
  final Clip clipBehavior;
  final Widget? child;

  const SquircleClipRect({
    super.key,
    required this.child,
    this.radius = SquircleBorderRadius.zero,
    this.clipBehavior = Clip.antiAlias,
  });

  @override
  Widget build(BuildContext context) => ClipPath.shape(
        clipBehavior: clipBehavior,
        shape: SquircleBorder(
          borderRadius: radius,
        ),
        child: child,
      );
}
