// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/widgets.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:linked_scroll_controller/linked_scroll_controller.dart';

// import '../code_extensions/editable_text.dart';
// import '../code_theme/code_theme.dart';
// import '../line_numbers/line_number_controller.dart';
// import '../line_numbers/line_number_style.dart';
// import 'code_auto_complete.dart';
// import 'code_controller.dart';

// class CodeField extends StatefulWidget {
//   /// {@macro flutter.widgets.textField.size32artQuotesType}
//   final SmartQuotesType? smartQuotesType;

//   /// {@macro flutter.widgets.textField.keyboardType}
//   final TextInputType? keyboardType;

//   /// {@macro flutter.widgets.textField.minLines}
//   final int? minLines;

//   /// {@macro flutter.widgets.textField.maxLInes}
//   final int? maxLines;

//   /// {@macro flutter.widgets.textField.expands}
//   final bool expands;

//   /// Whether overflowing lines should wrap around or make the field scrollable horizontally
//   final bool wrap;

//   /// A CodeController instance to apply language highlight, themeing and modifiers
//   final CodeController controller;

//   /// A LineNumberStyle instance to tweak the line number column styling
//   final LineNumberStyle lineNumberStyle;

//   /// {@macro flutter.widgets.textField.cursorColor}
//   final Color? cursorColor;

//   /// {@macro flutter.widgets.textField.textStyle}
//   final TextStyle? textStyle;

//   /// A way to replace specific line numbers by a custom TextSpan
//   final TextSpan Function(int, TextStyle?)? lineNumberBuilder;

//   /// {@macro flutter.widgets.textField.enabled}
//   final bool? enabled;

//   /// {@macro flutter.widgets.editableText.onChanged}
//   final void Function(String)? onChanged;

//   /// {@macro flutter.widgets.editableText.readOnly}
//   final bool readOnly;

//   /// {@macro flutter.widgets.textField.isDense}
//   final bool isDense;

//   /// {@macro flutter.widgets.textField.selectionControls}
//   final TextSelectionControls? selectionControls;

//   final Color? background;
//   final EdgeInsets padding;
//   final EdgeInsets containerPadding;
//   final Decoration? decoration;
//   final TextSelectionThemeData? textSelectionTheme;
//   final FocusNode? focusNode;
//   final void Function()? onTap;
//   final bool lineNumbers;
//   final bool horizontalScroll;
//   final String? hintText;
//   final TextStyle? hintStyle;
//   final CodeAutoComplete? autoComplete;

//   final GlobalKey<EditableTextState> editableKey = GlobalKey();

//   CodeField({
//     Key? key,
//     required this.controller,
//     this.minLines,
//     this.maxLines,
//     this.expands = false,
//     this.wrap = false,
//     this.background,
//     this.decoration,
//     this.textStyle,
//     this.padding = EdgeInsets.zero,
//     this.containerPadding = EdgeInsets.zero,
//     this.lineNumberStyle = const LineNumberStyle(),
//     this.enabled,
//     this.onTap,
//     this.readOnly = false,
//     this.cursorColor,
//     this.textSelectionTheme,
//     this.lineNumberBuilder,
//     this.focusNode,
//     this.onChanged,
//     this.isDense = false,
//     this.size32artQuotesType,
//     this.keyboardType,
//     this.lineNumbers = true,
//     this.horizontalScroll = true,
//     this.selectionControls,
//     this.hintText,
//     this.hintStyle,
//     this.autoComplete,
//   }) : super(key: key);

//   @override
//   State<CodeField> createState() => _CodeFieldState();
// }

// class _CodeFieldState extends State<CodeField> {
//   // Add a controller
//   LinkedScrollControllerGroup? _controllers;
//   ScrollController? _numberScroll;
//   ScrollController? _codeScroll;
//   LineNumberController? _numberController;

//   StreamSubscription<bool>? _keyboardVisibilitySubscription;
//   late FocusNode _focusNode;
//   String? lines;
//   String longestLine = '';

//   @override
//   void initState() {
//     super.initState();
//     _controllers = LinkedScrollControllerGroup();
//     _numberScroll = _controllers?.addAndGet();
//     _codeScroll = _controllers?.addAndGet();
//     _numberController = LineNumberController(widget.lineNumberBuilder);
//     widget.controller.addListener(_onTextChanged);
//     _focusNode = widget.focusNode ?? FocusNode();
//     _focusNode.onKeyEvent = _onKeyEvent;
//     _focusNode.attach(context, onKeyEvent: _onKeyEvent);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final state = widget.editableKey.currentState as EditableTextState;
//       state.renderEditable.painter = TextSelectionPainter(selections: widget.controller.selections);
//       createAutoComplete();
//     });

//     _onTextChanged();
//   }

//   void createAutoComplete() {
//     widget.autoComplete?.show(context, widget, _focusNode);
//     widget.controller.autoComplete = widget.autoComplete;
//     _codeScroll?.addListener(hideAutoComplete);
//   }

