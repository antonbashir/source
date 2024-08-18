// import 'package:design/theme/tokens/sizes.dart';
// import 'package:flutter/widgets.dart';

// class MultiSearch extends StatelessWidget {
//   final String label;
//   final double width;
//   final double suggestionsHeight;
//   final Set<String> available;
//   final Set<String> selected;
//   final Icon? suggestionLeading;
//   final ValueChanged<String>? onAdd;
//   final ValueChanged<String>? onDelete;
//   final VoidCallback? onClear;
//   final List<String> Function(String input) searcher;

//   const MultiSearch({
//     super.key,
//     required this.label,
//     required this.searcher,
//     required this.width,
//     required this.suggestionsHeight,
//     required this.available,
//     required this.selected,
//     this.onAdd,
//     this.onDelete,
//     this.suggestionLeading,
//     this.onClear,
//   });

//   @override
//   Widget build(BuildContext context) => SizedBox(
//         width: width,
//         child: SearchAnchor(
//           viewConstraints: BoxConstraints.tightFor(height: suggestionsHeight),
//           builder: (BuildContext context, SearchController controller) => SearchBar(
//             controller: controller,
//             hintText: label,
//             onTap: () => controller.openView(),
//             onChanged: (_) => controller.openView(),
//             leading: const Icon(Icons.search),
//             trailing: [
//               if (onClear != null)
//                 IconButton(
//                   onPressed: onClear!,
//                   icon: const Icon(Icons.cancel),
//                 )
//             ],
//           ),
//           suggestionsBuilder: (BuildContext context, SearchController controller) => searcher(controller.text)
//               .map(
//                 (option) => _Item(
//                   selected: selected.contains(option),
//                   option: option,
//                   onAdd: onAdd,
//                   onClear: onClear,
//                   onDelete: onDelete,
//                   suggestionLeading: suggestionLeading,
//                 ),
//               )
//               .toList(),
//         ),
//       );
// }

// class _Item extends StatefulWidget {
//   final bool selected;
//   final Icon? suggestionLeading;
//   final ValueChanged<String>? onAdd;
//   final ValueChanged<String>? onDelete;
//   final VoidCallback? onClear;
//   final String option;

//   const _Item({
//     required this.selected,
//     required this.option,
//     this.suggestionLeading,
//     this.onAdd,
//     this.onDelete,
//     this.onClear,
//   });

//   @override
//   State<StatefulWidget> createState() => _ItemState();
// }

// class _ItemState extends State<_Item> {
//   late bool _selected = widget.selected;

//   @override
//   Widget build(BuildContext context) => CheckboxListTile(
//         value: _selected,
//         onChanged: (value) {
//           if (value == true) {
//             setState(() => _selected = true);
//             widget.onAdd?.call(widget.option);
//             return;
//           }
//           setState(() => _selected = false);
//           widget.onDelete?.call(widget.option);
//         },
//         title: widget.suggestionLeading == null
//             ? Text(widget.option)
//             : Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(Sizes._sizes.size32),
//                     child: widget.suggestionLeading!,
//                   ),
//                   Text(widget.option)
//                 ],
//               ),
//       );
// }
