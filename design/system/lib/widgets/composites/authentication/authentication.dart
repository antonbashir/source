import 'dart:async';

import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/constants.dart';
import 'package:design/constants/delays.dart';
import 'package:design/constants/text.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/theme/tokens/colors.dart';
import 'package:design/widgets/primitives/text/form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

typedef AuthenticationCodeErrorBuilder = Widget Function(BuildContext context, String? errorText);

class AuthenticationCode extends StatefulWidget {
  final bool autoDismissKeyboard;
  final bool autoFocus;
  final bool autoUnfocus;
  final bool enabled;
  final bool enableInputFill;
  final bool obscureText;
  final bool peekWhenObscuring;
  final bool showAuthFieldCursor;
  final bool useHapticFeedback;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final AuthenticationCodeErrorBuilder errorBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final int fields;
  final AuthenticationCodeFieldShape? fieldShape;
  final BorderRadiusGeometry? borderRadius;
  final Color? authFieldCursorColor;
  final Color? selectedBorderColor;
  final Color? activeBorderColor;
  final Color? inactiveBorderColor;
  final Color? errorBorderColor;
  final Color? selectedFillColor;
  final Color? activeFillColor;
  final Color? inactiveFillColor;
  final double? borderWidth;
  final double? disabledOpacityValue;
  final double? gap;
  final double? fieldHeight;
  final double? fieldWidth;
  final double? height;
  final double? width;
  final Duration? animationDuration;
  final Duration? errorAnimationDuration;
  final Duration? peekDuration;
  final Curve? animationCurve;
  final Curve? errorAnimationCurve;
  final AuthenticationCodeErrorAnimationType errorAnimationType;
  final FocusNode? focusNode;
  final List<BoxShadow>? boxShadows;
  final List<BoxShadow>? activeBoxShadows;
  final List<BoxShadow>? inActiveBoxShadows;
  final String? errorText;
  final String? hintCharacter;
  final String obscuringCharacter;
  final String? semanticLabel;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextStyle? errorTextStyle;
  final TextEditingController? textController;
  final FormFieldValidator<String> validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final Widget? obscuringWidget;

  const AuthenticationCode({
    super.key,
    required this.validator,
    required this.errorBuilder,
    this.fieldShape = AuthenticationCodeFieldShape.box,
    this.autoDismissKeyboard = true,
    this.autoFocus = false,
    this.autoUnfocus = true,
    this.enabled = true,
    this.enableInputFill = false,
    this.obscureText = false,
    this.peekWhenObscuring = false,
    this.showAuthFieldCursor = true,
    this.useHapticFeedback = false,
    this.errorAnimationType = AuthenticationCodeErrorAnimationType.nothing,
    this.fields = defaultAuthenticationInputFieldCount,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.obscuringCharacter = boldDot,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.visiblePassword,
    this.borderRadius,
    this.authFieldCursorColor,
    this.selectedBorderColor,
    this.activeBorderColor,
    this.inactiveBorderColor,
    this.errorBorderColor,
    this.selectedFillColor,
    this.activeFillColor,
    this.inactiveFillColor,
    this.borderWidth,
    this.disabledOpacityValue,
    this.gap,
    this.fieldHeight,
    this.fieldWidth,
    this.height,
    this.width,
    this.animationDuration,
    this.errorAnimationDuration,
    this.peekDuration,
    this.animationCurve,
    this.errorAnimationCurve,
    this.focusNode,
    this.boxShadows,
    this.activeBoxShadows,
    this.inActiveBoxShadows,
    this.hintCharacter,
    this.semanticLabel,
    this.errorText,
    this.hintStyle,
    this.textStyle,
    this.errorTextStyle,
    this.textController,
    this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    this.onEditingComplete,
    this.obscuringWidget,
  })  : assert(fields > 0),
        assert(fieldHeight == null || fieldHeight > 0),
        assert(fieldWidth == null || fieldWidth > 0);

  @override
  State<AuthenticationCode> createState() => _AuthenticationCodeState();
}

