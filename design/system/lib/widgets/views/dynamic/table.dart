// import 'dart:math';

// import 'package:design/extensions/extensions.dart';
// import 'package:design/model/state.dart';
// import 'package:design/theme/tokens/sizes.dart';
// import 'package:design/widgets/layouts/dynamic/views/boxes/list.dart';
// import 'package:design/widgets/layouts/scroll/scrollbar.dart';
// import 'package:design/widgets/primitives/loaders/circular.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';

// class DynamicTableView<T> extends StatefulWidget {
//   final Iterable<DynamicTableViewHeader> headers;
//   final double headerHeight;
//   final double rowDividerHeight;
//   final double headerDividerHeight;
//   final DynamicTableViewRow Function(BuildContext context, T item, int index) rowBuilder;
//   final double rowHeight;
//   final DynamicListNotifier<T> dataProvider;
//   final int pageSize;
//   final double horizontalScrollViewPadding;
//   final double loaderPadding;
//   final bool autoSize;
//   final double headerMinWidthSum;
//   final Color? headerBackgroundColor;
//   final Color? headerDividerColor;
//   final Color? rowDividerColor;
//   final DynamicTableViewExpansion Function(BuildContext context, T item, int index)? expansionBuilder;
//   final double Function(BuildContext context, T item, int index)? rowHeightCalculator;
//   final DynamicListStream<T>? refreshStream;
//   final Widget Function(dynamic error, StackTrace? stack)? errorBuilder;
//   final DynamicTableViewRow Function(BuildContext context, DynamicTableViewRow current)? rowBuildDecorator;

//   DynamicTableView({
//     super.key,
//     required this.headers,
//     required this.rowBuilder,
//     required this.dataProvider,
//     required this.pageSize,
//     this.expansionBuilder,
//     this.rowHeight = 100,
//     this.headerHeight = 40,
//     this.rowDividerHeight = 1.0,
//     this.headerDividerHeight = 1.0,
//     this.refreshStream,
//     this.rowHeightCalculator,
//     this.headerDividerColor,
//     this.rowDividerColor,
//     this.headerBackgroundColor,
//     this.errorBuilder,
//     this.rowBuildDecorator,
//     this.autoSize = true,
//   })  : horizontalScrollViewPadding = Sizes._sizes.size40,
//         loaderPadding = Sizes._sizes.size32,
//         headerMinWidthSum = headers.map((header) => header.minWidth).reduce((value, element) => value + element);

//   @override
//   State<DynamicTableView> createState() => _DynamicTableViewState<T>();
// }

// class _DynamicTableViewState<T> extends State<DynamicTableView<T>> {
//   late final _listKey = GlobalKey();

//   final _horizontalScrollController = ScrollController();
//   final _realVerticalScrollController = ScrollController();
//   final _fakeVerticalScrollController = ScrollController();

//   var _updatingRealController = false;
//   var _updatingFakeController = false;

//   var _fakeScrollHeight = 1.0;

//   void _updateRealVerticalPosition() {
//     if (_updatingFakeController) return;
//     _updatingRealController = true;
//     _realVerticalScrollController.jumpTo(_fakeVerticalScrollController.position.pixels);
//     WidgetsBinding.instance.addPostFrameCallback((_) => _updatingRealController = false);
//   }

//   void _updateFakeVerticalPosition() {
//     if (_updatingRealController) return;
//     _updatingFakeController = true;
//     _fakeVerticalScrollController.jumpTo(_realVerticalScrollController.position.pixels);
//     WidgetsBinding.instance.addPostFrameCallback((_) => _updatingFakeController = false);
//   }

//   @override
//   void initState() {
//     super.initState();
//     _realVerticalScrollController.addListener(_updateFakeVerticalPosition);
//     _fakeVerticalScrollController.addListener(_updateRealVerticalPosition);
//   }

