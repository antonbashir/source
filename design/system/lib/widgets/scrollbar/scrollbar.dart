import 'package:design/extensions/extensions.dart';
import 'package:design/theme/layouts/scrollbar/theme.dart';
import 'package:design/theme/theme.dart';
import 'package:design/theme/tokens/colors.dart';
import 'package:design/theme/tokens/tokens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

class Scrollbar extends StatelessWidget {
  final Widget child;
  final ScrollController? controller;
  final bool? thumbVisibility;
  final bool? trackVisibility;
  final double? thickness;
  final Radius? radius;
  final bool? interactive;
  final ScrollNotificationPredicate? notificationPredicate;
  final ScrollbarOrientation? scrollbarOrientation;
  final Duration? fadeDuration;
  final Duration? timeToFade;
  final Duration? hoverDuration;

  const Scrollbar({
    super.key,
    required this.child,
    this.controller,
    this.thumbVisibility,
    this.trackVisibility,
    this.thickness,
    this.radius,
    this.notificationPredicate,
    this.interactive,
    this.scrollbarOrientation,
    this.fadeDuration,
    this.timeToFade,
    this.hoverDuration,
  });

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoScrollbar(
        thumbVisibility: thumbVisibility ?? false,
        thickness: thickness ?? CupertinoScrollbar.defaultThickness,
        thicknessWhileDragging: thickness ?? CupertinoScrollbar.defaultThicknessWhileDragging,
        radius: radius ?? CupertinoScrollbar.defaultRadius,
        radiusWhileDragging: radius ?? CupertinoScrollbar.defaultRadiusWhileDragging,
        controller: controller,
        notificationPredicate: notificationPredicate,
        scrollbarOrientation: scrollbarOrientation,
        child: child,
      );
    }

    return _Scrollbar(
      controller: controller,
      thumbVisibility: thumbVisibility,
      trackVisibility: trackVisibility,
      thickness: thickness,
      radius: radius,
      notificationPredicate: notificationPredicate,
      interactive: interactive,
      scrollbarOrientation: scrollbarOrientation,
      fadeDuration: fadeDuration ?? context.theme.scrollbarTheme().style.fadeDuration,
      timeToFade: timeToFade ?? context.theme.scrollbarTheme().style.timeToFade,
      hoverDuration: hoverDuration ?? context.theme.scrollbarTheme().style.hoverDuration,
      child: child,
    );
  }
}

class _Scrollbar extends RawScrollbar {
  final Duration hoverDuration;

  const _Scrollbar({
    required super.child,
    required this.hoverDuration,
    super.controller,
    super.thumbVisibility,
    super.trackVisibility,
    super.thickness,
    super.radius,
    ScrollNotificationPredicate? notificationPredicate,
    super.interactive,
    super.scrollbarOrientation,
    super.fadeDuration,
    super.timeToFade,
  }) : super(
          pressDuration: Duration.zero,
          notificationPredicate: notificationPredicate ?? defaultScrollNotificationPredicate,
        );

  @override
  _ScrollbarState createState() => _ScrollbarState();
}

class _ScrollbarState extends RawScrollbarState<_Scrollbar> {
  late AnimationController _hoverAnimationController;
  bool _dragIsActive = false;
  bool _hoverIsActive = false;
  late Tokens _tokens;
  late ThemeConfiguration _theme;
  late ScrollbarTheme _scrollbarTheme;
  late bool _useAndroidScrollbar;

  @override
  bool get showScrollbar => widget.thumbVisibility ?? _scrollbarTheme.style.thumbVisibility.resolve(_states) ?? false;

  @override
  bool get enableGestures => widget.interactive ?? _scrollbarTheme.style.interactive;

