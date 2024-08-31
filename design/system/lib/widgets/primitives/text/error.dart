import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/icons/icons.dart';
import 'package:flutter/widgets.dart';

class TextErrorMessage extends StatefulWidget {
  final String errorText;

  const TextErrorMessage({
    super.key,
    required this.errorText,
  });

  @override
  State<TextErrorMessage> createState() => _TextErrorMessageState();
}

class _TextErrorMessageState extends State<TextErrorMessage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: context.transitions.transitionDuration,
      vsync: this,
    );

    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: context.transitions.transitionCurve,
      reverseCurve: context.transitions.transitionCurve.flipped,
    );

    _controller
      ..value = 0.0
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _opacityAnimation,
        child: Row(
          children: [
            Icon(Icons.error, size: context.tokens.spacings.spacing16),
            SizedBox(width: context.tokens.spacings.spacing4),
            Text(widget.errorText),
          ],
        ),
      );
}