class _AuthenticationCodeState extends State<AuthenticationCode> with TickerProviderStateMixin {
  late FocusNode _focusNode;
  late List<String> _inputList;

  late BorderRadiusGeometry _effectiveBorderRadius;
  late Color _effectiveSelectedBorderColor;
  late Color _effectiveActiveBorderColor;
  late Color _effectiveInactiveBorderColor;
  late Color _effectiveErrorBorderColor;
  late Color _effectiveSelectedFillColor;
  late Color _effectiveActiveFillColor;
  late Color _effectiveInactiveFillColor;
  late Color _effectiveTextColor;
  late Color _effectiveCursorColor;
  late double _effectiveBorderWidth;
  late double _effectiveGap;
  late double _effectiveHeight;
  late double _effectiveWidth;
  late TextStyle _effectiveTextStyle;
  late TextStyle _effectiveErrorTextStyle;

  late TextEditingController _textEditingController;
  late AnimationController _cursorController;
  late Animation<double> _cursorAnimation;

  AnimationController? _errorAnimationController;
  Animation<Offset>? _errorOffsetAnimation;

  Duration? _peekDuration;
  Duration? _animationDuration;
  Curve? _animationCurve;

  bool _isInErrorMode = false;
  bool _hasPeeked = false;
  int _selectedIndex = 0;
  Timer? _peekDebounce;

  TextStyle get _resolvedTextStyle => _effectiveTextStyle.merge(widget.textStyle).copyWith(color: _isInErrorMode ? _resolvedErrorTextStyle.color : widget.textStyle?.color ?? _effectiveTextColor);
  TextStyle get _hintStyle => _resolvedTextStyle.merge(widget.hintStyle);
  TextStyle get _resolvedErrorTextStyle => _effectiveErrorTextStyle.merge(widget.errorTextStyle).copyWith(color: widget.errorTextStyle?.color ?? _effectiveErrorBorderColor);
  Color get _resolvedErrorCursorColor => _isInErrorMode ? _resolvedErrorTextStyle.color ?? _effectiveErrorBorderColor : _effectiveCursorColor;

  void _initializeFields() {
    _initializeFocusNode();
    _initializeInputList();
    _initializeErrorAnimationListener();
    _initializeTextEditingController();
    _initializeAuthFieldCursor();
  }

