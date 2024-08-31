// import 'package:design/theme/tokens/sizes.dart';
// import 'package:design/widgets/layouts/dynamic/views/boxes/list.dart';
// import 'package:flutter/widgets.dart';

// class PaginatedMultiSearch extends StatefulWidget {
//   final String label;
//   final double suggestionsHeight;
//   final Set<String> selected;
//   final int pageSize;
//   final void Function(String value) onSearch;
//   final DynamicListNotifier<String> dataProvider;
//   final bool enabled;
//   final double? width;
//   final Icon? suggestionLeading;
//   final double? elevation;
//   final ValueChanged<String>? onAdd;
//   final ValueChanged<String>? onDelete;
//   final VoidCallback? onClear;
//   final DynamicListStream<String>? refreshStream;
//   final Widget Function(dynamic error, StackTrace? stack)? errorBuilder;

//   const PaginatedMultiSearch({
//     super.key,
//     required this.label,
//     required this.pageSize,
//     required this.onSearch,
//     required this.dataProvider,
//     required this.suggestionsHeight,
//     required this.selected,
//     this.width,
//     this.onAdd,
//     this.refreshStream,
//     this.onDelete,
//     this.suggestionLeading,
//     this.elevation,
//     this.onClear,
//     this.errorBuilder,
//     this.enabled = true,
//   });

//   @override
//   State<PaginatedMultiSearch> createState() => _PaginatedCheckboxSearchState();
// }

// class _PaginatedCheckboxSearchState extends State<PaginatedMultiSearch> {
//   late final SearchController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = SearchController();
//     _controller.addListener(_search);
//   }

//   @override
//   void dispose() {
//     _controller.removeListener(_search);
//     super.dispose();
//   }

//   void _search() {
//     widget.onSearch(_controller.text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final list = SizedBox(
//       height: widget.suggestionsHeight,
//       child: Padding(
//         padding: EdgeInsets.only(bottom: Sizes._sizes.size40),
//         child: DynamicListView<String>(
//           errorBuilder: widget.errorBuilder,
//           itemBuilder: (context, item, index) {
//             var selected = widget.selected.contains(item);
//             return StatefulBuilder(
//               builder: (context, setState) => CheckboxListTile(
//                 value: selected,
//                 onChanged: (value) {
//                   if (value == true) {
//                     setState(() => selected = true);
//                     widget.onAdd?.call(item);
//                     return;
//                   }
//                   setState(() => selected = false);
//                   widget.onDelete?.call(item);
//                 },
//                 title: widget.suggestionLeading == null
//                     ? Text(item)
//                     : Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(Sizes._sizes.size32),
//                             child: widget.suggestionLeading!,
//                           ),
//                           Text(item)
//                         ],
//                       ),
//               ),
//             );
//           },
//           pageSize: widget.pageSize,
//           dataProvider: widget.dataProvider,
//           refreshStream: widget.refreshStream,
//         ),
//       ),
//     );
//     return SizedBox(
//       width: widget.width,
//       child: SearchAnchor(
//         searchController: _controller,
//         viewConstraints: BoxConstraints.tightFor(height: widget.suggestionsHeight),
//         builder: (BuildContext context, SearchController controller) => SearchBar(
//           elevation: MaterialStatePropertyAll(widget.elevation),
//           controller: controller,
//           hintText: widget.label,
//           onTap: widget.enabled ? () => controller.openView() : null,
//           onChanged: widget.enabled ? (_) => controller.openView() : null,
//           leading: const Icon(Icons.search),
//           trailing: [
//             if (widget.onClear != null)
//               IconButton(
//                 onPressed: widget.onClear!,
//                 icon: const Icon(Icons.cancel),
//               )
//           ],
//         ),
//         viewBuilder: (suggestions) => suggestions.isEmpty ? Container() : suggestions.first,
//         suggestionsBuilder: (BuildContext context, SearchController controller) => mounted ? [list] : [],
//       ),
//     );
//   }
// }
