import 'dart:async';

import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/borders.dart';
import 'package:design/constants/toast.dart';
import 'package:design/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class Toast {
  static final _toastQueue = <_ToastEntry>[];

  static Timer? _timer;
  static OverlayEntry? _entry;

  const Toast();

  static void show(
    BuildContext context, {
    required Widget label,
    AlignmentGeometry alignment = Alignment.topCenter,
    ToastVariant variant = ToastVariant.neutral,
    bool persistent = true,
    bool useSafeArea = true,
    BorderType? borderType,
    BorderRadiusGeometry? borderRadius,
    Color? leadingBackgroundColor,
    Color? textColor,
    Color? iconColor,
    double? horizontalGap,
    double? verticalGap,
    double? width,
    Duration? displayDuration,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    List<BoxShadow>? toastShadows,
    Decoration? decoration,
    String? semanticLabel,
    Widget? leading,
    Widget? trailing,
    Widget? content,
    double? travelDistance,
  }) {
    final effectiveBorderType = borderType ?? context.theme.toastTheme().configuration.borderType;
    final effectiveBorderRadius = borderRadius ?? context.theme.toastTheme().configuration.borderRadius;
    final effectiveLeadingBackgroundColor = leadingBackgroundColor ?? context.theme.toastTheme().style.leadingColors[variant]!;
    final effectiveBackgroundColor = textColor ?? context.theme.toastTheme().style.backgroundColor;
    final effectiveTextColor = textColor ?? context.theme.toastTheme().style.textColor;
    final effectiveIconColor = iconColor ?? context.theme.toastTheme().style.iconColor;

    final effectiveTextStyle = context.theme.toastTheme().configuration.textStyle;
    final effectiveHorizontalGap = horizontalGap ?? context.theme.toastTheme().configuration.horizontalGap;
    final effectiveVerticalGap = verticalGap ?? context.theme.toastTheme().configuration.verticalGap;
    final effectiveDisplayDuration = displayDuration ?? context.theme.toastTheme().style.displayDuration;
    final effectiveTransitionDuration = transitionDuration ?? context.theme.toastTheme().style.transitionDuration;
    final effectiveTransitionCurve = transitionCurve ?? context.theme.toastTheme().style.transitionCurve;
    final effectiveContentPadding = padding ?? context.theme.toastTheme().configuration.contentPadding;
    final effectiveTravelDistance = travelDistance ?? context.theme.toastTheme().style.travelDistance;
    final resolvedContentPadding = effectiveContentPadding.resolve(Directionality.of(context));
    final effectiveToastShadows = toastShadows ?? context.theme.toastTheme().style.shadows;

    final effectiveContext = persistent ? (Navigator.maybeOf(context, rootNavigator: true)?.context ?? context) : context;

    final CapturedThemes themes = InheritedTheme.capture(
      from: context,
      to: Navigator.of(effectiveContext).context,
    );

    final OverlayEntry entry = OverlayEntry(
      builder: (BuildContext context) => RepaintBoundary(
        child: TweenAnimationBuilder(
          duration: effectiveTransitionDuration,
          curve: effectiveTransitionCurve,
          tween: Tween<double>(begin: 0.0, end: 1.0),
          builder: (context, progress, child) => SafeArea(
            left: useSafeArea,
            top: useSafeArea,
            right: useSafeArea,
            bottom: useSafeArea,
            maintainBottomViewPadding: true,
            child: Align(
              alignment: alignment,
              child: Transform(
                transform: Matrix4.translationValues(
                  switch (alignment) {
                    Alignment.topLeft || Alignment.centerLeft || Alignment.bottomLeft => -effectiveTravelDistance + progress * effectiveTravelDistance,
                    Alignment.topRight || Alignment.centerRight || Alignment.bottomRight => (1 - progress) * effectiveTravelDistance,
                    _ => 0
                  },
                  switch (alignment) {
                    Alignment.topCenter => -effectiveTravelDistance + progress * effectiveTravelDistance,
                    Alignment.bottomCenter => (1 - progress) * effectiveTravelDistance,
                    _ => 0
                  },
                  0,
                ),
                child: Opacity(
                  opacity: progress,
                  child: child,
                ),
              ),
            ),
          ),
          child: themes.wrap(
            Semantics(
              label: semanticLabel,
              child: IconTheme(
                data: IconThemeData(color: effectiveIconColor),
                child: DefaultTextStyle(
                  style: effectiveTextStyle.copyWith(color: effectiveTextColor),
                  child: Container(
                    margin: margin ?? resolvedContentPadding,
                    padding: resolvedContentPadding,
                    width: width,
                    decoration: decoration ??
                        ShapeDecoration(
                          color: effectiveBackgroundColor,
                          shadows: effectiveToastShadows,
                          shape: switch (effectiveBorderType) {
                            BorderType.rounded => RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
                            BorderType.squircle => SquircleBorder(borderRadius: effectiveBorderRadius.squircle(context))
                          },
                        ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: width != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                          textDirection: Directionality.of(context),
                          children: [
                            if (leading != null) ...[
                              Container(
                                padding: EdgeInsets.all(context.spacings.tiny),
                                decoration: ShapeDecoration(
                                  color: effectiveLeadingBackgroundColor,
                                  shape: switch (effectiveBorderType) {
                                    BorderType.rounded => RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
                                    BorderType.squircle => SquircleBorder(borderRadius: effectiveBorderRadius.squircle(context))
                                  },
                                ),
                                child: leading,
                              ),
                              SizedBox(width: effectiveHorizontalGap),
                            ],
                            Flexible(child: label),
                            if (trailing != null) ...[
                              SizedBox(width: effectiveHorizontalGap),
                              trailing,
                            ],
                          ],
                        ),
                        if (content != null) ...[
                          SizedBox(height: effectiveVerticalGap),
                          content,
                        ],
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

    final toastEntry = _ToastEntry(
      buildContext: effectiveContext,
      overlayEntry: entry,
    );

    _toastQueue.add(toastEntry);

    if (_timer == null) _showToastOverlay(duration: effectiveDisplayDuration);
  }

  static void clearToastQueue() {
    _timer?.cancel();
    _timer = null;

    _entry?.remove();
    _entry = null;

    _toastQueue.clear();
  }

  static void _showToastOverlay({required Duration duration}) {
    if (_toastQueue.isEmpty) {
      _entry = null;
      return;
    }

    final toastEntry = _toastQueue.removeAt(0);

    if (!toastEntry.buildContext.mounted) {
      clearToastQueue();
      return;
    }

    _entry = toastEntry.overlayEntry;
    _timer = Timer(duration, () => _removeToastOverlay(duration: duration));

    Future.delayed(
      toastEntry.buildContext.theme.toastTheme().style.timeBetweenToasts,
      () => Navigator.of(toastEntry.buildContext).overlay?.insert(_entry!),
    );
  }

  static void _removeToastOverlay({required Duration duration}) {
    _timer?.cancel();
    _timer = null;

    _entry?.remove();
    _entry = null;

    _showToastOverlay(duration: duration);
  }
}

class _ToastEntry {
  final BuildContext buildContext;
  final OverlayEntry overlayEntry;

  _ToastEntry({
    required this.buildContext,
    required this.overlayEntry,
  });
}
