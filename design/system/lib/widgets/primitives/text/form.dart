import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle, Brightness;

import 'package:design/constants/assertions.dart';
import 'package:design/constants/constants.dart';
import 'package:design/constants/restoration.dart';
import 'package:design/constants/text.dart';
import 'package:design/widgets/selection/selection.dart';
import 'package:design/widgets/primitives/text/form.dart';
import 'package:design/widgets/primitives/text/input.dart';
import 'package:flutter/gestures.dart';
import 'package:design/constants/breakpoints.dart';

import 'package:flutter/widgets.dart';
export 'package:flutter/services.dart' show SmartDashesType, SmartQuotesType, TextInputFormatter, MaxLengthEnforcement;

typedef FormTextInputValidationStatusCallback = void Function(String? validationErrorText);

class FormTextInput extends FormField<String> {
  final FormTextInputConfiguration configuration;

  FormTextInput({
    super.key,
    this.controller,
    super.onSaved,
    super.validator,
    super.restorationId,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextAlign textAlign = TextAlign.start,
    bool hasFloatingLabel = false,
    int? maxLines = 1,
    bool autofocus = false,
    bool readOnly = false,
    String obscuringCharacter = boldDot,
    bool obscureText = false,
    bool autocorrect = true,
    bool enableSuggestions = true,
    bool expands = false,
    double cursorWidth = 2.0,
    EdgeInsets scrollPadding = defaultFormTextInputScrollPadding,
    bool enableIMEPersonalizedLearning = true,
    EditableTextContextMenuBuilder? contextMenuBuilder = defaultContextMenuBuilder,
    bool canRequestFocus = true,
    bool scribbleEnabled = true,
    Clip clipBehavior = Clip.hardEdge,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    bool onTapAlwaysCalled = false,
    BorderRadiusGeometry? borderRadius,
    Color? backgroundColor,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
    Color? errorColor,
    Color? errorBorderColor,
    Color? hoverBorderColor,
    Color? textColor,
    Color? hintTextColor,
    Decoration? decoration,
    double? gap,
    double? height,
    double? width,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? helperPadding,
    FormTextInputValidationStatusCallback? validationStatusCallback,
    BreakpointSize? textInputSize,
    String? errorText,
    String? hintText,
    String? initialValue,
    TextStyle? helperTextStyle,
    TextInputErrorBuilder? errorBuilder,
    Widget? leading,
    Widget? trailing,
    Widget? helper,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlignVertical? textAlignVertical,
    bool? showCursor,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    MaxLengthEnforcement? maxLengthEnforcement,
    int? minLines,
    int? maxLength,
    ValueChanged<String>? onChanged,
    GestureTapCallback? onTap,
    TapRegionCallback? onTapOutside,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Color? cursorErrorColor,
    ui.Brightness? keyboardAppearance,
    bool? enableInteractiveSelection,
    TextSelectionControls? selectionControls,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    AutovalidateMode? autovalidateMode,
    ScrollController? scrollController,
    MouseCursor? mouseCursor,
    SpellCheckConfiguration? spellCheckConfiguration,
    TextMagnifierConfiguration? magnifierConfiguration,
    AppPrivateCommandCallback? onAppPrivateCommand,
    bool? cursorOpacityAnimates,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    UndoHistoryController? undoController,
  })  : assert(initialValue == null || controller == null),
        assert(obscuringCharacter.length == 1),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert((maxLines == null) || (minLines == null) || (maxLines >= minLines), testMinLinesAssertion),
        assert(!expands || (maxLines == null && minLines == null), testMinLinesWithExpandsAssertion),
        assert(!obscureText || maxLines == 1, testObscuredFieldsAssertion),
        assert(maxLength == null || maxLength == textNoMaxLength || maxLength > 0),
        configuration = FormTextInputConfiguration(
          activeBorderColor: activeBorderColor,
          autocorrect: autocorrect,
          autofillHints: autofillHints,
          autofocus: autofocus,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
          canRequestFocus: canRequestFocus,
          clipBehavior: clipBehavior,
          contentInsertionConfiguration: contentInsertionConfiguration,
          contextMenuBuilder: contextMenuBuilder,
          controller: controller,
          cursorColor: cursorColor,
          cursorErrorColor: cursorErrorColor,
          cursorHeight: cursorHeight,
          cursorOpacityAnimates: cursorOpacityAnimates,
          cursorRadius: cursorRadius,
          cursorWidth: cursorWidth,
          decoration: decoration,
          dragStartBehavior: dragStartBehavior,
          enabled: enabled ?? true,
          enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
          enableInteractiveSelection: enableInteractiveSelection ?? (!obscureText || !readOnly),
          enableSuggestions: enableSuggestions,
          errorBorderColor: errorBorderColor,
          errorBuilder: errorBuilder,
          errorColor: errorColor,
          errorText: errorText,
          expands: expands,
          focusNode: focusNode,
          gap: gap,
          hasFloatingLabel: hasFloatingLabel,
          height: height,
          helper: helper,
          helperPadding: helperPadding,
          helperTextStyle: helperTextStyle,
          hintText: hintText,
          hintTextColor: hintTextColor,
          hoverBorderColor: hoverBorderColor,
          inactiveBorderColor: inactiveBorderColor,
          initialValue: initialValue,
          inputFormatters: inputFormatters,
          keyboardAppearance: keyboardAppearance,
          keyboardType: keyboardType,
          leading: leading,
          magnifierConfiguration: magnifierConfiguration,
          maxLength: maxLength,
          maxLengthEnforcement: maxLengthEnforcement,
          maxLines: maxLines,
          minLines: minLines,
          mouseCursor: mouseCursor,
          obscureText: obscureText,
          obscuringCharacter: obscuringCharacter,
          onAppPrivateCommand: onAppPrivateCommand,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          validationStatusCallback: validationStatusCallback,
          onSaved: onSaved,
          onSubmitted: onSubmitted,
          onTap: onTap,
          onTapAlwaysCalled: onTapAlwaysCalled,
          onTapOutside: onTapOutside,
          padding: padding,
          readOnly: readOnly,
          restorationId: restorationId,
          scribbleEnabled: scribbleEnabled,
          scrollController: scrollController,
          scrollPadding: scrollPadding,
          scrollPhysics: scrollPhysics,
          selectionControls: selectionControls,
          selectionHeightStyle: selectionHeightStyle,
          selectionWidthStyle: selectionWidthStyle,
          showCursor: showCursor,
          smartDashesType: smartDashesType ?? (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
          smartQuotesType: smartQuotesType ?? (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
          spellCheckConfiguration: spellCheckConfiguration,
          strutStyle: strutStyle,
          style: style,
          textAlign: textAlign,
          textAlignVertical: textAlignVertical,
          textCapitalization: textCapitalization,
          textColor: textColor,
          textDirection: textDirection,
          textInputAction: textInputAction,
          size: textInputSize,
          trailing: trailing,
          transitionCurve: transitionCurve,
          transitionDuration: transitionDuration,
          undoController: undoController,
          validator: validator,
          width: width,
        ),
        super(
          initialValue: controller != null ? controller.text : (initialValue ?? ""),
          enabled: enabled ?? true,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (field) {
            final _FormTextInputState state = field as _FormTextInputState;
            validationStatusCallback?.call(field.errorText);
            void onChangedHandler(String value) {
              field.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }

            return UnmanagedRestorationScope(
              bucket: field.bucket,
              child: TextInput(
                activeBorderColor: activeBorderColor,
                autocorrect: autocorrect,
                autofillHints: autofillHints,
                autofocus: autofocus,
                backgroundColor: backgroundColor,
                borderRadius: borderRadius,
                canRequestFocus: canRequestFocus,
                clipBehavior: clipBehavior,
                contentInsertionConfiguration: contentInsertionConfiguration,
                contextMenuBuilder: contextMenuBuilder,
                controller: state._effectiveController,
                cursorColor: cursorColor,
                cursorErrorColor: cursorErrorColor,
                cursorHeight: cursorHeight,
                cursorOpacityAnimates: cursorOpacityAnimates,
                cursorRadius: cursorRadius,
                cursorWidth: cursorWidth,
                decoration: decoration,
                dragStartBehavior: dragStartBehavior,
                enabled: enabled ?? true,
                enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
                enableInteractiveSelection: enableInteractiveSelection ?? (!obscureText || !readOnly),
                enableSuggestions: enableSuggestions,
                errorBorderColor: errorBorderColor,
                errorBuilder: errorBuilder,
                errorColor: errorColor,
                errorText: field.errorText ?? errorText,
                expands: expands,
                focusNode: focusNode,
                gap: gap,
                hasFloatingLabel: hasFloatingLabel,
                height: height,
                helper: helper,
                helperPadding: helperPadding,
                helperTextStyle: helperTextStyle,
                hintText: hintText,
                hintTextColor: hintTextColor,
                hoverBorderColor: hoverBorderColor,
                inactiveBorderColor: inactiveBorderColor,
                initialValue: initialValue,
                inputFormatters: inputFormatters,
                keyboardAppearance: keyboardAppearance,
                keyboardType: keyboardType,
                leading: leading,
                magnifierConfiguration: magnifierConfiguration,
                maxLength: maxLength,
                maxLengthEnforcement: maxLengthEnforcement,
                maxLines: maxLines,
                minLines: minLines,
                mouseCursor: mouseCursor,
                obscureText: obscureText,
                obscuringCharacter: obscuringCharacter,
                onAppPrivateCommand: onAppPrivateCommand,
                onChanged: onChangedHandler,
                onEditingComplete: onEditingComplete,
                onSubmitted: onSubmitted,
                onTap: onTap,
                onTapAlwaysCalled: onTapAlwaysCalled,
                onTapOutside: onTapOutside,
                padding: padding,
                readOnly: readOnly,
                restorationId: restorationId,
                scribbleEnabled: scribbleEnabled,
                scrollController: scrollController,
                scrollPadding: scrollPadding,
                scrollPhysics: scrollPhysics,
                selectionControls: selectionControls,
                selectionHeightStyle: selectionHeightStyle,
                selectionWidthStyle: selectionWidthStyle,
                showCursor: showCursor,
                smartDashesType: smartDashesType ?? (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
                smartQuotesType: smartQuotesType ?? (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
                spellCheckConfiguration: spellCheckConfiguration,
                strutStyle: strutStyle,
                style: style,
                textAlign: textAlign,
                textAlignVertical: textAlignVertical,
                textCapitalization: textCapitalization,
                textColor: textColor,
                textDirection: textDirection,
                textInputAction: textInputAction,
                size: textInputSize,
                trailing: trailing,
                transitionCurve: transitionCurve,
                transitionDuration: transitionDuration,
                undoController: undoController,
                width: width,
              ),
            );
          },
        );

  final TextEditingController? controller;

  @override
  FormFieldState<String> createState() => _FormTextInputState();
}

class _FormTextInputState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;
  TextEditingController get _effectiveController => _formTextInput.controller ?? _controller!.value;
  FormTextInput get _formTextInput => super.widget as FormTextInput;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }
    setValue(_effectiveController.text);
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, controllerRestorationId);
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null ? RestorableTextEditingController() : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  void initState() {
    super.initState();
    if (_formTextInput.controller == null) {
      _createLocalController(widget.initialValue != null ? TextEditingValue(text: widget.initialValue!) : null);
      return;
    }
    _formTextInput.controller!.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(FormTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_formTextInput.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _formTextInput.controller?.addListener(_handleControllerChanged);
      if (oldWidget.controller != null && _formTextInput.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }
      if (_formTextInput.controller != null) {
        setValue(_formTextInput.controller!.text);
        if (oldWidget.controller == null) {
          unregisterFromRestoration(_controller!);
          _controller!.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _formTextInput.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? "";
    }
  }

  @override
  void reset() {
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}

class FormTextInputConfiguration {
  final bool hasFloatingLabel;
  final TextCapitalization textCapitalization;
  final AutovalidateMode autovalidateMode;
  final bool canRequestFocus;
  final bool enabled;
  final double cursorWidth;
  final bool scribbleEnabled;
  final bool enableIMEPersonalizedLearning;
  final TextInputType keyboardType;
  final bool readOnly;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType smartDashesType;
  final SmartQuotesType smartQuotesType;
  final bool enableSuggestions;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final bool onTapAlwaysCalled;
  final bool expands;
  final Clip clipBehavior;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? activeBorderColor;
  final Color? errorBorderColor;
  final Color? inactiveBorderColor;
  final Color? errorColor;
  final Color? hoverBorderColor;
  final Color? textColor;
  final Color? hintTextColor;
  final Decoration? decoration;
  final double? gap;
  final double? height;
  final double? width;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? helperPadding;
  final FormTextInputValidationStatusCallback? validationStatusCallback;
  final BreakpointSize? size;
  final String? errorText;
  final String? hintText;
  final String? initialValue;
  final TextStyle? helperTextStyle;
  final TextInputErrorBuilder? errorBuilder;
  final Widget? leading;
  final Widget? trailing;
  final Widget? helper;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final int? maxLines;
  final int? minLines;
  final bool? showCursor;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final bool? cursorOpacityAnimates;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final ui.Brightness? keyboardAppearance;
  final TextSelectionControls? selectionControls;
  final DragStartBehavior dragStartBehavior;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final MouseCursor? mouseCursor;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final Iterable<String>? autofillHints;
  final String? restorationId;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final UndoHistoryController? undoController;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;

  const FormTextInputConfiguration({
    this.hasFloatingLabel = false,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.readOnly = false,
    this.autofocus = false,
    this.obscuringCharacter = boldDot,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.expands = false,
    this.enabled = true,
    this.cursorWidth = 2.0,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.scrollPadding = defaultFormTextInputScrollPadding,
    this.dragStartBehavior = DragStartBehavior.start,
    this.onTapAlwaysCalled = false,
    this.autofillHints = const <String>[],
    this.clipBehavior = Clip.hardEdge,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.borderRadius,
    this.backgroundColor,
    this.activeBorderColor,
    this.errorBorderColor,
    this.inactiveBorderColor,
    this.errorColor,
    this.hoverBorderColor,
    this.textColor,
    this.hintTextColor,
    this.decoration,
    this.gap,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.helperPadding,
    this.validationStatusCallback,
    this.size,
    this.errorText,
    this.hintText,
    this.initialValue,
    this.helperTextStyle,
    this.errorBuilder,
    this.leading,
    this.trailing,
    this.helper,
    this.controller,
    this.focusNode,
    this.undoController,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textAlignVertical,
    this.textDirection,
    this.showCursor,
    this.minLines,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorOpacityAnimates,
    this.cursorColor,
    this.cursorErrorColor,
    this.keyboardAppearance,
    this.selectionControls,
    this.onTap,
    this.onTapOutside,
    this.mouseCursor,
    this.scrollController,
    this.scrollPhysics,
    this.contentInsertionConfiguration,
    this.restorationId,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.onSaved,
    this.validator,
    TextInputType? keyboardType,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool? enableInteractiveSelection,
  })  : smartDashesType = smartDashesType ?? (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
        smartQuotesType = smartQuotesType ?? (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
        keyboardType = keyboardType ?? (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        enableInteractiveSelection = enableInteractiveSelection ?? (!readOnly || !obscureText);
}
