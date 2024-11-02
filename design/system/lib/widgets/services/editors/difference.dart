// import 'package:code_text_field/code_text_field.dart';
// import 'package:diff_match_patch/diff_match_patch.dart';
// import 'package:flutter/widgets.dart';

// import '../../constants/fonts.dart';
// import '../../constants/sizes.dart';
// import '../../theme/common.dart';
// import 'code.dart';

// class DifferenceEditor extends ConsumerStatefulWidget {
//   final Widget? oldTitle;
//   final Widget? newTitle;
//   final CodeController oldController;
//   final CodeController newController;
//   final void Function(String code)? onNewChanged;
//   final Color? insertionColor;
//   final Color? deletionColor;

//   const DifferenceEditor({
//     super.key,
//     required this.oldController,
//     required this.newController,
//     this.insertionColor,
//     this.deletionColor,
//     this.oldTitle,
//     this.newTitle,
//     this.onNewChanged,
//   });

//   @override
//   ConsumerState<DifferenceEditor> createState() => _DifferenceEditorState();
// }

// class _DifferenceEditorState extends ConsumerState<DifferenceEditor> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final (oldSelections, newSelections) = _calculateSelections(widget.oldController.text, widget.newController.text);
//       widget.oldController.selections = oldSelections;
//       widget.newController.selections = newSelections;
//     });
//   }

//   (Map<TextSelection, Color>, Map<TextSelection, Color>) _calculateSelections(String from, String to) {
//     final differences = diff(from, to);
//     cleanupSemantic(differences);
//     final oldCodeSelections = <TextSelection, Color>{};
//     final newCodeSelections = <TextSelection, Color>{};
//     var oldTextOffset = 0;
//     var newTextOffset = 0;
//     for (var difference in differences) {
//       switch (difference.operation) {
//         case DIFF_EQUAL:
//           oldTextOffset += difference.text.length;
//           newTextOffset += difference.text.length;
//           break;
//         case DIFF_INSERT:
//           final selection = TextSelection(baseOffset: newTextOffset, extentOffset: newTextOffset + difference.text.length);
//           newCodeSelections[selection] = widget.insertionColor ?? CommonThemeColors.insertedTextSelectionColor;
//           newTextOffset += difference.text.length;
//           break;
//         case DIFF_DELETE:
//           final selection = TextSelection(baseOffset: oldTextOffset, extentOffset: oldTextOffset + difference.text.length);
//           oldCodeSelections[selection] = widget.deletionColor ?? CommonThemeColors.deletedTextSelectionColor;
//           oldTextOffset += difference.text.length;
//           break;
//       }
//     }
//     return (oldCodeSelections, newCodeSelections);
//   }

//   @override
//   Widget build(BuildContext context) => Row(
//         children: [
//           Expanded(
//             child: CodeEditor(
//               controller: widget.oldController,
//               readOnly: true,
//               title: widget.oldTitle,
//               textStyle: const TextStyle(fontFamily: mesloFont),
//               borderRadius: Borders.strong,
//               themeMode: ref.watch(themeProvider),
//             ),
//           ),
//           const VerticalDivider(),
//           Expanded(
//             child: CodeEditor(
//               controller: widget.newController,
//               title: widget.newTitle,
//               textStyle: const TextStyle(fontFamily: mesloFont),
//               borderRadius: Borders.strong,
//               themeMode: ref.watch(themeProvider),
//               onChanged: (code) {
//                 final (oldSelections, newSelections) = _calculateSelections(widget.oldController.text, code);
//                 widget.oldController.selections = oldSelections;
//                 widget.newController.selections = newSelections;
//                 widget.onNewChanged?.call(code);
//               },
//             ),
//           )
//         ],
//       );
// }
