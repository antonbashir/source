import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;

Widget defaultContextMenuBuilder(BuildContext context, EditableTextState editableTextState) => material.AdaptiveTextSelectionToolbar.editableText(editableTextState: editableTextState);

class Selectable extends StatelessWidget {
  final Widget child;
  final bool enabled;

  const Selectable({super.key, required this.child, required this.enabled});

  @override
  Widget build(BuildContext context) => enabled
      ? SelectableRegion(
          focusNode: FocusNode(),
          selectionControls: switch (defaultTargetPlatform) {
            TargetPlatform.android || TargetPlatform.fuchsia => material.materialTextSelectionHandleControls,
            TargetPlatform.linux || TargetPlatform.windows => material.desktopTextSelectionHandleControls,
            TargetPlatform.iOS => cupertinoTextSelectionHandleControls,
            TargetPlatform.macOS => cupertinoDesktopTextSelectionHandleControls,
          },
          child: child,
        )
      : child;
}
