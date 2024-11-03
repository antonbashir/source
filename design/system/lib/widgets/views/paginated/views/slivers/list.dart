import 'package:design/constants/assertions.dart';
import 'package:design/constants/pagination.dart';
import 'package:design/delegates/sliver/additional.dart';
import 'package:design/widgets/views/paginated/builder/builder.dart';
import 'package:design/widgets/views/paginated/controller/controller.dart';
import 'package:design/widgets/views/paginated/delegates/child.dart';
import 'package:flutter/widgets.dart';

class PaginatedSliverList<PageKeyType, ItemType> extends StatelessWidget {
  final PaginationController<PageKeyType, ItemType> paginationController;
  final PaginatedChildBuilderDelegate<ItemType> builderDelegate;
  final IndexedWidgetBuilder? _separatorBuilder;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final SemanticIndexCallback? semanticIndexCallback;
  final double? itemExtent;
  final Widget? prototypeItem;
  final bool shrinkWrapFirstPageIndicators;

  const PaginatedSliverList({
    required this.paginationController,
    required this.builderDelegate,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.itemExtent,
    this.prototypeItem,
    this.semanticIndexCallback,
    this.shrinkWrapFirstPageIndicators = false,
    super.key,
  })  : assert(itemExtent == null || prototypeItem == null, listItemExtentAssertion),
        _separatorBuilder = null;

  const PaginatedSliverList.separated({
    required this.paginationController,
    required this.builderDelegate,
    required IndexedWidgetBuilder separatorBuilder,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.itemExtent,
    this.semanticIndexCallback,
    this.shrinkWrapFirstPageIndicators = false,
    super.key,
  })  : prototypeItem = null,
        _separatorBuilder = separatorBuilder;

  @override
  Widget build(BuildContext context) => PaginatedLayoutBuilder<PageKeyType, ItemType>(
        layoutMode: PaginatedLayoutMode.sliver,
        paginationController: paginationController,
        builderDelegate: builderDelegate,
        completedListingBuilder: (context, itemBuilder, itemCount, noMoreItemsIndicatorBuilder) => _buildSliverList(
          itemBuilder,
          itemCount,
          statusIndicatorBuilder: noMoreItemsIndicatorBuilder,
        ),
        loadingListingBuilder: (context, itemBuilder, itemCount, progressIndicatorBuilder) => _buildSliverList(
          itemBuilder,
          itemCount,
          statusIndicatorBuilder: progressIndicatorBuilder,
        ),
        errorListingBuilder: (context, itemBuilder, itemCount, errorIndicatorBuilder) => _buildSliverList(
          itemBuilder,
          itemCount,
          statusIndicatorBuilder: errorIndicatorBuilder,
        ),
        shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
        noMoreItemsIndicatorBuilder: builderDelegate.noMoreItemsIndicatorBuilder,
        firstPageProgressIndicatorBuilder:  builderDelegate.firstPageProgressIndicatorBuilder,
        firstPageErrorIndicatorBuilder: builderDelegate.firstPageErrorIndicatorBuilder,
        newPageErrorIndicatorBuilder: builderDelegate.newPageErrorIndicatorBuilder,
        newPageProgressIndicatorBuilder: builderDelegate.newPageProgressIndicatorBuilder,
      );

  SliverMultiBoxAdaptorWidget _buildSliverList(IndexedWidgetBuilder itemBuilder, int itemCount, {WidgetBuilder? statusIndicatorBuilder}) {
    final delegate = _separatorBuilder == null
        ? AdditionalSliverChildDelegate(
            builder: itemBuilder,
            childCount: itemCount,
            additionalItemBuilder: statusIndicatorBuilder,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            semanticIndexCallback: semanticIndexCallback,
          )
        : AdditionalSliverChildDelegate.separated(
            builder: itemBuilder,
            childCount: itemCount,
            additionalItemBuilder: statusIndicatorBuilder,
            separatorBuilder: _separatorBuilder,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
          );
    return (itemExtent == null && prototypeItem == null) || _separatorBuilder != null
        ? SliverList(delegate: delegate)
        : itemExtent != null
            ? SliverFixedExtentList(delegate: delegate, itemExtent: itemExtent!)
            : SliverPrototypeExtentList(delegate: delegate, prototypeItem: prototypeItem!);
  }
}
