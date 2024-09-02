import 'package:design/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;

Widget _defaultSpellCheckSuggestionsToolbarBuilder(
  BuildContext context,
  EditableTextState editableTextState,
) {
  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      return CupertinoSpellCheckSuggestionsToolbar.editableText(editableTextState: editableTextState);
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      return material.SpellCheckSuggestionsToolbar.editableText(editableTextState: editableTextState);
  }
}

SpellCheckConfiguration inferAndroidSpellCheckConfiguration(BuildContext context, SpellCheckConfiguration? configuration) {
  if (configuration == null || configuration == const SpellCheckConfiguration.disabled()) {
    return const SpellCheckConfiguration.disabled();
  }
  return configuration.copyWith(
    misspelledTextStyle: configuration.misspelledTextStyle ??
        TextStyle(
          decoration: TextDecoration.underline,
          decorationColor: context.palette.red.shade500,
          decorationStyle: TextDecorationStyle.wavy,
        ),
    spellCheckSuggestionsToolbarBuilder: configuration.spellCheckSuggestionsToolbarBuilder ?? _defaultSpellCheckSuggestionsToolbarBuilder,
  );
}