  void _initializeFocusNode() {
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() => _setState(() {}));
  }

  void _initializeInputList() {
    _inputList = List<String>.filled(widget.fields, '');
  }

  void _initializeTextEditingController() {
    _textEditingController = widget.textController ?? TextEditingController();

    _textEditingController.addListener(() {
      if (_validateInput() != null) {
        if (widget.errorAnimationType == AuthenticationCodeErrorAnimationType.shake) {
          _errorAnimationController!.forward();

          if (widget.useHapticFeedback) HapticFeedback.lightImpact();
        }
        if (!_isInErrorMode) _setState(() => _isInErrorMode = true);
      } else {
        if (_isInErrorMode && widget.errorText == null) _setState(() => _isInErrorMode = false);
      }

      _debounceBlink();

      String currentText = _textEditingController.text;
      if (widget.enabled && _inputList.join() != currentText) {
        if (currentText.length >= widget.fields) {
          if (widget.onCompleted != null) {
            if (currentText.length > widget.fields) {
              currentText = currentText.substring(0, widget.fields);
            }
            Future.delayed(smallDelay, () => widget.onCompleted!(currentText));
          }
          if (widget.autoDismissKeyboard) _focusNode.unfocus();
        }
        widget.onChanged?.call(currentText);
      }

      _updateTextField(currentText);
    });

    if (_textEditingController.text.isNotEmpty) _updateTextField(_textEditingController.text);
  }

  void _initializeAuthFieldCursor() {
    _cursorController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _cursorAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _cursorController,
        curve: Curves.easeInOut,
      ),
    );
    if (widget.showAuthFieldCursor) _cursorController.repeat();
  }

  void _initializeErrorAnimationListener() {
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (!mounted) return;
      _errorAnimationController!.addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) _errorAnimationController!.reverse();
      });
    });
  }

  void _debounceBlink() {
    _hasPeeked = true;
    if (widget.peekWhenObscuring && _textEditingController.text.length > _inputList.where((x) => x.isNotEmpty).length) {
      _setState(() => _hasPeeked = false);
      if (_peekDebounce?.isActive ?? false) _peekDebounce!.cancel();
      _peekDebounce = Timer(_peekDuration!, () {
        _setState(() => _hasPeeked = true);
      });
    }
  }

  void _onFocus() {
    if (widget.autoUnfocus) {
      if (_focusNode.hasFocus && MediaQuery.of(context).viewInsets.bottom == 0) {
        _focusNode.unfocus();
        Future.delayed(microDelay, () => _focusNode.requestFocus());
      }
      _focusNode.requestFocus();
      return;
    }
    _focusNode.requestFocus();
  }

  Color _getBorderColorFromIndex(int index) {
    if (((_selectedIndex == index) || (_selectedIndex == index + 1 && index + 1 == widget.fields)) && _focusNode.hasFocus) {
      return _isInErrorMode ? _effectiveErrorBorderColor : _effectiveSelectedBorderColor;
    }

    if (_selectedIndex > index) {
      return _isInErrorMode ? _effectiveErrorBorderColor : _effectiveActiveBorderColor;
    }

    return _isInErrorMode ? _effectiveErrorBorderColor : _effectiveInactiveBorderColor;
  }

  Color _getFillColorFromIndex(int index) {
    if (((_selectedIndex == index) || (_selectedIndex == index + 1 && index + 1 == widget.fields)) && _focusNode.hasFocus) {
      return _effectiveSelectedFillColor;
    }

    if (_selectedIndex > index) {
      return _effectiveActiveFillColor;
    }

    return _effectiveInactiveFillColor;
  }

  double _getBorderWidthFromIndex(int index) {
    if (((_selectedIndex == index) || (_selectedIndex == index + 1 && index + 1 == widget.fields)) && _focusNode.hasFocus) {
      return _effectiveBorderWidth + 1;
    }
    return _effectiveBorderWidth;
  }

  List<BoxShadow>? _getBoxShadowFromIndex(int index) {
    if (_selectedIndex == index) {
      return widget.activeBoxShadows;
    }

    if (_selectedIndex > index) {
      return widget.inActiveBoxShadows;
    }

    return [];
  }

  ShapeBorder _getAuthInputFieldShape({required int elementIndex}) {
    final borderSide = BorderSide(
      color: _getBorderColorFromIndex(elementIndex),
      width: _getBorderWidthFromIndex(elementIndex),
    );
    return switch (widget.fieldShape) {
      AuthenticationCodeFieldShape.circle => CircleBorder(side: borderSide),
      AuthenticationCodeFieldShape.underline => Border(bottom: borderSide),
      _ => SquircleBorder(
          borderRadius: _effectiveBorderRadius.squircle(context),
          side: borderSide,
        )
    };
  }

  Future<void> _updateTextField(String text) async {
    final updatedList = List<String>.filled(widget.fields, '');

    for (var i = 0; i < widget.fields; i++) {
      updatedList[i] = text.length > i ? text[i] : '';
    }

    _setState(() {
      _selectedIndex = text.length;
      _inputList = updatedList;
    });
  }

  String? _validateInput() => widget.validator.call(_textEditingController.text);

  void _setState(void Function() function) {
    if (mounted) setState(function);
  }

  @override
  void initState() {
    super.initState();
    _isInErrorMode = widget.errorText != null;
    _initializeFields();
  }

  @override
  void didUpdateWidget(AuthenticationCode oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.errorText != widget.errorText) {
      _setState(() {
        _isInErrorMode = widget.errorText != null || _validateInput() != null;
      });
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _errorAnimationController!.dispose();
    _cursorController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<Widget> _generateAuthInputFields() {
    final authInputFields = <Widget>[];

    for (var i = 0; i < widget.fields; i++) {
      authInputFields.add(
        Padding(
          padding: EdgeInsetsDirectional.only(end: i == widget.fields - 1 ? 0 : _effectiveGap),
          child: RepaintBoundary(
            child: Container(
              width: _effectiveWidth,
              height: _effectiveHeight,
              decoration: ShapeDecoration(
                shape: _getAuthInputFieldShape(elementIndex: i),
                color: widget.enableInputFill ? _getFillColorFromIndex(i) : Colors.transparent,
                shadows: (widget.activeBoxShadows != null || widget.inActiveBoxShadows != null) ? _getBoxShadowFromIndex(i) : widget.boxShadows,
              ),
              child: Center(
                child: _buildChild(i),
              ),
            ),
          ),
        ),
      );
    }

    return authInputFields;
  }

  Widget _buildChild(int index) {
    if (((_selectedIndex == index) || (_selectedIndex == index + 1 && index + 1 == widget.fields)) && _focusNode.hasFocus && widget.showAuthFieldCursor) {
      final double cursorHeight = _resolvedTextStyle.fontSize!;
      if (_selectedIndex == index + 1 && index + 1 == widget.fields) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: _resolvedTextStyle.fontSize! / 1.5),
                child: FadeTransition(
                  opacity: _cursorAnimation,
                  child: CustomPaint(
                    size: Size(0, cursorHeight),
                    painter: _CursorPainter(
                      cursorColor: _resolvedErrorCursorColor,
                    ),
                  ),
                ),
              ),
            ),
            _renderAuthInputFieldText(index: index),
          ],
        );
      }
      return Center(
        child: FadeTransition(
          opacity: _cursorAnimation,
          child: CustomPaint(
            size: Size(0, cursorHeight),
            painter: _CursorPainter(
              cursorColor: _resolvedErrorCursorColor,
            ),
          ),
        ),
      );
    }
    return _renderAuthInputFieldText(index: index);
  }

  Widget _renderAuthInputFieldText({@required int? index}) {
    assert(index != null);

    final bool showObscured = !widget.peekWhenObscuring || (widget.peekWhenObscuring && _hasPeeked) || index != _inputList.where((x) => x.isNotEmpty).length - 1;

    if (widget.obscuringWidget != null && showObscured && _inputList[index!].isNotEmpty) {
      return widget.obscuringWidget!;
    }

    if (_inputList[index!].isEmpty && widget.hintCharacter != null) {
      return Text(
        widget.hintCharacter!,
        key: ValueKey(_inputList[index]),
        style: _hintStyle,
      );
    }

    final String text = widget.obscureText && _inputList[index].isNotEmpty && showObscured ? widget.obscuringCharacter : _inputList[index];

    return Text(
      text,
      key: ValueKey(_inputList[index]),
      style: _resolvedTextStyle,
    );
  }

  Widget _getTextFormField() => Directionality(
        textDirection: Directionality.of(context),
        child: SizedBox(
          height: _effectiveHeight,
          child: FormTextInput(
            minLines: 1,
            backgroundColor: Colors.transparent,
            hoverBorderColor: Colors.transparent,
            activeBorderColor: Colors.transparent,
            inactiveBorderColor: Colors.transparent,
            autocorrect: false,
            autofocus: widget.autoFocus,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _textEditingController,
            cursorWidth: 0.01,
            enabled: widget.enabled,
            enableInteractiveSelection: false,
            enableSuggestions: false,
            focusNode: _focusNode,
            inputFormatters: [LengthLimitingTextInputFormatter(widget.fields)],
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            onSubmitted: widget.onSubmitted,
            obscureText: widget.obscureText,
            obscuringCharacter: widget.obscuringCharacter,
            scrollPadding: defaultAuthenticationInputFieldScrollPadding,
            showCursor: true,
            smartDashesType: SmartDashesType.disabled,
            textInputAction: widget.textInputAction,
            textColor: Colors.transparent,
            style: const TextStyle(
              fontSize: kIsWeb ? 1 : 0.01,
              height: .01,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    _effectiveBorderRadius = widget.borderRadius ?? context.theme.authenticationCodeTheme().configuration.borderRadius;
    _effectiveBorderWidth = widget.borderWidth ?? context.tokens.borders.borderWidth;
    _effectiveGap = widget.gap ?? context.theme.authenticationCodeTheme().configuration.gap;
    _effectiveHeight = widget.fieldHeight ?? context.theme.authenticationCodeTheme().configuration.height;
    _effectiveWidth = widget.fieldWidth ?? context.theme.authenticationCodeTheme().configuration.width;
    _effectiveSelectedBorderColor = widget.selectedBorderColor ?? context.theme.authenticationCodeTheme().style.selectedBorderColor;
    _effectiveActiveBorderColor = widget.activeBorderColor ?? context.theme.authenticationCodeTheme().style.activeBorderColor;
    _effectiveInactiveBorderColor = widget.inactiveBorderColor ?? context.theme.authenticationCodeTheme().style.inactiveBorderColor;
    _effectiveErrorBorderColor = widget.errorBorderColor ?? context.theme.authenticationCodeTheme().style.errorBorderColor;
    _effectiveSelectedFillColor = widget.selectedFillColor ?? context.theme.authenticationCodeTheme().style.selectedFillColor;
    _effectiveActiveFillColor = widget.activeFillColor ?? context.theme.authenticationCodeTheme().style.activeFillColor;
    _effectiveInactiveFillColor = widget.inactiveFillColor ?? context.theme.authenticationCodeTheme().style.inactiveFillColor;
    _effectiveTextStyle = context.theme.authenticationCodeTheme().configuration.textStyle;
    _effectiveErrorTextStyle = context.theme.authenticationCodeTheme().configuration.errorTextStyle;
    _effectiveTextColor = context.theme.authenticationCodeTheme().style.textColor;
    _effectiveCursorColor = widget.authFieldCursorColor ?? context.theme.authenticationCodeTheme().style.textColor;
    _animationDuration ??= widget.animationDuration ?? context.theme.authenticationCodeTheme().style.animationDuration;
    _animationCurve ??= widget.animationCurve ?? context.theme.authenticationCodeTheme().style.animationCurve;
    _peekDuration ??= widget.peekDuration ?? context.theme.authenticationCodeTheme().style.peekDuration;

    final effectiveDisabledOpacityValue = widget.disabledOpacityValue ?? context.tokens.opacities.disabled;
    final effectiveErrorAnimationDuration = widget.errorAnimationDuration ?? context.theme.authenticationCodeTheme().style.errorAnimationDuration;
    final effectiveErrorAnimationCurve = widget.errorAnimationCurve ?? context.theme.authenticationCodeTheme().style.errorAnimationCurve;

    _errorAnimationController ??= AnimationController(
      duration: effectiveErrorAnimationDuration,
      vsync: this,
    );

    _errorOffsetAnimation ??= Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(.01, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _errorAnimationController!,
        curve: effectiveErrorAnimationCurve,
      ),
    );

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Semantics(
        label: widget.semanticLabel,
        child: RepaintBoundary(
          child: AnimatedOpacity(
            duration: _animationDuration!,
            curve: _animationCurve!,
            opacity: widget.enabled ? 1 : effectiveDisabledOpacityValue,
            child: Column(
              children: [
                SlideTransition(
                  position: _errorOffsetAnimation!,
                  child: Stack(
                    children: <Widget>[
                      AbsorbPointer(
                        child: AutofillGroup(
                          child: _getTextFormField(),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => _onFocus(),
                          child: Row(
                            mainAxisAlignment: widget.mainAxisAlignment,
                            children: _generateAuthInputFields(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_isInErrorMode)
                  DefaultTextStyle(
                    style: _resolvedErrorTextStyle,
                    child: IconTheme(
                      data: IconThemeData(
                        color: _resolvedErrorTextStyle.color,
                      ),
                      child: widget.errorBuilder(context, _validateInput() ?? widget.errorText),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CursorPainter extends CustomPainter {
  final Color cursorColor;

  _CursorPainter({required this.cursorColor});

  @override
  void paint(Canvas canvas, Size size) {
    const p1 = Offset.zero;
    final p2 = Offset(0, size.height);
    final paint = Paint()
      ..color = cursorColor
      ..strokeWidth = 2;

    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
