import 'package:flutter/widgets.dart';

abstract class ToggleablePainter extends ChangeNotifier implements CustomPainter {
  Animation<double> get position => _position!;
  Animation<double>? _position;
  set position(Animation<double> value) {
    if (value == _position) {
      return;
    }
    _position?.removeListener(notifyListeners);
    value.addListener(notifyListeners);
    _position = value;
    notifyListeners();
  }

  Animation<double> get reaction => _reaction!;
  Animation<double>? _reaction;
  set reaction(Animation<double> value) {
    if (value == _reaction) {
      return;
    }
    _reaction?.removeListener(notifyListeners);
    value.addListener(notifyListeners);
    _reaction = value;
    notifyListeners();
  }

  Animation<double> get reactionFocusFade => _reactionFocusFade!;
  Animation<double>? _reactionFocusFade;
  set reactionFocusFade(Animation<double> value) {
    if (value == _reactionFocusFade) {
      return;
    }
    _reactionFocusFade?.removeListener(notifyListeners);
    value.addListener(notifyListeners);
    _reactionFocusFade = value;
    notifyListeners();
  }

  Animation<double> get reactionHoverFade => _reactionHoverFade!;
  Animation<double>? _reactionHoverFade;
  set reactionHoverFade(Animation<double> value) {
    if (value == _reactionHoverFade) {
      return;
    }
    _reactionHoverFade?.removeListener(notifyListeners);
    value.addListener(notifyListeners);
    _reactionHoverFade = value;
    notifyListeners();
  }

  Color get activeColor => _activeColor!;
  Color? _activeColor;
  set activeColor(Color value) {
    if (_activeColor == value) {
      return;
    }
    _activeColor = value;
    notifyListeners();
  }

  Color get inactiveColor => _inactiveColor!;
  Color? _inactiveColor;
  set inactiveColor(Color value) {
    if (_inactiveColor == value) {
      return;
    }
    _inactiveColor = value;
    notifyListeners();
  }

  Color get inactiveReactionColor => _inactiveReactionColor!;
  Color? _inactiveReactionColor;
  set inactiveReactionColor(Color value) {
    if (value == _inactiveReactionColor) {
      return;
    }
    _inactiveReactionColor = value;
    notifyListeners();
  }

  Color get reactionColor => _reactionColor!;
  Color? _reactionColor;
  set reactionColor(Color value) {
    if (value == _reactionColor) {
      return;
    }
    _reactionColor = value;
    notifyListeners();
  }

  Color get hoverColor => _hoverColor!;
  Color? _hoverColor;
  set hoverColor(Color value) {
    if (value == _hoverColor) {
      return;
    }
    _hoverColor = value;
    notifyListeners();
  }

  Color get focusColor => _focusColor!;
  Color? _focusColor;
  set focusColor(Color value) {
    if (value == _focusColor) {
      return;
    }
    _focusColor = value;
    notifyListeners();
  }

  double get splashRadius => _splashRadius!;
  double? _splashRadius;
  set splashRadius(double value) {
    if (value == _splashRadius) {
      return;
    }
    _splashRadius = value;
    notifyListeners();
  }

  Offset? get downPosition => _downPosition;
  Offset? _downPosition;
  set downPosition(Offset? value) {
    if (value == _downPosition) {
      return;
    }
    _downPosition = value;
    notifyListeners();
  }

  bool get isFocused => _isFocused!;
  bool? _isFocused;
  set isFocused(bool? value) {
    if (value == _isFocused) {
      return;
    }
    _isFocused = value;
    notifyListeners();
  }

  bool get isHovered => _isHovered!;
  bool? _isHovered;
  set isHovered(bool? value) {
    if (value == _isHovered) {
      return;
    }
    _isHovered = value;
    notifyListeners();
  }

  void paintRadialReaction({
    required Canvas canvas,
    Offset offset = Offset.zero,
    required Offset origin,
  }) {
    if (!reaction.isDismissed || !reactionFocusFade.isDismissed || !reactionHoverFade.isDismissed) {
      final Paint reactionPaint = Paint()
        ..color = Color.lerp(
          Color.lerp(
            Color.lerp(inactiveReactionColor, reactionColor, position.value),
            hoverColor,
            reactionHoverFade.value,
          ),
          focusColor,
          reactionFocusFade.value,
        )!;
      final radialReactionRadiusTween = Tween<double>(begin: 0.0, end: splashRadius);
      final double reactionRadius = isFocused || isHovered ? splashRadius : radialReactionRadiusTween.evaluate(reaction);
      if (reactionRadius > 0.0) {
        canvas.drawCircle(origin + offset, reactionRadius, reactionPaint);
      }
    }
  }

  @override
  void dispose() {
    _position?.removeListener(notifyListeners);
    _reaction?.removeListener(notifyListeners);
    _reactionFocusFade?.removeListener(notifyListeners);
    _reactionHoverFade?.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool? hitTest(Offset position) => null;

  @override
  SemanticsBuilderCallback? get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
