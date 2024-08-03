import 'package:design/widgets/views/paginated/controller/controller.dart';
import 'package:design/widgets/views/paginated/delegates/child.dart';
import 'package:design/widgets/views/paginated/views/slivers/grid.dart';
import 'package:flutter/widgets.dart';

class PaginatedGridView<PageKeyType, ItemType> extends BoxScrollView {
  final PaginationController<PageKeyType, ItemType> paginationController;
  final PaginatedChildBuilderDelegate<ItemType> builderDelegate;
  final SliverGridDelegate gridDelegate;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final bool showNewPageProgressIndicatorAsGridChild;
  final bool showNewPageErrorIndicatorAsGridChild;
  final bool showNoMoreItemsIndicatorAsGridChild;

  const PaginatedGridView({
    required this.paginationController,
    required this.builderDelegate,
    required this.gridDelegate,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.showNewPageProgressIndicatorAsGridChild = true,
    this.showNewPageErrorIndicatorAsGridChild = true,
    this.showNoMoreItemsIndicatorAsGridChild = true,
    super.controller,
    super.scrollDirection,
    super.reverse,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    super.cacheExtent,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    super.key,
  });

  @override
  Widget buildChildLayout(BuildContext context) => PaginatedSliverGrid<PageKeyType, ItemType>(
        builderDelegate: builderDelegate,
        paginationController: paginationController,
        gridDelegate: gridDelegate,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        showNewPageProgressIndicatorAsGridChild: showNewPageProgressIndicatorAsGridChild,
        showNewPageErrorIndicatorAsGridChild: showNewPageErrorIndicatorAsGridChild,
        showNoMoreItemsIndicatorAsGridChild: showNoMoreItemsIndicatorAsGridChild,
        shrinkWrapFirstPageIndicators: shrinkWrap,
      );
}
