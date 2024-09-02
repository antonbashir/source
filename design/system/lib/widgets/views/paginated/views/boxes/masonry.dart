import 'package:design/constants/pagination.dart';
import 'package:design/widgets/views/paginated/builder/builder.dart';
import 'package:design/widgets/views/paginated/controller/controller.dart';
import 'package:design/widgets/views/paginated/delegates/child.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:design/common/common.dart';
import 'package:design/delegates/sliver/additional.dart';

class PaginatedMasonryGridView<PageKeyType, ItemType> extends StatelessWidget {
  final PaginationController<PageKeyType, ItemType> paginationController;
  final PaginatedChildBuilderDelegate<ItemType> builderDelegate;
  final SliverSimpleGridDelegateBuilder gridDelegateBuilder;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? scrollController;
  final bool? primary;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double? cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final bool _shrinkWrapFirstPageIndicators;

  const PaginatedMasonryGridView({
    required this.paginationController,
    required this.builderDelegate,
    required this.gridDelegateBuilder,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.scrollController,
    this.primary,
    this.physics,
    this.padding,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    bool shrinkWrap = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    super.key,
  }) : _shrinkWrapFirstPageIndicators = shrinkWrap;

  PaginatedMasonryGridView.count({
    required this.paginationController,
    required this.builderDelegate,
    required int crossAxisCount,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.scrollController,
    this.primary,
    this.physics,
    this.padding,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    bool shrinkWrap = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    super.key,
  })  : _shrinkWrapFirstPageIndicators = shrinkWrap,
        gridDelegateBuilder = ((childCount) => SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
            ));

  PaginatedMasonryGridView.extent({
    required this.paginationController,
    required this.builderDelegate,
    required double maxCrossAxisExtent,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.scrollController,
    this.primary,
    this.physics,
    this.padding,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    bool shrinkWrap = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    super.key,
  })  : _shrinkWrapFirstPageIndicators = shrinkWrap,
        gridDelegateBuilder = ((childCount) => SliverSimpleGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: maxCrossAxisExtent));

  @override
  Widget build(BuildContext context) => PaginatedLayoutBuilder<PageKeyType, ItemType>(
        layoutMode: PaginatedLayoutMode.box,
        paginationController: paginationController,
        builderDelegate: builderDelegate,
        shrinkWrapFirstPageIndicators: _shrinkWrapFirstPageIndicators,
        completedListingBuilder: (context, itemBuilder, itemCount, noMoreItemsIndicatorBuilder) => MasonryGridView.custom(
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: scrollController,
          primary: primary,
          physics: physics,
          padding: padding,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          cacheExtent: cacheExtent,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
          gridDelegate: gridDelegateBuilder(itemCount + (noMoreItemsIndicatorBuilder == null ? 0 : 1)),
          childrenDelegate: AdditionalSliverChildDelegate(
            builder: itemBuilder,
            childCount: itemCount,
            additionalItemBuilder: noMoreItemsIndicatorBuilder,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
          ),
        ),
        loadingListingBuilder: (context, itemBuilder, itemCount, progressIndicatorBuilder) => MasonryGridView.custom(
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: scrollController,
          primary: primary,
          physics: physics,
          padding: padding,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          cacheExtent: cacheExtent,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
          gridDelegate: gridDelegateBuilder(
            itemCount + 1,
          ),
          childrenDelegate: AdditionalSliverChildDelegate(
            builder: itemBuilder,
            childCount: itemCount,
            additionalItemBuilder: progressIndicatorBuilder,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
          ),
        ),
        errorListingBuilder: (context, itemBuilder, itemCount, errorIndicatorBuilder) => MasonryGridView.custom(
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: scrollController,
          primary: primary,
          physics: physics,
          padding: padding,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          cacheExtent: cacheExtent,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
          gridDelegate: gridDelegateBuilder(itemCount + 1),
          childrenDelegate: AdditionalSliverChildDelegate(
            builder: itemBuilder,
            childCount: itemCount,
            additionalItemBuilder: errorIndicatorBuilder,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
          ),
        ),
        noMoreItemsIndicatorBuilder: builderDelegate.noMoreItemsIndicatorBuilder,
        firstPageErrorIndicatorBuilder:  builderDelegate.firstPageErrorIndicatorBuilder,
        firstPageProgressIndicatorBuilder:  builderDelegate.firstPageProgressIndicatorBuilder,
        newPageErrorIndicatorBuilder: builderDelegate.newPageErrorIndicatorBuilder,
        newPageProgressIndicatorBuilder: builderDelegate.newPageProgressIndicatorBuilder,
      );
}
