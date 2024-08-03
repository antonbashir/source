// import 'dart:ui';

// import 'package:code_text_field/code_text_field.dart';
// import 'package:flutter/widgets.dart';

// import '../../constants/editors.dart';
// import '../../constants/sizes.dart';
// import '../../theme/code.dart';
// import '../../theme/common.dart';

// class CodeEditor extends StatelessWidget {
//   final CodeController controller;
//   final Map<String, TextStyle> darkTheme;
//   final Map<String, TextStyle> lightTheme;
//   final ThemeMode themeMode;
//   final bool readOnly;
//   final bool error;
//   final bool enabled;
//   final TextStyle? textStyle;
//   final void Function(String code)? onChanged;
//   final Widget? title;
//   final BorderRadius? borderRadius;
//   final FocusNode? focusNode;

//   CodeEditor({
//     super.key,
//     required this.controller,
//     this.borderRadius,
//     this.themeMode = ThemeMode.system,
//     this.readOnly = false,
//     this.enabled = true,
//     this.error = false,
//     this.onChanged,
//     this.textStyle,
//     this.title,
//     this.focusNode,
//     Map<String, TextStyle>? darkTheme,
//     Map<String, TextStyle>? lightTheme,
//   })  : darkTheme = darkTheme ?? darkCodeTheme,
//         lightTheme = lightTheme ?? lightCodeTheme;

//   @override
//   Widget build(BuildContext context) {
//     final darkMode = themeMode == ThemeMode.system ? MediaQuery.of(context).platformBrightness == Brightness.dark : themeMode == ThemeMode.dark;
//     final theme = darkMode ? darkTheme : lightTheme;
//     final field = Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         title != null
//             ? Column(
//                 children: [
//                   Padding(padding: const EdgeInsets.all(Spacings.medium), child: title),
//                   const Divider(),
//                 ],
//               )
//             : Container(),
//         Expanded(
//           child: CodeTheme(
//             data: CodeThemeData(styles: theme),
//             child: ScrollConfiguration(
//               behavior: ScrollConfiguration.of(context).copyWith(
//                 dragDevices: {PointerDeviceKind.trackpad},
//               ),
//               child: CodeField(
//                 focusNode: focusNode,
//                 readOnly: readOnly,
//                 onChanged: onChanged,
//                 containerPadding: const EdgeInsets.all(Spacings.medium),
//                 textStyle: textStyle,
//                 lineNumbers: false,
//                 wrap: true,
//                 decoration: BoxDecoration(
//                   color: theme[codeEditorRootClassName]!.backgroundColor,
//                   borderRadius: borderRadius,
//                   boxShadow: [if (error) BoxShadow(blurRadius: 1, spreadRadius: 1, color: Theme.of(context).colorScheme.error)],
//                 ),
//                 controller: controller,
//                 expands: true,
//                 enabled: enabled,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//     return enabled ? field : Opacity(opacity: CommonThemeColors.disabledOpacity, child: IgnorePointer(child: field));
//   }
// }
