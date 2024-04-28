import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/borders.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/theme/tokens/colors.dart';
import 'package:flutter/widgets.dart';

class Alert extends StatefulWidget {
  final bool show;
  final bool showBorder;
  final BorderType? borderType;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? color;
  final double? borderWidth;
  final double? horizontalGap;
  final double? minimumHeight;
  final double? height;
  final double? width;
  final double? verticalGap;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final String? semanticLabel;
  final Widget? leading;
  final Widget label;
  final Widget? trailing;
  final Widget? content;

  const Alert({
    super.key,
    required this.label,
    this.show = false,
    this.showBorder = false,
    this.borderType,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.color,
    this.borderWidth,
    this.horizontalGap,
    this.minimumHeight,
    this.height,
    this.width,
    this.verticalGap,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.decoration,
    this.semanticLabel,
    this.leading,
    this.trailing,
    this.content,
  });

  const Alert.filled({
    super.key,
    required this.backgroundColor,
    required this.label,
    this.show = false,
    this.borderType,
    this.borderRadius,
    this.color,
    this.semanticLabel,
    this.leading,
    this.trailing,
    this.content,
    this.height,
    this.width,
  })  : showBorder = false,
        borderColor = null,
        borderWidth = null,
        decoration = null,
        minimumHeight = null,
        padding = null,
        horizontalGap = null,
        verticalGap = null,
        transitionDuration = null,
        transitionCurve = null;

  const Alert.outlined({
    super.key,
    required this.borderColor,
    required this.label,
    this.show = false,
    this.borderType,
    this.borderRadius,
    this.borderWidth,
    this.color,
    this.semanticLabel,
    this.leading,
    this.trailing,
    this.content,
    this.height,
    this.width,
  })  : showBorder = true,
        backgroundColor = Colors.transparent,
        decoration = null,
        minimumHeight = null,
        padding = null,
        horizontalGap = null,
        verticalGap = null,
        transitionDuration = null,
        transitionCurve = null;

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> with SingleTickerProviderStateMixin {
  bool _isVisible = true;

  AnimationController? _animationController;
  Animation<double>? _curvedAnimation;

  TextStyle _getLabelTextStyle({required BuildContext context}) {
    if (widget.content != null) {
      return context.theme.alertTheme().configuration.labelTextStyle;
    }
    return context.theme.alertTheme().configuration.contentTextStyle;
  }

  void _showAlert() {
    _animationController!.forward();
    setState(() => _isVisible = true);
  }

  void _hideAlert() {
    _animationController!.reverse().then<void>((void value) {
      if (!mounted) return;
      setState(() => _isVisible = false);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (!mounted) return;
      if (_isVisible) _animationController!.value = 1.0;
    });
  }

  @override
  void didUpdateWidget(Alert oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.show != widget.show) {
      widget.show ? _showAlert() : _hideAlert();
    }
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBorderType = widget.borderType ?? context.theme.alertTheme().configuration.borderType;
    final effectiveBorderRadius = widget.borderRadius ?? context.theme.alertTheme().configuration.borderRadius;
    final effectiveBorderWidth = widget.borderWidth ?? context.tokens.borders.inactiveWidth;
    final effectiveHorizontalGap = widget.horizontalGap ?? context.theme.alertTheme().configuration.horizontalGap;
    final effectiveVerticalGap = widget.verticalGap ?? context.theme.alertTheme().configuration.verticalGap;
    final effectiveMinimumHeight = widget.minimumHeight ?? context.theme.alertTheme().configuration.minimumHeight;
    final effectiveBackgroundColor = widget.backgroundColor ?? context.theme.alertTheme().style.backgroundColor;
    final effectiveBorderColor = widget.borderColor ?? context.theme.alertTheme().style.borderColor;
    final effectiveTextColor = widget.color ?? context.theme.alertTheme().style.textColor;
    final effectiveIconColor = widget.color ?? context.theme.alertTheme().style.iconColor;
    final effectivePadding = widget.padding ?? context.theme.alertTheme().configuration.padding;
    final effectiveLabelTextStyle = _getLabelTextStyle(context: context);
    final effectiveContentTextStyle = context.theme.alertTheme().configuration.contentTextStyle;
    final effectiveTransitionDuration = widget.transitionDuration ?? context.theme.alertTheme().style.transitionDuration;
    final effectiveTransitionCurve = widget.transitionCurve ?? context.theme.alertTheme().style.transitionCurve;

    _animationController ??= AnimationController(
      duration: effectiveTransitionDuration,
      vsync: this,
    );

    _curvedAnimation ??= CurvedAnimation(
      parent: _animationController!,
      curve: effectiveTransitionCurve,
    );

    return Visibility(
      visible: _isVisible,
      child: Semantics(
        label: widget.semanticLabel,
        child: RepaintBoundary(
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: FadeTransition(
              opacity: _curvedAnimation!,
              child: Container(
                padding: effectivePadding,
                constraints: BoxConstraints(minHeight: effectiveMinimumHeight),
                decoration: widget.decoration ??
                    ShapeDecoration(
                      color: effectiveBackgroundColor,
                      shape: switch (effectiveBorderType) {
                        BorderType.squircle => SquircleBorder(
                            side: BorderSide(
                              color: effectiveBorderColor,
                              width: widget.showBorder ? effectiveBorderWidth : 0,
                              style: widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                            ),
                            borderRadius: effectiveBorderRadius.squircle(context),
                          ),
                        BorderType.rounded => RoundedRectangleBorder(
                            side: BorderSide(
                              color: effectiveBorderColor,
                              width: widget.showBorder ? effectiveBorderWidth : 0,
                              style: widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                            ),
                            borderRadius: effectiveBorderRadius,
                          )
                      },
                    ),
                child: IconTheme(
                  data: IconThemeData(
                    color: effectiveIconColor,
                  ),
                  child: DefaultTextStyle(
                    style: effectiveContentTextStyle.copyWith(color: effectiveTextColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            if (widget.leading != null)
                              Padding(
                                padding: EdgeInsetsDirectional.only(end: effectiveHorizontalGap),
                                child: widget.leading,
                              ),
                            Expanded(
                              child: DefaultTextStyle(
                                style: effectiveLabelTextStyle.copyWith(color: effectiveTextColor),
                                child: widget.label,
                              ),
                            ),
                            if (widget.trailing != null)
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: effectiveHorizontalGap),
                                child: widget.trailing,
                              ),
                          ],
                        ),
                        if (widget.content != null)
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(top: effectiveVerticalGap),
                                  child: widget.content,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
