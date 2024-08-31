// import 'package:design/extensions/extensions.dart';
// import 'package:design/theme/tokens/sizes.dart';
// import 'package:design/widgets/composites/searchers/simple/multi.dart';
// import 'package:flutter/widgets.dart';

// class TagCheckboxesFilter extends StatefulWidget {
//   final String label;
//   final double width;
//   final double suggestionsHeight;
//   final Set<String> available;
//   final Set<String> selected;
//   final Icon? suggestionLeading;
//   final ValueChanged<Set<String>>? onChanged;

//   const TagCheckboxesFilter({
//     super.key,
//     required this.label,
//     required this.width,
//     required this.suggestionsHeight,
//     required this.available,
//     required this.selected,
//     this.onChanged,
//     this.suggestionLeading,
//   });

//   @override
//   State<TagCheckboxesFilter> createState() => _TagCheckboxesFilterState();
// }

// class _TagCheckboxesFilterState extends State<TagCheckboxesFilter> {
//   var _selected = <String>{};

//   @override
//   void initState() {
//     super.initState();
//     _selected = {...widget.selected};
//   }

//   @override
//   void dispose() {
//     _selected = {};
//     super.dispose();
//   }

//   @override
//   void didUpdateWidget(covariant TagCheckboxesFilter oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.selected != widget.selected && _selected != widget.selected) {
//       setState(() => _selected = widget.selected);
//     }
//   }

//   @override
//   Widget build(BuildContext context) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           MultiSearch(
//             label: widget.label,
//             available: widget.available,
//             selected: _selected,
//             searcher: _search,
//             suggestionsHeight: widget.suggestionsHeight,
//             suggestionLeading: widget.suggestionLeading,
//             width: widget.width,
//             onClear: () {
//               setState(() => _selected = {});
//               widget.onChanged?.call(_selected);
//             },
//             onAdd: (option) {
//               setState(() => _selected = {...widget.selected, option});
//               widget.onChanged?.call(_selected);
//             },
//             onDelete: (option) {
//               setState(() => _selected = widget.selected.copyRemove(option));
//               widget.onChanged?.call(_selected);
//             },
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: Sizes._sizes.size40),
//             child: SizedBox(
//               width: widget.width,
//               child: Wrap(
//                 spacing: Sizes._sizes.size40,
//                 runSpacing: Sizes._sizes.size40,
//                 children: widget.selected
//                     .map(
//                       (value) => Chip(
//                         label: Text(value),
//                         onDeleted: () {
//                           setState(() => _selected = widget.selected.copyRemove(value));
//                           widget.onChanged?.call(_selected);
//                         },
//                       ),
//                     )
//                     .toList(),
//               ),
//             ),
//           )
//         ],
//       );

//   List<String> _search(String query) {
//     if (query.isNotEmpty) {
//       var lowercaseQuery = query.toLowerCase();
//       final results = widget.available.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList(growable: false);
//       results.sort((left, right) => left.toLowerCase().indexOf(lowercaseQuery).compareTo(right.toLowerCase().indexOf(lowercaseQuery)));
//       return results;
//     }
//     return widget.available.toList();
//   }
// }
