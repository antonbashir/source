import 'package:flutter/widgets.dart';

class AnimatedDefaultTextStyle extends StatefulWidget {
  final TextStyle textStyle;
  final Duration duration;
  final Curve curve;
  final Widget child;

  const AnimatedDefaultTextStyle({
    super.key,
    required this.textStyle,
    required this.duration,
    required this.curve,
    required this.child,
  });

  @override
  State<AnimatedDefaultTextStyle> createState() => _AnimatedDefaultTextStyleState();
}

class _AnimatedDefaultTextStyleState extends State<AnimatedDefaultTextStyle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _textStyleAnimation;
  late TextStyleTween _textStyle;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    
    _textStyleAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _textStyle = TextStyleTween(
      begin: widget.textStyle,
      end: widget.textStyle,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedDefaultTextStyle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.textStyle != oldWidget.textStyle) {
      _textStyle = TextStyleTween(
        begin: oldWidget.textStyle,
        end: widget.textStyle,
      );
      _controller
        ..value = 0.0
        ..forward();
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _textStyleAnimation,
        builder: (context, child) => DefaultTextStyle(
          style: _textStyle.evaluate(_textStyleAnimation),
          child: child!,
        ),
        child: widget.child,
      );
}
