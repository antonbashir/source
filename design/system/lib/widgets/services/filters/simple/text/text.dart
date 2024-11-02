// import 'package:design/constants/constants.dart';
// import 'package:design/theme/common.dart';
// import 'package:design/theme/tokens/sizes.dart';
// import 'package:flutter/widgets.dart';

// class TextFilter extends StatefulWidget {
//   final double width;
//   final String label;
//   final void Function(String value)? onChanged;
//   final String? value;

//   const TextFilter({
//     super.key,
//     required this.width,
//     this.value,
//     required this.label,
//     this.onChanged,
//   });

//   @override
//   State<StatefulWidget> createState() => TextFilterState();
// }

// class TextFilterState extends State<TextFilter> {
//   late final TextEditingController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController(text: widget.value);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   void didUpdateWidget(covariant TextFilter oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.value != widget.value && _controller.text != widget.value) {
//       _controller.text = widget.value ?? empty;
//     }
//   }

//   @override
//   Widget build(BuildContext context) => SizedBox(
//         width: widget.width,
//         child: Card(
//           elevation: searchBarElevation,
//           margin: const EdgeInsets.all(0),
//           shape: const StadiumBorder(),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: Sizes._sizes.size40),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Icon(Icons.search),
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: Sizes._sizes.size40),
//                     child: TextField(
//                       controller: _controller,
//                       decoration: InputDecoration(labelText: widget.label, border: InputBorder.none),
//                       onChanged: widget.onChanged,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     _controller.text = empty;
//                     widget.onChanged?.call(empty);
//                   },
//                   icon: const Icon(Icons.cancel),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
// }
