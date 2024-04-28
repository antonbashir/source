import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/assertions.dart';
import 'package:design/constants/borders.dart';
import 'package:design/constants/breakpoints.dart';
import 'package:design/constants/constants.dart';
import 'package:design/constants/restoration.dart';
import 'package:design/constants/text.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/model/state.dart';
import 'package:design/widgets/primitives/checks/spell.dart';
import 'package:design/widgets/views/containers/border.dart';
import 'package:design/widgets/magnifier/adaptive.dart';
import 'package:design/widgets/selection/selection.dart';
import 'package:design/widgets/primitives/text/error.dart';
import 'package:design/widgets/primitives/text/feedback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' as services show TextInputConfiguration;
import 'package:flutter/services.dart' hide TextInputConfiguration;
import 'package:flutter/widgets.dart';
export 'package:flutter/services.dart' show SmartDashesType, SmartQuotesType, TextCapitalization, TextInputAction, TextInputType;

typedef TextInputErrorBuilder = Widget Function(BuildContext context, String? errorText);

class TextInput extends StatefulWidget {
  final bool hasFloatingLabel;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType smartDashesType;
  final SmartQuotesType smartQuotesType;
  final bool enableSuggestions;
  final bool expands;
  final bool readOnly;
  final bool enabled;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final bool onTapAlwaysCalled;
  final Clip clipBehavior;
  final bool scribbleEnabled;
  final bool enableIMEPersonalizedLearning;
  final bool canRequestFocus;
  final BorderType? borderType;
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
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
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
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final bool? cursorOpacityAnimates;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final Brightness? keyboardAppearance;
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

  const TextInput({
    super.key,
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
    this.scrollPadding = defaultTextInputScrollPadding,
    this.dragStartBehavior = DragStartBehavior.start,
    this.onTapAlwaysCalled = false,
    this.autofillHints = const <String>[],
    this.clipBehavior = Clip.hardEdge,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.borderType,
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
    TextInputType? keyboardType,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool? enableInteractiveSelection,
  })  : assert(obscuringCharacter.length == 1),
        smartDashesType = smartDashesType ?? (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
        smartQuotesType = smartQuotesType ?? (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert((maxLines == null) || (minLines == null) || (maxLines >= minLines), testMinLinesAssertion),
        assert(!expands || (maxLines == null && minLines == null), testMinLinesWithExpandsAssertion),
        assert(!obscureText || maxLines == 1, testObscuredFieldsAssertion),
        assert(maxLength == null || maxLength == textNoMaxLength || maxLength > 0),
        assert(
          !identical(textInputAction, TextInputAction.newline) || maxLines == 1 || !identical(keyboardType, TextInputType.text),
          textKeyboardTypeWithNewLineAssertion,
        ),
        keyboardType = keyboardType ?? (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        enableInteractiveSelection = enableInteractiveSelection ?? (!readOnly || !obscureText);

  bool get selectionEnabled => enableInteractiveSelection;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> with RestorationMixin implements TextSelectionGestureDetectorBuilderDelegate, AutofillClient {
  @override
  final GlobalKey<EditableTextState> editableTextKey = GlobalKey<EditableTextState>();

  @override
  late bool forcePressEnabled;

  late _TextInputSelectionGestureDetectorBuilder _selectionGestureDetectorBuilder;

  RestorableTextEditingController? _controller;
  FocusNode? _focusNode;
  bool _isHovering = false;
  bool _showSelectionHandles = false;

  bool get _isEnabled => widget.enabled;
  bool get _hasError => _hasIntrinsicError || widget.errorText != null;
  bool get _hasFocus => _effectiveFocusNode.hasFocus;
  int get _currentLength => _effectiveController.value.text.characters.length;
  EditableTextState? get _editableText => editableTextKey.currentState;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());
  TextEditingController get _effectiveController => widget.controller ?? _controller!.value;

  bool get _canRequestFocus => switch (MediaQuery.maybeNavigationModeOf(context) ?? NavigationMode.traditional) {
        NavigationMode.traditional => widget.canRequestFocus && _isEnabled,
        NavigationMode.directional => true,
      };

  bool get _hasIntrinsicError =>
      widget.maxLength != null &&
      widget.maxLength! > 0 &&
      (widget.controller == null ? !restorePending && _effectiveController.value.text.characters.length > widget.maxLength! : _effectiveController.value.text.characters.length > widget.maxLength!);

  MaxLengthEnforcement get _effectiveMaxLengthEnforcement => widget.maxLengthEnforcement ?? LengthLimitingTextInputFormatter.getDefaultMaxLengthEnforcement(defaultTargetPlatform);

  Set<VisualState> get _materialState => <VisualState>{
        if (!_isEnabled) VisualState.disabled,
        if (_isHovering) VisualState.hovered,
        if (_hasFocus) VisualState.focused,
        if (_hasError) VisualState.error,
      };

  @override
  String? get restorationId => widget.restorationId;

  @override
  String get autofillId => _editableText!.autofillId;

  @override
  bool get selectionEnabled => widget.selectionEnabled;

  @override
  services.TextInputConfiguration get textInputConfiguration {
    final List<String>? autofillHints = widget.autofillHints?.toList(growable: false);
    final AutofillConfiguration autofillConfiguration = autofillHints != null
        ? AutofillConfiguration(
            uniqueIdentifier: autofillId,
            autofillHints: autofillHints,
            currentEditingValue: _effectiveController.value,
          )
        : AutofillConfiguration.disabled;

    return _editableText!.textInputConfiguration.copyWith(autofillConfiguration: autofillConfiguration);
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null ? RestorableTextEditingController() : RestorableTextEditingController.fromValue(value);
    if (!restorePending) _registerController();
  }

  void _handleFocusChanged() {
    setState(() {});
  }

  void _handleSelectionChanged(TextSelection selection, SelectionChangedCause? cause) {
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);

    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() => _showSelectionHandles = willShowSelectionHandles);
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        if (cause == SelectionChangedCause.longPress) _editableText?.bringIntoView(selection.extent);
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        break;
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        if (cause == SelectionChangedCause.drag) _editableText?.hideToolbar();
    }
  }

