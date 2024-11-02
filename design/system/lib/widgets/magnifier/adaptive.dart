import 'dart:async';

import 'package:design/constants/magnifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class TextMagnifier extends StatefulWidget {
  const TextMagnifier({
    super.key,
    required this.magnifierInfo,
  });

  static TextMagnifierConfiguration adaptiveMagnifierConfiguration = TextMagnifierConfiguration(
      shouldDisplayHandlesInMagnifier: defaultTargetPlatform == TargetPlatform.iOS,
      magnifierBuilder: (
        BuildContext context,
        MagnifierController controller,
        ValueNotifier<MagnifierInfo> magnifierInfo,
      ) {
        switch (defaultTargetPlatform) {
          case TargetPlatform.iOS:
            return CupertinoTextMagnifier(
              controller: controller,
              magnifierInfo: magnifierInfo,
            );
          case TargetPlatform.android:
            return TextMagnifier(
              magnifierInfo: magnifierInfo,
            );
          case TargetPlatform.fuchsia:
          case TargetPlatform.linux:
          case TargetPlatform.macOS:
          case TargetPlatform.windows:
            return null;
        }
      });

  final ValueNotifier<MagnifierInfo> magnifierInfo;

  @override
  State<TextMagnifier> createState() => _TextMagnifierState();
}

class _TextMagnifierState extends State<TextMagnifier> {
  Offset? _magnifierPosition;
  Timer? _positionShouldBeAnimatedTimer;
  bool get _positionShouldBeAnimated => _positionShouldBeAnimatedTimer != null;

  Offset _extraFocalPointOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    widget.magnifierInfo.addListener(_determineMagnifierPositionAndFocalPoint);
  }

  @override
  void dispose() {
    widget.magnifierInfo.removeListener(_determineMagnifierPositionAndFocalPoint);
    _positionShouldBeAnimatedTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _determineMagnifierPositionAndFocalPoint();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(TextMagnifier oldWidget) {
    if (oldWidget.magnifierInfo != widget.magnifierInfo) {
      oldWidget.magnifierInfo.removeListener(_determineMagnifierPositionAndFocalPoint);
      widget.magnifierInfo.addListener(_determineMagnifierPositionAndFocalPoint);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _determineMagnifierPositionAndFocalPoint() {
    final selectionInfo = widget.magnifierInfo.value;
    final screenRect = Offset.zero & MediaQuery.sizeOf(context);
    final basicMagnifierOffset = Offset(magnifierSize.width / 2, magnifierSize.height + magnifierStandardVerticalFocalPointShift);
    final magnifierX = clampDouble(selectionInfo.globalGesturePosition.dx, selectionInfo.currentLineBoundaries.left, selectionInfo.currentLineBoundaries.right);
    final unadjustedMagnifierRect = Offset(magnifierX, selectionInfo.caretRect.center.dy) - basicMagnifierOffset & magnifierSize;
    final screenBoundsAdjustedMagnifierRect = MagnifierController.shiftWithinBounds(bounds: screenRect, rect: unadjustedMagnifierRect);
    final finalMagnifierPosition = screenBoundsAdjustedMagnifierRect.topLeft;
    final horizontalMaxFocalPointEdgeInsets = (magnifierSize.width / 2) / magnifierMagnification;
    final newGlobalFocalPointX = selectionInfo.fieldBounds.width < horizontalMaxFocalPointEdgeInsets * 2
        ? selectionInfo.fieldBounds.center.dx
        : clampDouble(
            screenBoundsAdjustedMagnifierRect.center.dx,
            selectionInfo.fieldBounds.left + horizontalMaxFocalPointEdgeInsets,
            selectionInfo.fieldBounds.right - horizontalMaxFocalPointEdgeInsets,
          );
    final newRelativeFocalPointX = newGlobalFocalPointX - screenBoundsAdjustedMagnifierRect.center.dx;
    final focalPointAdjustmentForScreenBoundsAdjustment = Offset(
      newRelativeFocalPointX,
      unadjustedMagnifierRect.top - screenBoundsAdjustedMagnifierRect.top,
    );

    Timer? positionShouldBeAnimated = _positionShouldBeAnimatedTimer;

    if (_magnifierPosition != null && finalMagnifierPosition.dy != _magnifierPosition!.dy) {
      if (_positionShouldBeAnimatedTimer != null && _positionShouldBeAnimatedTimer!.isActive) {
        _positionShouldBeAnimatedTimer!.cancel();
      }
      positionShouldBeAnimated = Timer(magnifierJumpBetweenLinesAnimationDuration, () => setState(() => _positionShouldBeAnimatedTimer = null));
    }

    setState(() {
      _magnifierPosition = finalMagnifierPosition;
      _positionShouldBeAnimatedTimer = positionShouldBeAnimated;
      _extraFocalPointOffset = focalPointAdjustmentForScreenBoundsAdjustment;
    });
  }

  @override
  Widget build(BuildContext context) => AnimatedPositioned(
        top: _magnifierPosition!.dy,
        left: _magnifierPosition!.dx,
        duration: _positionShouldBeAnimated ? magnifierJumpBetweenLinesAnimationDuration : Duration.zero,
        child: Magnifier(
          additionalFocalPointOffset: _extraFocalPointOffset,
        ),
      );
}

class Magnifier extends StatelessWidget {
  final Offset additionalFocalPointOffset;
  final BorderRadius borderRadius;
  final Color filmColor;
  final List<BoxShadow> shadows;
  final Size size;

  const Magnifier({
    super.key,
    this.additionalFocalPointOffset = Offset.zero,
    this.borderRadius = const BorderRadius.all(Radius.circular(magnifierBorderRadius)),
    this.filmColor = magnifierFilmColor,
    this.shadows = magnifierShadows,
    this.size = magnifierSize,
  });

  @override
  Widget build(BuildContext context) => RawMagnifier(
        decoration: MagnifierDecoration(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          shadows: shadows,
        ),
        magnificationScale: magnifierMagnification,
        focalPointOffset: additionalFocalPointOffset + Offset(0, magnifierStandardVerticalFocalPointShift + magnifierSize.height / 2),
        size: size,
        child: ColoredBox(
          color: filmColor,
        ),
      );
}
