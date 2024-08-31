// import 'package:design/extensions/extensions.dart';
// import 'package:design/theme/tokens/sizes.dart';
// import 'package:design/widgets/composites/searchers/paginated/multi.dart';
// import 'package:design/widgets/layouts/dynamic/views/boxes/list.dart';
// import 'package:flutter/widgets.dart';

// class PaginatedTagCheckboxesFilter extends StatefulWidget {
//   final String label;
//   final double width;
//   final double suggestionsHeight;
//   final Set<String> selected;
//   final int pageSize;
//   final DynamicListNotifier<String> dataProvider;
//   final void Function(String search) onSearch;
//   final Icon? suggestionLeading;
//   final double? elevation;
//   final ValueChanged<Set<String>>? onChanged;
//   final DynamicListStream<String>? refreshStream;
//   final Widget Function(dynamic error, StackTrace? stack)? errorBuilder;

//   const PaginatedTagCheckboxesFilter({
//     super.key,
//     required this.label,
//     required this.width,
//     required this.suggestionsHeight,
//     required this.selected,
//     required this.pageSize,
//     required this.dataProvider,
//     required this.onSearch,
//     this.refreshStream,
//     this.onChanged,
//     this.suggestionLeading,
//     this.elevation,
//     this.errorBuilder,
//   });

//   @override
//   State<PaginatedTagCheckboxesFilter> createState() => _TagFilterState();
// }

// class _TagFilterState extends State<PaginatedTagCheckboxesFilter> {
//   var _selected = <String>{};

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _selected = {...widget.selected};
//   }

//   @override
//   void didUpdateWidget(covariant PaginatedTagCheckboxesFilter oldWidget) {
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
//           PaginatedMultiSearch(
//             errorBuilder: widget.errorBuilder,
//             label: widget.label,
//             dataProvider: widget.dataProvider,
//             selected: _selected,
//             pageSize: widget.pageSize,
//             onSearch: widget.onSearch,
//             refreshStream: widget.refreshStream,
//             suggestionsHeight: widget.suggestionsHeight,
//             suggestionLeading: widget.suggestionLeading,
//             elevation: widget.elevation,
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
// }
