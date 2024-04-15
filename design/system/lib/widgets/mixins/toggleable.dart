import 'package:design/constants/toggleable.dart';
import 'package:design/model/state.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

@optionalTypeArgs
mixin ToggleableStateMixin<S extends StatefulWidget> on TickerProviderStateMixin<S> {
  AnimationController get positionController => _positionController;
  late AnimationController _positionController;

  CurvedAnimation get position => _position;
  late CurvedAnimation _position;

  AnimationController get reactionController => _reactionController;
  late AnimationController _reactionController;

  Animation<double> get reaction => _reaction;
  late Animation<double> _reaction;

  Animation<double> get reactionHoverFade => _reactionHoverFade;
  late Animation<double> _reactionHoverFade;
  late AnimationController _reactionHoverFadeController;

  Animation<double> get reactionFocusFade => _reactionFocusFade;
  late Animation<double> _reactionFocusFade;
  late AnimationController _reactionFocusFadeController;

  bool get isInteractive => onChanged != null;

  late final Map<Type, Action<Intent>> _actionMap = <Type, Action<Intent>>{ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: _handleTap)};

  ValueChanged<bool?>? get onChanged;
  bool? get selected;
  bool get tristate;

  @override
  void initState() {
    super.initState();
    _positionController = AnimationController(
      duration: toggleDuration,
      value: selected == false ? 0.0 : 1.0,
      vsync: this,
    );
    _position = CurvedAnimation(
      parent: _positionController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );
    _reactionController = AnimationController(
      duration: toggleRadialReactionDuration,
      vsync: this,
    );
    _reaction = CurvedAnimation(
      parent: _reactionController,
      curve: Curves.fastOutSlowIn,
    );
    _reactionHoverFadeController = AnimationController(
      duration: toggleReactionFadeDuration,
      value: _hovering || _focused ? 1.0 : 0.0,
      vsync: this,
    );
    _reactionHoverFade = CurvedAnimation(
      parent: _reactionHoverFadeController,
      curve: Curves.fastOutSlowIn,
    );
    _reactionFocusFadeController = AnimationController(
      duration: toggleReactionFadeDuration,
      value: _hovering || _focused ? 1.0 : 0.0,
      vsync: this,
    );
    _reactionFocusFade = CurvedAnimation(
      parent: _reactionFocusFadeController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void animateToValue() {
    if (tristate) {
      if (selected == null) {
        _positionController.value = 0.0;
      }
      if (selected ?? true) {
        _positionController.forward();
        return;
      }
      _positionController.reverse();
      return;
    }
    if (selected ?? false) {
      _positionController.forward();
      return;
    }
    _positionController.reverse();
  }

  @override
  void dispose() {
    _positionController.dispose();
    _reactionController.dispose();
    _reactionHoverFadeController.dispose();
    _reactionFocusFadeController.dispose();
    super.dispose();
  }

  Offset? get downPosition => _downPosition;
  Offset? _downPosition;

  void _handleTapDown(TapDownDetails details) {
    if (isInteractive) {
      setState(() => _downPosition = details.localPosition);
      _reactionController.forward();
    }
  }

  void _handleTap([Intent? _]) {
    if (!isInteractive) {
      return;
    }
    switch (selected) {
      case false:
        onChanged!(true);
      case true:
        onChanged!(tristate ? null : false);
      case null:
        onChanged!(false);
    }
    context.findRenderObject()!.sendSemanticsEvent(const TapSemanticEvent());
  }

  void _handleTapEnd([TapUpDetails? _]) {
    if (_downPosition != null) {
      setState(() {
        _downPosition = null;
      });
    }
    _reactionController.reverse();
  }

  bool _focused = false;
  void _handleFocusHighlightChanged(bool focused) {
    if (focused != _focused) {
      setState(() => _focused = focused);
      if (focused) {
        _reactionFocusFadeController.forward();
        return;
      }
      _reactionFocusFadeController.reverse();
    }
  }

  bool _hovering = false;
  void _handleHoverChanged(bool hovering) {
    if (hovering != _hovering) {
      setState(() => _hovering = hovering);
      if (hovering) {
        _reactionHoverFadeController.forward();
        return;
      }
      _reactionHoverFadeController.reverse();
    }
  }

  Set<VisualState> get states => <VisualState>{
        if (!isInteractive) VisualState.disabled,
        if (_hovering) VisualState.hovered,
        if (_focused) VisualState.focused,
        if (selected ?? true) VisualState.selected,
      };

  Widget buildToggleable({
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    bool autofocus = false,
    required VisualStateProperty<MouseCursor> mouseCursor,
    required Size size,
    required CustomPainter painter,
  }) =>
      FocusableActionDetector(
        actions: _actionMap,
        focusNode: focusNode,
        autofocus: autofocus,
        onFocusChange: onFocusChange,
        enabled: isInteractive,
        onShowFocusHighlight: _handleFocusHighlightChanged,
        onShowHoverHighlight: _handleHoverChanged,
        mouseCursor: mouseCursor.resolve(states),
        child: GestureDetector(
          excludeFromSemantics: !isInteractive,
          onTapDown: isInteractive ? _handleTapDown : null,
          onTap: isInteractive ? _handleTap : null,
          onTapUp: isInteractive ? _handleTapEnd : null,
          onTapCancel: isInteractive ? _handleTapEnd : null,
          child: Semantics(
            enabled: isInteractive,
            child: CustomPaint(
              size: size,
              painter: painter,
            ),
          ),
        ),
      );
}
