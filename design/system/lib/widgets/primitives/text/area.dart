import 'package:design/constants/text.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/primitives/text/form.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

typedef TextAreaErrorBuilder = Widget Function(BuildContext context, String? errorText);

class TextArea extends StatelessWidget {
  final AutovalidateMode autovalidateMode;
  final bool autocorrect;
  final bool autofocus;
  final bool enabled;
  final bool enableIMEPersonalizedLearning;
  final bool enableSuggestions;
  final bool expands;
  final bool readOnly;
  final bool scribbleEnabled;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final EdgeInsets scrollPadding;
  final bool? enableInteractiveSelection;
  final bool? showCursor;
  final BorderRadiusGeometry? borderRadius;
  final Brightness? keyboardAppearance;
  final Clip? clipBehavior;
  final Color? backgroundColor;
  final Color? activeBorderColor;
  final Color? inactiveBorderColor;
  final Color? errorColor;
  final Color? hoverBorderColor;
  final Color? textColor;
  final Color? hintTextColor;
  final double? height;
  final double? width;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final EdgeInsetsGeometry? helperPadding;
  final EdgeInsetsGeometry? textPadding;
  final FocusNode? focusNode;
  final int? maxLength;
  final int? minLines;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final Decoration? decoration;
  final String? hintText;
  final String? initialValue;
  final String? restorationId;
  final String? semanticLabel;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextStyle? textStyle;
  final TextStyle? helperTextStyle;
  final FormFieldValidator<String>? validator;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String?>? onSaved;
  final ValueChanged<String>? onSubmitted;
  final TextAreaErrorBuilder? errorBuilder;
  final Widget? helper;

  const TextArea({
    super.key,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.autocorrect = true,
    this.autofocus = false,
    this.enabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.enableInteractiveSelection,
    this.enableSuggestions = true,
    this.expands = false,
    this.readOnly = false,
    this.scribbleEnabled = true,
    this.scrollPadding = defaultTextAreaScrollPadding,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.showCursor,
    this.borderRadius,
    this.keyboardAppearance,
    this.clipBehavior,
    this.backgroundColor,
    this.activeBorderColor,
    this.inactiveBorderColor,
    this.errorColor,
    this.hoverBorderColor,
    this.textColor,
    this.hintTextColor,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.helperPadding,
    this.textPadding,
    this.focusNode,
    this.validator,
    this.maxLength,
    this.minLines,
    this.autofillHints,
    this.inputFormatters,
    this.maxLengthEnforcement,
    this.scrollController,
    this.scrollPhysics,
    this.decoration,
    this.hintText,
    this.initialValue,
    this.restorationId,
    this.semanticLabel,
    this.strutStyle,
    this.textDirection,
    this.controller,
    this.textInputAction,
    this.textStyle,
    this.helperTextStyle,
    this.onTap,
    this.onTapOutside,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.onSubmitted,
    this.errorBuilder,
    this.helper,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? context.theme.textAreaTheme().configuration.borderRadius;
    final effectiveBackgroundColor = backgroundColor ?? context.theme.textAreaTheme().style.backgroundColor;
    final effectiveActiveBorderColor = activeBorderColor ?? context.theme.textAreaTheme().style.activeBorderColor;
    final effectiveInactiveBorderColor = inactiveBorderColor ?? context.theme.textAreaTheme().style.inactiveBorderColor;
    final effectiveErrorColor = errorColor ?? context.theme.textAreaTheme().style.errorColor;
    final effectiveHoverBorderColor = hoverBorderColor ?? context.theme.textAreaTheme().style.hoverBorderColor;
    final effectiveTextColor = textColor ?? context.theme.textAreaTheme().style.textColor;
    final effectiveHelperTextColor = hintTextColor ?? context.theme.textAreaTheme().style.helperTextColor;
    final effectiveTextPadding = textPadding ?? context.theme.textAreaTheme().configuration.textPadding;
    final effectiveTextStyle = textStyle ?? context.theme.textAreaTheme().configuration.textStyle;
    final effectiveHelperTextStyle = helperTextStyle ?? context.theme.textAreaTheme().configuration.helperTextStyle;
    final effectiveTransitionDuration = transitionDuration ?? context.theme.textAreaTheme().style.transitionDuration;
    final effectiveTransitionCurve = transitionCurve ?? context.theme.textAreaTheme().style.transitionCurve;
    final effectiveHelperPadding = helperPadding ?? context.theme.textAreaTheme().configuration.helperPadding;

    return FormTextInput(
      activeBorderColor: effectiveActiveBorderColor,
      autocorrect: autocorrect,
      autofillHints: autofillHints,
      autofocus: autofocus,
      autovalidateMode: autovalidateMode,
      backgroundColor: effectiveBackgroundColor,
      borderRadius: effectiveBorderRadius,
      controller: controller,
      cursorColor: effectiveTextColor,
      cursorErrorColor: effectiveErrorColor,
      enabled: enabled,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      enableInteractiveSelection: enableInteractiveSelection,
      enableSuggestions: enableSuggestions,
      errorColor: effectiveErrorColor,
      errorBuilder: errorBuilder,
      expands: expands,
      focusNode: focusNode,
      height: height,
      width: width,
      helper: helper,
      helperPadding: effectiveHelperPadding,
      helperTextStyle: effectiveHelperTextStyle,
      hintText: hintText,
      hintTextColor: effectiveHelperTextColor,
      hoverBorderColor: effectiveHoverBorderColor,
      inactiveBorderColor: effectiveInactiveBorderColor,
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      keyboardAppearance: keyboardAppearance,
      keyboardType: TextInputType.multiline,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLines: null,
      minLines: minLines,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      onSaved: onSaved,
      onTap: onTap,
      onTapOutside: onTapOutside,
      padding: effectiveTextPadding,
      readOnly: readOnly,
      restorationId: restorationId,
      scrollController: scrollController,
      scrollPadding: scrollPadding,
      scrollPhysics: scrollPhysics,
      decoration: decoration,
      showCursor: showCursor,
      strutStyle: strutStyle,
      style: effectiveTextStyle.copyWith(color: effectiveTextColor),
      textAlign: textAlign,
      textAlignVertical: TextAlignVertical.top,
      textCapitalization: textCapitalization,
      textColor: effectiveTextColor,
      textDirection: textDirection,
      textInputAction: textInputAction,
      transitionCurve: effectiveTransitionCurve,
      transitionDuration: effectiveTransitionDuration,
      validator: validator,
    );
  }
}
