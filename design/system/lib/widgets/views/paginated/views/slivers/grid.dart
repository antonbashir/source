import 'package:design/common/common.dart';
import 'package:design/constants/pagination.dart';
import 'package:design/delegates/sliver/additional.dart';
import 'package:design/widgets/views/paginated/builder/builder.dart';
import 'package:design/widgets/views/paginated/controller/controller.dart';
import 'package:design/widgets/views/paginated/delegates/child.dart';
import 'package:flutter/widgets.dart';
import 'package:sliver_tools/sliver_tools.dart';

class PaginatedSliverGrid<PageKeyType, ItemType> extends StatelessWidget {
  final PaginationController<PageKeyType, ItemType> paginationController;
  final PaginatedChildBuilderDelegate<ItemType> builderDelegate;
  final SliverGridDelegate gridDelegate;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final bool showNewPageProgressIndicatorAsGridChild;
  final bool showNewPageErrorIndicatorAsGridChild;
  final bool showNoMoreItemsIndicatorAsGridChild;
  final bool shrinkWrapFirstPageIndicators;

  const PaginatedSliverGrid({
    required this.paginationController,
    required this.builderDelegate,
    required this.gridDelegate,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.showNewPageProgressIndicatorAsGridChild = true,
    this.showNewPageErrorIndicatorAsGridChild = true,
    this.showNoMoreItemsIndicatorAsGridChild = true,
    this.shrinkWrapFirstPageIndicators = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => PaginatedLayoutBuilder<PageKeyType, ItemType>(
        layoutMode: PaginatedLayoutMode.sliver,
        paginationController: paginationController,
        builderDelegate: builderDelegate,
        completedListingBuilder: (context, itemBuilder, itemCount, noMoreItemsIndicatorBuilder) => _AppendedSliverGrid(
          sliverGridBuilder: (_, delegate) => SliverGrid(
            delegate: delegate,
            gridDelegate: gridDelegate,
          ),
          itemBuilder: itemBuilder,
          itemCount: itemCount,
          additionalItemBuilder: noMoreItemsIndicatorBuilder,
          showAppendixAsGridChild: showNoMoreItemsIndicatorAsGridChild,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addSemanticIndexes: addSemanticIndexes,
          addRepaintBoundaries: addRepaintBoundaries,
        ),
        loadingListingBuilder: (context, itemBuilder, itemCount, progressIndicatorBuilder) => _AppendedSliverGrid(
          sliverGridBuilder: (_, delegate) => SliverGrid(
            delegate: delegate,
            gridDelegate: gridDelegate,
          ),
          itemBuilder: itemBuilder,
          itemCount: itemCount,
          additionalItemBuilder: progressIndicatorBuilder,
          showAppendixAsGridChild: showNewPageProgressIndicatorAsGridChild,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addSemanticIndexes: addSemanticIndexes,
          addRepaintBoundaries: addRepaintBoundaries,
        ),
        errorListingBuilder: (context, itemBuilder, itemCount, errorIndicatorBuilder) => _AppendedSliverGrid(
          sliverGridBuilder: (_, delegate) => SliverGrid(
            delegate: delegate,
            gridDelegate: gridDelegate,
          ),
          itemBuilder: itemBuilder,
          itemCount: itemCount,
          additionalItemBuilder: errorIndicatorBuilder,
          showAppendixAsGridChild: showNewPageErrorIndicatorAsGridChild,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addSemanticIndexes: addSemanticIndexes,
          addRepaintBoundaries: addRepaintBoundaries,
        ),
        shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
        noMoreItemsIndicatorBuilder: builderDelegate.noMoreItemsIndicatorBuilder,
        firstPageProgressIndicatorBuilder:  builderDelegate.firstPageProgressIndicatorBuilder,
        firstPageErrorIndicatorBuilder: builderDelegate.firstPageErrorIndicatorBuilder,
        newPageErrorIndicatorBuilder: builderDelegate.newPageErrorIndicatorBuilder,
        newPageProgressIndicatorBuilder: builderDelegate.newPageProgressIndicatorBuilder,
      );
}

class _AppendedSliverGrid extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final SliverGridBuilder sliverGridBuilder;
  final bool showAppendixAsGridChild;
  final WidgetBuilder? additionalItemBuilder;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;

  const _AppendedSliverGrid({
    required this.itemBuilder,
    required this.itemCount,
    required this.sliverGridBuilder,
    this.showAppendixAsGridChild = true,
    this.additionalItemBuilder,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  });

  @override
  Widget build(BuildContext context) {
    if (showAppendixAsGridChild == true || additionalItemBuilder == null) {
      return sliverGridBuilder(
        itemCount + (additionalItemBuilder == null ? 0 : 1),
        AdditionalSliverChildDelegate(
          builder: itemBuilder,
          childCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
      );
    }
    return MultiSliver(
      children: [
        sliverGridBuilder(
          itemCount,
          AdditionalSliverChildDelegate(
            builder: itemBuilder,
            childCount: itemCount,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
          ),
        ),
        SliverToBoxAdapter(child: additionalItemBuilder!(context)),
      ],
    );
  }
}