  WidgetStateProperty<bool> get _trackVisibility =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) => widget.trackVisibility ?? _scrollbarTheme.style.trackVisibility.resolve(states) ?? false);

  Set<WidgetState> get _states => <WidgetState>{
        if (_dragIsActive) WidgetState.dragged,
        if (_hoverIsActive) WidgetState.hovered,
      };

  WidgetStateProperty<Color> get _thumbColor {
    final Color onSurface = _tokens.colors.contentMedium;
    final Brightness brightness = _theme.brightness;
    late Color dragColor;
    late Color hoverColor;
    late Color idleColor;

    switch (brightness) {
      case Brightness.light:
        dragColor = onSurface.withOpacity(0.6);
        hoverColor = onSurface.withOpacity(0.5);
        idleColor = _useAndroidScrollbar ? _tokens.colors.active.withOpacity(1.0) : onSurface.withOpacity(0.1);
      case Brightness.dark:
        dragColor = onSurface.withOpacity(0.75);
        hoverColor = onSurface.withOpacity(0.65);
        idleColor = _useAndroidScrollbar ? _tokens.colors.active.withOpacity(1.0) : onSurface.withOpacity(0.3);
    }

    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.dragged)) {
        return _scrollbarTheme.style.thumbColor.resolve(states) ?? dragColor;
      }

      if (_trackVisibility.resolve(states)) {
        return _scrollbarTheme.style.thumbColor.resolve(states) ?? hoverColor;
      }

      return Color.lerp(
        _scrollbarTheme.style.thumbColor.resolve(states) ?? idleColor,
        _scrollbarTheme.style.thumbColor.resolve(states) ?? hoverColor,
        _hoverAnimationController.value,
      )!;
    });
  }

  WidgetStateProperty<Color> get _trackColor {
    final Color onSurface = _tokens.colors.contentMedium;
    final Brightness brightness = _theme.brightness;
    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (showScrollbar && _trackVisibility.resolve(states)) {
        return _scrollbarTheme.style.trackColor.resolve(states) ?? (brightness == Brightness.light ? onSurface.withOpacity(0.03) : onSurface.withOpacity(0.05));
      }
      return Colors.transparent;
    });
  }

  WidgetStateProperty<Color> get _trackBorderColor {
    final Color onSurface = _tokens.colors.contentMedium;
    final Brightness brightness = _theme.brightness;
    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (showScrollbar && _trackVisibility.resolve(states)) {
        return _scrollbarTheme.style.trackBorderColor.resolve(states) ?? (brightness == Brightness.light ? onSurface.withOpacity(0.1) : onSurface.withOpacity(0.25));
      }
      return Colors.transparent;
    });
  }

  WidgetStateProperty<double> get _thickness => WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered) && _trackVisibility.resolve(states)) {
          return _scrollbarTheme.configuration.thicknessWithTrack.resolve(states)!;
        }
        return widget.thickness ?? _scrollbarTheme.configuration.thickness.resolve(states)!;
      });

  @override
  void initState() {
    super.initState();
    _hoverAnimationController = AnimationController(vsync: this, duration: widget.hoverDuration);
    _hoverAnimationController.addListener(() => updateScrollbarPainter());
  }

  @override
  void didChangeDependencies() {
    _theme = context.theme;
    _tokens = context.theme.tokens;
    _scrollbarTheme = context.theme.scrollbarTheme();
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        _useAndroidScrollbar = true;
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        _useAndroidScrollbar = false;
    }
    super.didChangeDependencies();
  }

  @override
  void updateScrollbarPainter() {
    scrollbarPainter
      ..color = _thumbColor.resolve(_states)
      ..trackColor = _trackColor.resolve(_states)
      ..trackBorderColor = _trackBorderColor.resolve(_states)
      ..textDirection = Directionality.of(context)
      ..thickness = _thickness.resolve(_states)
      ..radius = widget.radius ?? _scrollbarTheme.configuration.radius
      ..crossAxisMargin = _scrollbarTheme.configuration.crossAxisMargin
      ..mainAxisMargin = _scrollbarTheme.configuration.mainAxisMargin
      ..minLength = _scrollbarTheme.configuration.minThumbLength
      ..padding = MediaQuery.paddingOf(context)
      ..scrollbarOrientation = widget.scrollbarOrientation
      ..ignorePointer = !enableGestures;
  }

  @override
  void handleThumbPressStart(Offset localPosition) {
    super.handleThumbPressStart(localPosition);
    setState(() => _dragIsActive = true);
  }

  @override
  void handleThumbPressEnd(Offset localPosition, Velocity velocity) {
    super.handleThumbPressEnd(localPosition, velocity);
    setState(() => _dragIsActive = false);
  }

  @override
  void handleHover(PointerHoverEvent event) {
    super.handleHover(event);
    if (isPointerOverScrollbar(event.position, event.kind, forHover: true)) {
      setState(() => _hoverIsActive = true);
      _hoverAnimationController.forward();
      return;
    }
    if (_hoverIsActive) {
      setState(() => _hoverIsActive = false);
      _hoverAnimationController.reverse();
    }
  }

  @override
  void handleHoverExit(PointerExitEvent event) {
    super.handleHoverExit(event);
    setState(() => _hoverIsActive = false);
    _hoverAnimationController.reverse();
  }

  @override
  void dispose() {
    _hoverAnimationController.dispose();
    super.dispose();
  }
}
