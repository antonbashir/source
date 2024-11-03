// import 'package:design/constants/constants.dart';
// import 'package:design/extensions/extensions.dart';
// import 'package:design/theme/common.dart';
// import 'package:design/theme/tokens/sizes.dart';
// import 'package:design/widgets/layouts/dynamic/views/boxes/list.dart';
// import 'package:flutter/widgets.dart';

// class PaginatedSingleSearch extends StatefulWidget {
//   final String label;
//   final double suggestionsHeight;
//   final int pageSize;
//   final void Function(String value) onSearch;
//   final DynamicListNotifier<String> dataProvider;
//   final bool clearOnSelect;
//   final bool enabled;
//   final bool cached;
//   final Widget Function(BuildContext context, String item)? itemPrefix;
//   final Widget Function(dynamic error, StackTrace stack)? errorBuilder;
//   final ValueChanged<String>? onSubmit;
//   final VoidCallback? onClear;
//   final double? width;
//   final Icon? suggestionLeading;
//   final double? elevation;
//   final DynamicListStream<String>? refreshStream;
//   final Widget? fieldPrefix;
//   final String? selected;
//   final String Function(String item)? itemDecorator;

//   const PaginatedSingleSearch({
//     super.key,
//     required this.label,
//     required this.pageSize,
//     required this.onSearch,
//     required this.dataProvider,
//     required this.suggestionsHeight,
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
//     this.itemDecorator,
//   });

//   @override
//   State<PaginatedSingleSearch> createState() => _PaginatedSingleSearchState();
// }

// class _PaginatedSingleSearchState extends State<PaginatedSingleSearch> {
//   late final SearchController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = SearchController();
//     _controller.addListener(_search);
//     if (widget.selected.isNotEmpty == true) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _controller.text = widget.itemDecorator == null ? widget.selected! : widget.itemDecorator!(widget.selected!);
//         widget.onSubmit?.call(widget.selected!);
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _controller.removeListener(_search);
//     super.dispose();
//   }

//   @override
//   void didUpdateWidget(covariant PaginatedSingleSearch oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.selected != widget.selected && _controller.text != widget.selected) {
//       _controller.text = widget.selected ?? empty;
//     }
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
//           itemBuilder: (context, item, index) => ListTile(
//             leading: widget.itemPrefix?.call(context, item),
//             onTap: () {
//               widget.onSubmit?.call(item);
//               _controller.closeView(
//                 widget.clearOnSelect
//                     ? null
//                     : widget.itemDecorator == null
//                         ? item
//                         : widget.itemDecorator!(item),
//               );
//             },
//             title: widget.suggestionLeading == null
//                 ? Text(widget.itemDecorator == null ? item : widget.itemDecorator!(item))
//                 : Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(Sizes._sizes.size32),
//                         child: widget.suggestionLeading!,
//                       ),
//                       Text(widget.itemDecorator == null ? item : widget.itemDecorator!(item))
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
//         searchController: _controller,
//         viewConstraints: BoxConstraints.tightFor(height: widget.suggestionsHeight),
//         builder: (BuildContext context, SearchController controller) => SearchBar(
//           elevation: MaterialStatePropertyAll(widget.elevation),
//           controller: controller,
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
//             child: IgnorePointer(
//               child: search,
//             ),
//           );
//   }
// }
