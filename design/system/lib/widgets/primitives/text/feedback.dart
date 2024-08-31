import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

abstract final class Feedback {
  static Future<void> forTap(BuildContext context) async {
    context.findRenderObject()!.sendSemanticsEvent(const TapSemanticEvent());
    switch (_platform(context)) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return SystemSound.play(SystemSoundType.click);
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return Future<void>.value();
    }
  }

  static GestureTapCallback? wrapForTap(GestureTapCallback? callback, BuildContext context) {
    if (callback == null) {
      return null;
    }
    return () {
      Feedback.forTap(context);
      callback();
    };
  }

  static Future<void> forLongPress(BuildContext context) {
    context.findRenderObject()!.sendSemanticsEvent(const LongPressSemanticsEvent());
    switch (_platform(context)) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return HapticFeedback.vibrate();
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return Future<void>.value();
    }
  }


  static GestureLongPressCallback? wrapForLongPress(GestureLongPressCallback? callback, BuildContext context) {
    if (callback == null) {
      return null;
    }
    return () {
      Feedback.forLongPress(context);
      callback();
    };
  }

  static TargetPlatform _platform(BuildContext context) => defaultTargetPlatform;
}