  void _handleHover(bool hovering) {
    if (!_isEnabled) return;
    if (hovering != _isHovering) {
      setState(() => _isHovering = hovering);
    }
  }

  void _handleSelectionHandleTapped() {
    if (_effectiveController.selection.isCollapsed) {
      _editableText!.toggleToolbar();
    }
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, controllerRestorationId);
  }

  void _requestKeyboard() {
    _editableText?.requestKeyboard();
  }

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    if (!_selectionGestureDetectorBuilder.shouldShowSelectionToolbar) return false;
    if (cause == SelectionChangedCause.keyboard) return false;
    if (widget.readOnly && _effectiveController.selection.isCollapsed) return false;
    if (!_isEnabled) return false;
    if (cause == SelectionChangedCause.longPress || cause == SelectionChangedCause.scribble) return true;
    if (_effectiveController.text.isNotEmpty) return true;
    return false;
  }

  @override
  void autofill(TextEditingValue newEditingValue) => _editableText!.autofill(newEditingValue);

  @override
  void initState() {
    super.initState();
    _selectionGestureDetectorBuilder = _TextInputSelectionGestureDetectorBuilder(state: this);
    if (widget.controller == null) _createLocalController();
    _effectiveFocusNode.canRequestFocus = widget.canRequestFocus && _isEnabled;
    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _effectiveFocusNode.canRequestFocus = _canRequestFocus;
  }

  @override
  void didUpdateWidget(TextInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller == null && oldWidget.controller != null) {
      _createLocalController(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      unregisterFromRestoration(_controller!);
      _controller!.dispose();
      _controller = null;
    }

    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }

    _effectiveFocusNode.canRequestFocus = _canRequestFocus;

    if (_hasFocus && widget.readOnly != oldWidget.readOnly && _isEnabled) {
      if (_effectiveController.selection.isCollapsed) {
        _showSelectionHandles = !widget.readOnly;
      }
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_controller != null) _registerController();
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectionStyle = DefaultSelectionStyle.of(context);
    final keyboardAppearance = widget.keyboardAppearance ?? context.theme.brightness;
    final controller = _effectiveController;
    final focusNode = _effectiveFocusNode;
    final effectiveTextInputConfiguration = context.theme.textInputTheme().configuration.select(widget.size);
    final effectiveBorderType = widget.borderType ?? effectiveTextInputConfiguration.borderType;
    final effectiveBorderRadius = widget.borderRadius ?? effectiveTextInputConfiguration.borderRadius;
    final effectiveBackgroundColor = widget.backgroundColor ?? context.theme.textInputTheme().style.backgroundColor;
    final effectiveActiveBorderColor = widget.activeBorderColor ?? context.theme.textInputTheme().style.activeBorderColor;
    final effectiveInactiveBorderColor = widget.inactiveBorderColor ?? context.theme.textInputTheme().style.inactiveBorderColor;
    final effectiveErrorColor = widget.errorColor ?? context.theme.textInputTheme().style.errorColor;
    final effectiveCursorErrorColor = widget.cursorErrorColor ?? context.theme.textInputTheme().style.errorColor;
    final effectiveHoverBorderColor = widget.hoverBorderColor ?? context.theme.textInputTheme().style.hoverBorderColor;
    final effectiveTextColor = widget.textColor ?? context.theme.textInputTheme().style.textColor;
    final effectiveHintTextColor = widget.hintTextColor ?? context.theme.textInputTheme().style.helperTextColor;
    final effectiveGap = widget.gap ?? effectiveTextInputConfiguration.gap;
    final effectiveHeight = widget.height ?? effectiveTextInputConfiguration.height;
    final effectiveDisabledOpacityValue = context.tokens.opacities.disabled;
    final effectiveTransitionDuration = widget.transitionDuration ?? context.theme.textInputTheme().style.transitionDuration;
    final effectiveTransitionCurve = widget.transitionCurve ?? context.theme.textInputTheme().style.transitionCurve;
    final effectivePadding = widget.padding ?? effectiveTextInputConfiguration.padding;
    final resolvedContentPadding = effectivePadding.resolve(Directionality.of(context));
    final effectiveHelperPadding = widget.helperPadding ?? effectiveTextInputConfiguration.helperPadding;
    final effectiveTextStyle = widget.style ?? effectiveTextInputConfiguration.textStyle;
    final effectiveHelperTextStyle = widget.helperTextStyle ?? effectiveTextInputConfiguration.helperTextStyle;

    final defaultBorder = switch (effectiveBorderType) {
      BorderType.rounded => RoundedRectangleBorder(
          borderRadius: effectiveBorderRadius,
          side: BorderSide(
            color: effectiveInactiveBorderColor,
            width: context.borders.inactiveWidth,
          ),
        ),
      BorderType.squircle => SquircleBorder(
          borderRadius: effectiveBorderRadius.squircle(context),
          side: BorderSide(
            color: effectiveInactiveBorderColor,
            width: context.borders.inactiveWidth,
          ),
        )
    };

    final hoverBorder = switch (effectiveBorderType) {
      BorderType.rounded => RoundedRectangleBorder(
          borderRadius: effectiveBorderRadius,
          side: BorderSide(
            color: effectiveHoverBorderColor,
            width: context.borders.activeWidth,
          ),
        ),
      BorderType.squircle => SquircleBorder(
          borderRadius: effectiveBorderRadius.squircle(context),
          side: BorderSide(
            color: effectiveHoverBorderColor,
            width: context.borders.activeWidth,
          ),
        )
    };

    final focusBorder = switch (effectiveBorderType) {
      BorderType.rounded => RoundedRectangleBorder(
          borderRadius: effectiveBorderRadius,
          side: BorderSide(
            color: effectiveActiveBorderColor,
            width: context.borders.activeWidth,
          ),
        ),
      BorderType.squircle => SquircleBorder(
          borderRadius: effectiveBorderRadius.squircle(context),
          side: BorderSide(
            color: effectiveActiveBorderColor,
            width: context.borders.activeWidth,
          ),
        ),
    };

    final errorBorder = switch (effectiveBorderType) {
      BorderType.rounded => RoundedRectangleBorder(
          borderRadius: effectiveBorderRadius,
          side: BorderSide(
            color: widget.errorBorderColor ?? effectiveErrorColor,
            width: context.borders.activeWidth,
          ),
        ),
      BorderType.squircle => SquircleBorder(
          borderRadius: effectiveBorderRadius.squircle(context),
          side: BorderSide(
            color: widget.errorBorderColor ?? effectiveErrorColor,
            width: context.borders.activeWidth,
          ),
        ),
    };

    final resolvedBorder = _hasError
        ? errorBorder
        : _hasFocus
            ? focusBorder
            : _isHovering
                ? hoverBorder
                : defaultBorder;

    bool? cursorOpacityAnimates = widget.cursorOpacityAnimates;
    Color? autocorrectionTextRectColor;
    Offset? cursorOffset;
    Radius? cursorRadius = widget.cursorRadius;
    VoidCallback? handleDidGainAccessibilityFocus;

    final bool paintCursorAboveText;
    final Color cursorColor;
    final Color selectionColor;
    final TextSelectionControls? textSelectionControls = widget.selectionControls;

    final MouseCursor effectiveMouseCursor = VisualStateProperty.resolveAs<MouseCursor>(
      widget.mouseCursor ?? VisualStateMouseCursor.textable,
      _materialState,
    );

    final List<TextInputFormatter> formatters = <TextInputFormatter>[
      ...?widget.inputFormatters,
      if (widget.maxLength != null)
        LengthLimitingTextInputFormatter(
          widget.maxLength,
          maxLengthEnforcement: _effectiveMaxLengthEnforcement,
        ),
    ];

    final SpellCheckConfiguration spellCheckConfiguration;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        spellCheckConfiguration = CupertinoTextField.inferIOSSpellCheckConfiguration(widget.spellCheckConfiguration);
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        spellCheckConfiguration = inferAndroidSpellCheckConfiguration(context, widget.spellCheckConfiguration);
    }

    final int? semanticsMaxValueLength = _effectiveMaxLengthEnforcement != MaxLengthEnforcement.none && widget.maxLength != null && widget.maxLength! > 0 ? widget.maxLength : null;

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
        forcePressEnabled = true;
        paintCursorAboveText = true;
        cursorOpacityAnimates ??= true;
        cursorColor = _hasError ? effectiveCursorErrorColor : widget.cursorColor ?? effectiveTextColor;
        selectionColor = selectionStyle.selectionColor ?? cupertinoTheme.primaryColor.withOpacity(0.40);
        cursorRadius ??= const Radius.circular(2.0);
        cursorOffset = Offset(cursorIOSHorizontalOffset / MediaQuery.devicePixelRatioOf(context), 0);
        autocorrectionTextRectColor = selectionColor;

      case TargetPlatform.macOS:
        final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
        forcePressEnabled = false;
        paintCursorAboveText = true;
        cursorOpacityAnimates ??= false;
        cursorColor = _hasError ? effectiveCursorErrorColor : widget.cursorColor ?? effectiveTextColor;
        selectionColor = selectionStyle.selectionColor ?? cupertinoTheme.primaryColor.withOpacity(0.40);
        cursorRadius ??= const Radius.circular(2.0);
        cursorOffset = Offset(cursorIOSHorizontalOffset / MediaQuery.devicePixelRatioOf(context), 0);
        handleDidGainAccessibilityFocus = () {
          if (!_hasFocus && _effectiveFocusNode.canRequestFocus) {
            _effectiveFocusNode.requestFocus();
          }
        };

      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        forcePressEnabled = false;
        paintCursorAboveText = false;
        cursorOpacityAnimates ??= false;
        cursorColor = _hasError ? effectiveCursorErrorColor : widget.cursorColor ?? effectiveTextColor;
        selectionColor = selectionStyle.selectionColor ?? context.colors.main.withOpacity(0.40);

      case TargetPlatform.linux:
        forcePressEnabled = false;
        paintCursorAboveText = false;
        cursorOpacityAnimates ??= false;
        cursorColor = _hasError ? effectiveCursorErrorColor : widget.cursorColor ?? effectiveTextColor;
        selectionColor = selectionStyle.selectionColor ?? context.colors.main.withOpacity(0.40);

      case TargetPlatform.windows:
        forcePressEnabled = false;
        paintCursorAboveText = false;
        cursorOpacityAnimates ??= false;
        cursorColor = _hasError ? effectiveCursorErrorColor : widget.cursorColor ?? effectiveTextColor;
        selectionColor = selectionStyle.selectionColor ?? context.colors.main.withOpacity(0.40);
        handleDidGainAccessibilityFocus = () {
          if (!_hasFocus && _effectiveFocusNode.canRequestFocus) {
            _effectiveFocusNode.requestFocus();
          }
        };
    }

    Widget child = RepaintBoundary(
      child: UnmanagedRestorationScope(
        bucket: bucket,
        child: EditableText(
          key: editableTextKey,
          autocorrect: widget.autocorrect,
          autocorrectionTextRectColor: autocorrectionTextRectColor,
          autofillClient: this,
          autofocus: widget.autofocus,
          backgroundCursorColor: CupertinoColors.inactiveGray,
          clipBehavior: widget.clipBehavior,
          contentInsertionConfiguration: widget.contentInsertionConfiguration,
          contextMenuBuilder: widget.contextMenuBuilder,
          controller: controller,
          cursorColor: cursorColor,
          cursorHeight: widget.cursorHeight,
          cursorOffset: cursorOffset,
          cursorOpacityAnimates: cursorOpacityAnimates,
          cursorRadius: cursorRadius,
          cursorWidth: widget.cursorWidth,
          dragStartBehavior: widget.dragStartBehavior,
          enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          enableSuggestions: widget.enableSuggestions,
          expands: widget.expands,
          focusNode: focusNode,
          inputFormatters: formatters,
          keyboardAppearance: keyboardAppearance,
          keyboardType: widget.keyboardType,
          magnifierConfiguration: widget.magnifierConfiguration ?? TextMagnifier.adaptiveMagnifierConfiguration,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          mouseCursor: MouseCursor.defer,
          obscureText: widget.obscureText,
          obscuringCharacter: widget.obscuringCharacter,
          onAppPrivateCommand: widget.onAppPrivateCommand,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onSelectionChanged: _handleSelectionChanged,
          onSelectionHandleTapped: _handleSelectionHandleTapped,
          onSubmitted: widget.onSubmitted,
          onTapOutside: widget.onTapOutside,
          paintCursorAboveText: paintCursorAboveText,
          readOnly: widget.readOnly || !_isEnabled,
          rendererIgnoresPointer: true,
          restorationId: editableRestorationId,
          scribbleEnabled: widget.scribbleEnabled,
          scrollController: widget.scrollController,
          scrollPadding: widget.scrollPadding,
          scrollPhysics: widget.scrollPhysics,
          selectionColor: focusNode.hasFocus ? selectionColor : null,
          selectionControls: widget.selectionEnabled ? textSelectionControls : null,
          selectionHeightStyle: widget.selectionHeightStyle,
          selectionWidthStyle: widget.selectionWidthStyle,
          showCursor: widget.showCursor,
          showSelectionHandles: _showSelectionHandles,
          smartDashesType: widget.smartDashesType,
          smartQuotesType: widget.smartQuotesType,
          spellCheckConfiguration: spellCheckConfiguration,
          strutStyle: widget.strutStyle,
          style: effectiveTextStyle.copyWith(color: effectiveTextColor),
          textAlign: widget.textAlign,
          textCapitalization: widget.textCapitalization,
          textDirection: widget.textDirection,
          textInputAction: widget.textInputAction,
          undoController: widget.undoController,
        ),
      ),
    );

    child = AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[focusNode, controller]),
      builder: (context, child) => BorderContainer(
        backgroundColor: effectiveBackgroundColor,
        border: resolvedBorder,
        decoration: widget.decoration,
        expands: widget.expands,
        width: widget.width,
        height: effectiveHeight,
        duration: effectiveTransitionDuration,
        curve: effectiveTransitionCurve,
        child: Row(
          crossAxisAlignment: widget.expands ? CrossAxisAlignment.center : CrossAxisAlignment.stretch,
          children: [
            if (widget.leading != null)
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: resolvedContentPadding.left,
                  end: effectiveGap,
                ),
                child: widget.leading,
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: widget.leading != null ? 0 : resolvedContentPadding.left,
                  end: widget.trailing != null ? 0 : resolvedContentPadding.right,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: widget.hasFloatingLabel
                          ? Alignment.bottomCenter
                          : widget.textAlignVertical == TextAlignVertical.top
                              ? Alignment.topCenter
                              : Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: resolvedContentPadding.bottom),
                        child: child,
                      ),
                    ),
                    if (widget.hintText != null)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: resolvedContentPadding.top),
                        child: AnimatedScale(
                          alignment: Directionality.of(context) == TextDirection.ltr ? Alignment.topLeft : Alignment.topRight,
                          duration: effectiveTransitionDuration,
                          scale: widget.hasFloatingLabel && (focusNode.hasFocus || controller.value.text.isNotEmpty) ? 0.75 : 1.0,
                          child: AnimatedAlign(
                            duration: effectiveTransitionDuration,
                            alignment: widget.textAlignVertical == TextAlignVertical.top || (widget.hasFloatingLabel && (focusNode.hasFocus || controller.value.text.isNotEmpty))
                                ? AlignmentDirectional.topStart
                                : AlignmentDirectional.centerStart,
                            child: AnimatedOpacity(
                              opacity: (controller.value.text.isEmpty || widget.hasFloatingLabel) ? 1.0 : 0.0,
                              duration: effectiveTransitionDuration,
                              curve: effectiveTransitionCurve,
                              child: Text(
                                widget.hintText!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: widget.textAlign,
                                style: effectiveTextStyle.copyWith(color: effectiveHintTextColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (widget.trailing != null)
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: effectiveGap,
                  end: resolvedContentPadding.right,
                ),
                child: widget.trailing,
              ),
          ],
        ),
      ),
      child: child,
    );

    child = AnimatedOpacity(
      opacity: widget.enabled ? 1.0 : effectiveDisabledOpacityValue,
      curve: effectiveTransitionCurve,
      duration: effectiveTransitionDuration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          if (widget.helper != null || (widget.errorText != null))
            RepaintBoundary(
              child: IconTheme(
                data: IconThemeData(
                  color: widget.errorText != null ? effectiveErrorColor : effectiveHintTextColor,
                ),
                child: DefaultTextStyle(
                  style: effectiveHelperTextStyle.copyWith(
                    color: widget.errorText != null ? effectiveErrorColor : effectiveHintTextColor,
                  ),
                  child: widget.errorText != null
                      ? widget.errorBuilder?.call(context, widget.errorText) ??
                          Padding(
                            padding: effectiveHelperPadding,
                            child: TextErrorMessage(errorText: widget.errorText!),
                          )
                      : Padding(
                          padding: effectiveHelperPadding,
                          child: widget.helper,
                        ),
                ),
              ),
            ),
        ],
      ),
    );

    return MouseRegion(
      cursor: effectiveMouseCursor,
      onEnter: (PointerEnterEvent event) => _handleHover(true),
      onExit: (PointerExitEvent event) => _handleHover(false),
      child: TextFieldTapRegion(
        child: IgnorePointer(
          ignoring: !_isEnabled,
          child: AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget? child) => Semantics(
              maxValueLength: semanticsMaxValueLength,
              currentValueLength: _currentLength,
              onTap: widget.readOnly
                  ? null
                  : () {
                      if (!_effectiveController.selection.isValid) {
                        _effectiveController.selection = TextSelection.collapsed(offset: _effectiveController.text.length);
                      }
                      _requestKeyboard();
                    },
              onDidGainAccessibilityFocus: handleDidGainAccessibilityFocus,
              child: child,
            ),
            child: _selectionGestureDetectorBuilder.buildGestureDetector(
              behavior: HitTestBehavior.translucent,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class _TextInputSelectionGestureDetectorBuilder extends TextSelectionGestureDetectorBuilder {
  _TextInputSelectionGestureDetectorBuilder({
    required _TextInputState state,
  })  : _state = state,
        super(delegate: state);

  final _TextInputState _state;

  @override
  void onForcePressStart(ForcePressDetails details) {
    super.onForcePressStart(details);
    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editableText.showToolbar();
    }
  }

  @override
  void onForcePressEnd(ForcePressDetails details) {}

  @override
  void onSingleTapUp(TapDragUpDetails details) {
    super.onSingleTapUp(details);
    _state._requestKeyboard();
  }

  @override
  bool get onUserTapAlwaysCalled => _state.widget.onTapAlwaysCalled;

  @override
  void onUserTap() {
    _state.widget.onTap?.call();
  }

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    super.onSingleLongTapStart(details);
    if (delegate.selectionEnabled) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          Feedback.forLongPress(_state.context);
      }
    }
  }
}
