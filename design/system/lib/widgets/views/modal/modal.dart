import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/assertions.dart';
import 'package:design/constants/borders.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/configurator/configurator.dart';
import 'package:design/widgets/selection/selection.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

Future<T?> showModal<T>({
  bool barrierDismissible = true,
  bool useRootNavigator = true,
  bool useSafeArea = true,
  Color? barrierColor,
  Curve? transitionCurve,
  Duration? transitionDuration,
  Offset? anchorPoint,
  RouteSettings? routeSettings,
  String? barrierLabel,
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  assert(_debugIsActive(context));

  final themes = InheritedTheme.capture(
    from: context,
    to: Navigator.of(context, rootNavigator: useRootNavigator).context,
  );

  final effectiveBarrierColor = barrierColor ?? context.theme.modalTheme().style.barrierColor;
  final effectiveTransitionDuration = transitionDuration ?? context.theme.modalTheme().style.transitionDuration;
  final effectiveTransitionCurve = transitionCurve ?? context.theme.modalTheme().style.transitionCurve;

  return Navigator.of(context, rootNavigator: useRootNavigator).push<T>(
    ModalRoute<T>(
      context: context,
      builder: builder,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel ?? material.MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: effectiveBarrierColor,
      transitionDuration: effectiveTransitionDuration,
      transitionCurve: effectiveTransitionCurve,
      useSafeArea: useSafeArea,
      settings: routeSettings,
      anchorPoint: anchorPoint,
      themes: themes,
    ),
  );
}

bool _debugIsActive(BuildContext context) {
  if (context is Element && !context.debugIsActive) {
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(modalBuildContextInvalidErrorSummary),
      ErrorDescription(modalBuildContextInvalidErrorDescription),
      ErrorHint(modalBuildContextInvalidErrorHint),
    ]);
  }
  return true;
}

class ModalRoute<T> extends RawDialogRoute<T> {
  ModalRoute({
    super.anchorPoint,
    required super.barrierColor,
    super.barrierDismissible,
    required super.barrierLabel,
    super.settings,
    CapturedThemes? themes,
    required super.transitionDuration,
    required Curve transitionCurve,
    bool useSafeArea = true,
    required BuildContext context,
    required WidgetBuilder builder,
  }) : super(
          pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
            final Widget pageChild = Builder(builder: builder);
            Widget modal = themes?.wrap(pageChild) ?? pageChild;
            if (useSafeArea) return SafeArea(child: modal);
            return modal;
          },
          transitionBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              RepaintBoundary(
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: transitionCurve,
              ),
              child: child,
            ),
          ),
        );
}

class Modal extends StatelessWidget {
  final Widget child;
  final BorderType? borderType;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Decoration? decoration;
  final String? semanticLabel;

  const Modal({
    super.key,
    required this.child,
    this.borderType,
    this.borderRadius,
    this.backgroundColor,
    this.decoration,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderType = borderType ?? context.theme.modalTheme().configuration.borderType;
    final effectiveBorderRadius = borderRadius ?? context.theme.modalTheme().configuration.borderRadius;
    final effectiveBackgroundColor = backgroundColor ?? context.theme.modalTheme().style.backgroundColor;
    final effectiveTextColor = context.theme.modalTheme().style.textColor;
    final effectiveIconColor = context.theme.modalTheme().style.iconColor;
    final effectiveTextStyle = context.theme.modalTheme().configuration.textStyle;
    return Semantics(
      label: semanticLabel,
      child: IconTheme(
        data: IconThemeData(color: effectiveIconColor),
        child: DefaultTextStyle(
          style: effectiveTextStyle.copyWith(color: effectiveTextColor),
          child: Center(
            child: Container(
              decoration: decoration ??
                  ShapeDecoration(
                    color: effectiveBackgroundColor,
                    shape: switch (effectiveBorderType) {
                      BorderType.rounded => RoundedRectangleBorder(borderRadius: effectiveBorderRadius.squircle(context)),
                      BorderType.squircle => SquircleBorder(borderRadius: effectiveBorderRadius.squircle(context)),
                    },
                  ),
              child: Selectable(
                enabled: Configurator.of(context).actionsConfiguration.enableSelection,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
