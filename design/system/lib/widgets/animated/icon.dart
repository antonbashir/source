import 'package:flutter/widgets.dart';

class AnimatedIconTheme extends ImplicitlyAnimatedWidget {
  final Color? color;
  final double? size;
  final Widget child;

  const AnimatedIconTheme({
    super.key,
    super.onEnd,
    super.curve,
    required super.duration,
    this.color,
    this.size,
    required this.child,
  });

  @override
  AnimatedWidgetBaseState<AnimatedIconTheme> createState() => _AnimatedIconThemeState();
}

class _AnimatedIconThemeState extends AnimatedWidgetBaseState<AnimatedIconTheme> {
  ColorTween? _color;
  SizeTween? _size;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    if (widget.color != null) {
      _color = visitor(_color, widget.color, (dynamic value) => ColorTween(begin: value as Color)) as ColorTween?;
    }

    if (widget.size != null) {
      _size = visitor(_size, Size(widget.size!, widget.size!), (dynamic value) => SizeTween(begin: value as Size)) as SizeTween?;
    }
  }

  @override
  Widget build(BuildContext context) => IconTheme(
        data: IconThemeData(
          color: _color?.evaluate(animation),
          size: _size?.evaluate(animation)?.height,
        ),
        child: widget.child,
      );
}