//   @override
//   void dispose() {
//     _realVerticalScrollController.removeListener(_updateFakeVerticalPosition);
//     _fakeVerticalScrollController.removeListener(_updateRealVerticalPosition);
//     _horizontalScrollController.dispose();
//     _realVerticalScrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final thickness = theme.scrollbarTheme.thickness?.resolve({MaterialState.hovered}) ?? (theme.platform == TargetPlatform.android || theme.platform == TargetPlatform.iOS ? 4 : 8);
//     final padding = thickness / widget.headers.length + 1;
//     return Padding(
//       padding: EdgeInsets.only(left: thickness),
//       child: LayoutBuilder(builder: (context, constraints) {
//         final headerViews = widget.headers
//             .map(
//               (header) => _DynamicHeaderView(
//                 header: header,
//                 width: max(header.minWidth, header.width ?? (widget.autoSize ? constraints.maxWidth * header.minWidth / widget.headerMinWidthSum : header.minWidth)) - padding,
//               ),
//             )
//             .toList();
//         final contentWidth = headerViews.map((header) => header.width).reduce((value, element) => value + element);
//         return Row(
//           children: [
//             Expanded(
//               child: Scrollbar(
//                 thumbVisibility: true,
//                 controller: _horizontalScrollController,
//                 child: SingleChildScrollView(
//                   controller: _horizontalScrollController,
//                   scrollDirection: Axis.horizontal,
//                   padding: EdgeInsets.symmetric(vertical: widget.horizontalScrollViewPadding),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Column(
//                         children: [
//                           Container(
//                             color: widget.headerBackgroundColor,
//                             height: widget.headerHeight,
//                             child: Row(children: headerViews),
//                           ),
//                           Container(
//                             height: widget.headerDividerHeight,
//                             width: contentWidth,
//                             color: widget.headerDividerColor ?? theme.dividerColor,
//                           )
//                         ],
//                       ),
//                       Expanded(
//                         child: SizedBox(
//                           width: contentWidth,
//                           child: ScrollConfiguration(
//                             behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
//                             child: DynamicListView<T>(
//                               listKey: _listKey,
//                               progressIndicator: Padding(padding: EdgeInsets.all(widget.loaderPadding), child: const CircularLoader()),
//                               scrollController: _realVerticalScrollController,
//                               itemBuilder: (context, item, index) {
//                                 final sourceExpansion = widget.expansionBuilder?.call(context, item, index);
//                                 final effectiveExpansion = sourceExpansion == null
//                                     ? null
//                                     : DynamicTableViewExpansion(
//                                         child: sourceExpansion.child,
//                                         onChanged: (value) {
//                                           WidgetsBinding.instance.addPostFrameCallback((_) {
//                                             if (mounted) {
//                                               setState(() {
//                                                 _fakeScrollHeight = value ? _fakeScrollHeight + sourceExpansion.height : _fakeScrollHeight - sourceExpansion.height;
//                                               });
//                                             }
//                                           });
//                                           sourceExpansion.onChanged?.call(value);
//                                         },
//                                         height: sourceExpansion.height,
//                                       );
//                                 return _DynamicRowView(
//                                   buildDecorator: widget.rowBuildDecorator,
//                                   row: widget.rowBuilder(context, item, index),
//                                   owner: widget,
//                                   rowWidth: contentWidth,
//                                   cellWidths: headerViews.map((header) => header.width).toList(),
//                                   rowHeight: (widget.rowHeightCalculator?.call(context, item, index) ?? widget.rowHeight) - widget.rowDividerHeight * 2,
//                                   expansion: effectiveExpansion,
//                                 );
//                               },
//                               pageSize: widget.pageSize,
//                               dataProvider: widget.dataProvider,
//                               refreshStream: widget.refreshStream,
//                               errorBuilder: widget.errorBuilder,
//                               onChanged: (items) {
//                                 if (widget.rowHeightCalculator == null) {
//                                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                                     if (mounted) {
//                                       setState(() {
//                                         _fakeScrollHeight = items.length * (widget.rowHeight + widget.rowDividerHeight);
//                                       });
//                                     }
//                                   });
//                                   return;
//                                 }
//                                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                                   if (mounted) {
//                                     setState(() {
//                                       _fakeScrollHeight = items
//                                           .mapIndexed(
//                                             (index, element) => widget.rowHeightCalculator!(context, element, index) + widget.rowDividerHeight,
//                                           )
//                                           .reduce(
//                                             (value, element) => value + element,
//                                           );
//                                     });
//                                   }
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               width: thickness,
//               height: double.infinity,
//               padding: EdgeInsets.only(top: widget.headerHeight + (widget.horizontalScrollViewPadding * 2) + widget.headerDividerHeight),
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: Scrollbar(
//                   controller: _fakeVerticalScrollController,
//                   thumbVisibility: true,
//                   child: SingleChildScrollView(
//                     controller: _fakeVerticalScrollController,
//                     scrollDirection: Axis.vertical,
//                     child: SizedBox(
//                       width: thickness,
//                       height: _fakeScrollHeight + 41 + widget.loaderPadding * 2,
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         );
//       }),
//     );
//   }
// }

// class DynamicTableViewHeader {
//   final Widget label;
//   final double minWidth;
//   final AlignmentGeometry alignment;
//   final double? width;
//   final EdgeInsetsGeometry? padding;