//   KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
//     if (widget.readOnly) {
//       return KeyEventResult.ignored;
//     }

//     return widget.controller.onKeyEvent(event);
//   }

//   @override
//   void dispose() {
//     widget.controller.removeListener(_onTextChanged);
//     _numberScroll?.dispose();
//     _codeScroll?.dispose();
//     _numberController?.dispose();
//     _keyboardVisibilitySubscription?.cancel();
//     widget.autoComplete?.remove();
//     super.dispose();
//   }

//   void rebuild() {
//     setState(() {});
//   }

//   void _onTextChanged() {
//     // Rebuild line number
//     final str = widget.controller.text.split('\n');
//     final buf = <String>[];

//     for (var k = 0; k < str.length; k++) {
//       buf.add((k + 1).toString());
//     }

//     _numberController?.text = buf.join('\n');

//     // Find longest line
//     longestLine = '';
//     widget.controller.text.split('\n').forEach((line) {
//       if (line.length > longestLine.length) longestLine = line;
//     });

//     if (widget.editableKey.currentState is EditableTextState) {
//       final state = widget.editableKey.currentState as EditableTextState;
//       if (state.renderEditable.painter is TextSelectionPainter) {
//         (state.renderEditable.painter as TextSelectionPainter).selections = widget.controller.selections;
//       }
//     }

//     setState(() {});
//   }

//   // Wrap the codeField in a horizontal scrollView
//   Widget _wrapInScrollView(
//     Widget codeField,
//     TextStyle textStyle,
//     double minWidth,
//   ) {
//     final leftPad = widget.lineNumberStyle.margin / 2;
//     final intrinsic = IntrinsicWidth(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ConstrainedBox(
//             constraints: BoxConstraints(
//               maxHeight: 0,
//               minWidth: max(minWidth - leftPad, 0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(right: 16),
//               child: Text(longestLine, style: textStyle),
//             ), // Add extra padding
//           ),
//           widget.expands ? Expanded(child: codeField) : codeField,
//         ],
//       ),
//     );

//     return SingleChildScrollView(
//       padding: EdgeInsets.only(
//         left: leftPad,
//         right: widget.padding.right,
//       ),
//       scrollDirection: Axis.horizontal,

//       /// Prevents the horizontal scroll if horizontalScroll is false
//       physics: widget.horizontalScroll ? null : const NeverScrollableScrollPhysics(),
//       child: intrinsic,
//     );
//   }

//   void removeAutoComplete() {
//     widget.autoComplete?.remove();
//   }

//   void hideAutoComplete() {
//     widget.autoComplete?.hide();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Default color scheme
//     const rootKey = 'root';
//     final defaultBg = Colors.grey.shade900;
//     final defaultText = Colors.grey.shade200;

//     final styles = CodeTheme.of(context)?.styles;
//     Color? backgroundCol = widget.background ?? styles?[rootKey]?.backgroundColor ?? defaultBg;

//     if (widget.decoration != null) {
//       backgroundCol = null;
//     }

//     TextStyle textStyle = widget.textStyle ?? const TextStyle();
//     textStyle = textStyle.copyWith(
//       color: textStyle.color ?? styles?[rootKey]?.color ?? defaultText,
//       fontSize: textStyle.fontSize ?? 16.0,
//     );

//     TextStyle numberTextStyle = widget.lineNumberStyle.textStyle ?? const TextStyle();
//     final numberColor = (styles?[rootKey]?.color ?? defaultText).withOpacity(0.7);

//     // Copy important attributes
//     numberTextStyle = numberTextStyle.copyWith(
//       color: numberTextStyle.color ?? numberColor,
//       fontSize: textStyle.fontSize,
//       fontFamily: textStyle.fontFamily,
//     );

//     final cursorColor = widget.cursorColor ?? styles?[rootKey]?.color ?? defaultText;

//     Widget? lineNumberCol;
//     Container? numberCol;

//     if (widget.lineNumbers) {
//       lineNumberCol = RawKeyboardListener(
//         focusNode: _focusNode,
//         child: TextField(
//           smartQuotesType: widget.size32artQuotesType,
//           scrollPadding: widget.padding,
//           style: numberTextStyle,
//           controller: _numberController,
//           enabled: false,
//           minLines: widget.minLines,
//           maxLines: widget.maxLines,
//           selectionControls: widget.selectionControls,
//           expands: widget.expands,
//           scrollController: _numberScroll,
//           decoration: InputDecoration(
//             disabledBorder: InputBorder.none,
//             isDense: widget.isDense,
//           ),
//           textAlign: widget.lineNumberStyle.textAlign,
//         ),
//       );

