// import 'package:design/theme/tokens/sizes.dart';
// import 'package:design/widgets/layouts/dynamic/views/boxes/list.dart';
// import 'package:flutter/widgets.dart';

// class PaginatedSingleDropdown<T> extends StatefulWidget {
//   final String label;
//   final double suggestionsHeight;
//   final int pageSize;
//   final void Function(String value) onSearch;
//   final DynamicListNotifier<T> dataProvider;
//   final bool clearOnSelect;
//   final bool cached;
//   final String Function(T item) fieldBuilder;
//   final bool enabled;
//   final Widget? fieldPrefix;
//   final Widget Function(BuildContext context, T item)? itemPrefix;
//   final Widget Function(dynamic error, StackTrace stack)? errorBuilder;
//   final T? selected;
//   final DynamicListStream<T>? refreshStream;
//   final double? elevation;
//   final ValueChanged<T>? onSubmit;
//   final VoidCallback? onClear;
//   final double? width;
//   final Icon? suggestionLeading;

//   const PaginatedSingleDropdown({
//     super.key,
//     required this.label,
//     required this.pageSize,
//     required this.onSearch,
//     required this.dataProvider,
//     required this.suggestionsHeight,
//     required this.fieldBuilder,
//     this.clearOnSelect = false,
//     this.width,
//     this.onSubmit,
//     this.refreshStream,
//     this.suggestionLeading,
//     this.elevation,
//     this.onClear,
//     this.fieldPrefix,
//     this.itemPrefix,
//     this.enabled = true,
//     this.cached = true,
//     this.errorBuilder,
//     this.selected,
//   });

//   @override
//   State<PaginatedSingleDropdown<T>> createState() => _PaginatedSingleDropdownState<T>();
// }

// class _PaginatedSingleDropdownState<T> extends State<PaginatedSingleDropdown<T>> {
//   late final SearchController _searchController;

//   @override
//   void initState() {
//     super.initState();
//     _searchController = SearchController();
//     _searchController.addListener(_search);
//     if (widget.selected != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _searchController.text = widget.fieldBuilder(widget.selected as T);
//         widget.onSubmit?.call(widget.selected as T);
//       });
//     }
//   }

//   @override
//   void didUpdateWidget(covariant PaginatedSingleDropdown<T> oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.selected != widget.selected) {
//       final newSelected = widget.fieldBuilder(widget.selected as T);
//       if (newSelected != _searchController.text) _searchController.text = newSelected;
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_search);
//     super.dispose();
//   }

//   void _search() {
//     widget.onSearch(_searchController.text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final list = SizedBox(
//       height: widget.suggestionsHeight,
//       child: Padding(
//         padding: EdgeInsets.only(bottom: Sizes._sizes.size40),
//         child: DynamicListView<T>(
//           errorBuilder: widget.errorBuilder,
//           itemBuilder: (context, item, index) => ListTile(
//             leading: widget.itemPrefix?.call(context, item),
//             onTap: () {
//               widget.onSubmit?.call(item);
//               if (!widget.clearOnSelect) {
//                 _searchController.text = widget.fieldBuilder(item);
//               }
//               _searchController.closeView(null);
//             },
//             title: widget.suggestionLeading == null
//                 ? Text(widget.fieldBuilder(item))
//                 : Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(Sizes._sizes.size32),
//                         child: widget.suggestionLeading!,
//                       ),
//                       Text(widget.fieldBuilder(item))
//                     ],
//                   ),
//           ),
//           pageSize: widget.pageSize,
//           dataProvider: widget.dataProvider,
//           refreshStream: widget.refreshStream,
//         ),
//       ),
//     );
//     final search = SizedBox(
//       width: widget.width,
//       child: SearchAnchor(
//         searchController: _searchController,
//         viewConstraints: BoxConstraints.tightFor(height: widget.suggestionsHeight),
//         builder: (BuildContext context, SearchController controller) => SearchBar(
//           elevation: MaterialStatePropertyAll(widget.elevation),
//           controller: _searchController,
//           hintText: widget.label,
//           onTap: widget.enabled ? () => controller.openView() : null,
//           onChanged: widget.enabled ? (_) => controller.openView() : null,
//           leading: widget.fieldPrefix ?? const Icon(Icons.search),
//           trailing: [
//             if (widget.onClear != null)
//               IconButton(
//                 onPressed: widget.onClear!,
//                 icon: const Icon(Icons.cancel),
//               )
//           ],
//         ),
//         viewBuilder: (suggestions) => suggestions.isEmpty ? Container() : suggestions.first,
//         viewTrailing: const [],
//         suggestionsBuilder: (BuildContext context, SearchController controller) {
//           if (mounted) {
//             if (!widget.cached) {
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 if (mounted) widget.dataProvider.clear();
//               });
//             }
//             return [list];
//           }
//           return [];
//         },
//       ),
//     );
//     return widget.enabled
//         ? search
//         : Opacity(
//             opacity: CommonThemeColors.disabledOpacity,
//             child: IgnorePointer(child: search),
//           );
//   }
// }
