// import 'package:design/theme/tokens/sizes.dart';
// import 'package:flutter/widgets.dart';

// class DeleteDialog extends StatelessWidget {
//   final String title;
//   final String message;
//   final String deleteButtonLabel;
//   final String discardButtonLabel;
//   final void Function() onDelete;

//   const DeleteDialog({
//     super.key,
//     required this.title,
//     required this.message,
//     required this.onDelete,
//     required this.deleteButtonLabel,
//     required this.discardButtonLabel,
//   });

//   static void show(BuildContext context, DeleteDialog dialog) => showDialog(context: context, builder: (_) => dialog);

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return AlertDialog(
//       actions: [
//         Padding(
//           padding: EdgeInsets.only(right: Sizes._sizes.size40),
//           child: FilledButton(
//               style: theme.filledButtonTheme.style?.copyWith(
//                 foregroundColor: MaterialStatePropertyAll(theme.colorScheme.onError),
//                 backgroundColor: MaterialStatePropertyAll(theme.colorScheme.error),
//               ),
//               onPressed: () {
//                 onDelete.call();
//                 Navigator.pop(context);
//               },
//               child: Text(deleteButtonLabel)),
//         ),
//         Padding(
//           padding: EdgeInsets.only(left: Sizes._sizes.size40),
//           child: ElevatedButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text(discardButtonLabel),
//           ),
//         ),
//       ],
//       title: Row(
//         children: [
//           Expanded(
//             child: Text(
//               title,
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//           ),
//           IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close)),
//         ],
//       ),
//       content: Text(message),
//     );
//   }
// }