//       numberCol = Container(
//         width: widget.lineNumberStyle.width,
//         padding: EdgeInsets.only(
//           left: widget.padding.left,
//           right: widget.lineNumberStyle.margin / 2,
//         ),
//         color: widget.lineNumberStyle.background,
//         child: lineNumberCol,
//       );
//     }

//     final codeField = CustomTextField(
//       editableKey: widget.editableKey,
//       keyboardType: widget.keyboardType,
//       smartQuotesType: widget.size32artQuotesType,
//       focusNode: _focusNode,
//       onTap: () {
//         widget.autoComplete?.hide();
//         widget.onTap?.call();
//       },
//       scrollPadding: widget.padding,
//       style: textStyle,
//       controller: widget.controller,
//       minLines: widget.minLines,
//       selectionControls: widget.selectionControls,
//       maxLines: widget.maxLines,
//       expands: widget.expands,
//       scrollController: _codeScroll,
//       decoration: InputDecoration(
//         disabledBorder: InputBorder.none,
//         border: InputBorder.none,
//         focusedBorder: InputBorder.none,
//         isDense: widget.isDense,
//         hintText: widget.hintText,
//         hintStyle: widget.hintStyle,
//       ),
//       onTapOutside: (e) {
//         Future.delayed(const Duration(milliseconds: 300), hideAutoComplete);
//       },
//       cursorColor: cursorColor,
//       autocorrect: false,
//       enableSuggestions: false,
//       enabled: widget.enabled,
//       onChanged: (text) {
//         widget.onChanged?.call(text);
//         widget.autoComplete?.streamController.add(text);
//       },
//       readOnly: widget.readOnly,
//     );

//     final codeCol = Theme(
//       data: Theme.of(context).copyWith(
//         textSelectionTheme: widget.textSelectionTheme,
//       ),
//       child: LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//           // Control horizontal scrolling
//           return widget.wrap ? codeField : _wrapInScrollView(codeField, textStyle, constraints.maxWidth);
//         },
//       ),
//     );

//     return Container(
//       decoration: widget.decoration,
//       color: backgroundCol,
//       padding: !widget.lineNumbers ? widget.containerPadding : null,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (widget.lineNumbers && numberCol != null) numberCol,
//           Expanded(child: codeCol),
//         ],
//       ),
//     );
//   }
// }

// class TextSelectionPainter extends RenderEditablePainter {
//   Map<TextSelection, Color> _selections;

//   TextSelectionPainter({
//     Map<TextSelection, Color> selections = const {},
//   }) : _selections = selections;

//   set selections(Map<TextSelection, Color> value) {
//     _selections = value;
//     notifyListeners();
//   }

//   @override
//   void paint(Canvas canvas, Size size, RenderEditable renderEditable) {
//     if (_selections.isEmpty) {
//       return;
//     }
//     if (_selections.keys.every((element) => element == const TextSelection.collapsed(offset: -1))) {
//       return;
//     }

//     _selections.forEach((key, value) {
//       final selectionBoxes = renderEditable.getBoxesForSelection(key);

//       for (final box in selectionBoxes) {
//         final rawRect = box.toRect();
//         final rect = Rect.fromLTWH(rawRect.left, rawRect.top - 2, rawRect.width, rawRect.height + 4);

//         canvas.drawRect(
//           rect.width > 0 ? rect : Rect.fromLTWH(rect.left, rect.top, 5, rect.height),
//           Paint()..color = value,
//         );
//       }
//     });
//   }

//   @override
//   bool shouldRepaint(RenderEditablePainter? oldDelegate) {
//     return true;
//   }
// }

// class CompositeRenderEditablePainter extends RenderEditablePainter {
//   CompositeRenderEditablePainter({required this.painters});

//   final List<RenderEditablePainter> painters;

//   @override
//   void addListener(VoidCallback listener) {
//     for (final RenderEditablePainter painter in painters) {
//       painter.addListener(listener);
//     }
//   }

//   @override
//   void removeListener(VoidCallback listener) {
//     for (final RenderEditablePainter painter in painters) {
//       painter.removeListener(listener);
//     }
//   }

//   @override
//   void paint(Canvas canvas, Size size, RenderEditable renderEditable) {
//     for (final RenderEditablePainter painter in painters) {
//       painter.paint(canvas, size, renderEditable);
//     }
//   }

//   @override
//   bool shouldRepaint(RenderEditablePainter? oldDelegate) {
//     if (identical(oldDelegate, this)) {
//       return false;
//     }
//     if (oldDelegate is! CompositeRenderEditablePainter || oldDelegate.painters.length != painters.length) {
//       return true;
//     }

//     final Iterator<RenderEditablePainter> oldPainters = oldDelegate.painters.iterator;
//     final Iterator<RenderEditablePainter> newPainters = painters.iterator;
//     while (oldPainters.moveNext() && newPainters.moveNext()) {
//       if (newPainters.current.shouldRepaint(oldPainters.current)) {
//         return true;
//       }
//     }

//     return false;
//   }
// }