//   const DynamicTableViewHeader({
//     required this.minWidth,
//     required this.label,
//     this.alignment = Alignment.center,
//     this.width,
//     this.padding,
//   });
// }

// class _DynamicHeaderView extends StatelessWidget {
//   final DynamicTableViewHeader header;
//   final double width;

//   const _DynamicHeaderView({required this.header, required this.width});

//   @override
//   Widget build(BuildContext context) => Container(
//         padding: header.padding,
//         width: width,
//         child: Align(alignment: header.alignment, child: header.label),
//       );
// }

// class DynamicTableViewExpansion {
//   final Widget child;
//   final double height;
//   final ValueChanged<bool>? onChanged;

//   DynamicTableViewExpansion({required this.child, required this.height, this.onChanged});
// }

// class DynamicTableViewRow {
//   final List<DynamicTableViewCell> cells;
//   final Color? backgroundColor;
//   final void Function()? onTap;
//   final void Function()? onTertiaryTap;

//   DynamicTableViewRow({required this.cells, this.backgroundColor, this.onTap, this.onTertiaryTap});

//   DynamicTableViewRow copyWith({List<DynamicTableViewCell>? cells, Color? backgroundColor, void Function()? onTap}) => DynamicTableViewRow(
//         cells: cells ?? this.cells,
//         backgroundColor: backgroundColor ?? this.backgroundColor,
//         onTap: onTap ?? this.onTap,
//       );

//   DynamicTableViewRow disable() => DynamicTableViewRow(
//         cells: cells,
//         backgroundColor: backgroundColor,
//         onTap: null,
//       );
// }

// class DynamicTableViewCell extends StatelessWidget {
//   final Widget? child;
//   final EdgeInsetsGeometry padding;
//   final AlignmentGeometry alignment;

//   const DynamicTableViewCell({
//     super.key,
//     this.alignment = Alignment.center,
//     this.padding = EdgeInsets.zero,
//     this.child,
//   });

//   @override
//   Widget build(BuildContext context) => Padding(padding: padding, child: Align(alignment: alignment, child: child));
// }

// class _DynamicRowView extends StatefulWidget {
//   final DynamicTableView owner;
//   final DynamicTableViewRow row;
//   final DynamicTableViewExpansion? expansion;
//   final double rowHeight;
//   final double rowWidth;
//   final List<double> cellWidths;
//   final DynamicTableViewRow Function(BuildContext context, DynamicTableViewRow current)? buildDecorator;

//   const _DynamicRowView({
//     required this.row,
//     required this.owner,
//     required this.rowHeight,
//     required this.rowWidth,
//     required this.cellWidths,
//     required this.buildDecorator,
//     this.expansion,
//   });

//   @override
//   State<_DynamicRowView> createState() => _DynamicRowViewState();
// }

// class _DynamicRowViewState extends State<_DynamicRowView> {
//   bool _expanded = false;

//   @override
//   void didUpdateWidget(covariant _DynamicRowView oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.rowHeight != widget.rowHeight || oldWidget.rowWidth != widget.rowWidth || !listEquals(oldWidget.cellWidths, widget.cellWidths)) {
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final row = widget.buildDecorator?.call(context, widget.row) ?? widget.row;
//     final theme = Theme.of(context);
//     Widget rowWidget = Container(
//       color: row.backgroundColor,
//       height: widget.rowHeight,
//       child: Row(
//         children: row.cells.mapIndexed(
//           (index, cell) => SizedBox(
//             width: widget.cellWidths[index],
//             child: cell,
//           ),
//         ),
//       ),
//     );
//     return GestureDetector(
//       onTertiaryTapUp: (_) => row.onTertiaryTap?.call(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           widget.expansion != null
//               ? SizedBox(
//                   width: widget.rowWidth,
//                   // child: CustomExpansionTile(
//                   //   onExpansionChanged: (newExpanded) {
//                   //     _expanded = newExpanded;
//                   //     widget.expansion!.onChanged?.call(newExpanded);
//                   //   },
//                   //   initiallyExpanded: _expanded,
//                   //   row: rowWidget,
//                   //   children: [SizedBox(height: widget.expansion!.height, child: widget.expansion!.child)],
//                   // ),
//                 )
//               : rowWidget,
//           Container(
//             height: widget.owner.rowDividerHeight,
//             width: widget.rowWidth,
//             color: widget.owner.rowDividerColor ?? theme.dividerColor,
//           ),
//         ],
//       ),
//     );
//   }
// }
