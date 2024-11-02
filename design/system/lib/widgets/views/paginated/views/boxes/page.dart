import 'package:design/constants/pagination.dart';
import 'package:design/delegates/sliver/additional.dart';
import 'package:design/widgets/views/paginated/builder/builder.dart';
import 'package:design/widgets/views/paginated/controller/controller.dart';
import 'package:design/widgets/views/paginated/delegates/child.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class PaginatedPageView<PageKeyType, ItemType> extends StatelessWidget {
  final PaginationController<PageKeyType, ItemType> paginationController;
  final PaginatedChildBuilderDelegate<ItemType> builderDelegate;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final bool allowImplicitScrolling;
  final String? restorationId;
  final PageController? pageController;
  final ScrollBehavior? scrollBehavior;
  final Axis scrollDirection;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final bool reverse;
  final ScrollPhysics? physics;
  final bool pageSnapping;
  final void Function(int)? onPageChanged;
  final bool padEnds;
  final bool shrinkWrapFirstPageIndicators;

  const PaginatedPageView({
    required this.paginationController,
    required this.builderDelegate,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.allowImplicitScrolling = false,
    this.restorationId,
    this.pageController,
    this.scrollBehavior,
    this.scrollDirection = Axis.horizontal,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.reverse = false,
    this.physics,
    this.onPageChanged,
    this.pageSnapping = true,
    this.padEnds = true,
    this.shrinkWrapFirstPageIndicators = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => PaginatedLayoutBuilder<PageKeyType, ItemType>(
        layoutMode: PaginatedLayoutMode.box,
        paginationController: paginationController,
        builderDelegate: builderDelegate,
        shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
        completedListingBuilder: (context, itemBuilder, itemCount, noMoreItemsIndicatorBuilder) => PageView.custom(
          key: key,
          restorationId: restorationId,
          controller: pageController,
          onPageChanged: onPageChanged,
          scrollBehavior: scrollBehavior,
          scrollDirection: scrollDirection,
          dragStartBehavior: dragStartBehavior,
          clipBehavior: clipBehavior,
          allowImplicitScrolling: allowImplicitScrolling,
          reverse: reverse,
          physics: physics,
          pageSnapping: pageSnapping,
          padEnds: padEnds,
          childrenDelegate: AdditionalSliverChildDelegate(
            builder: itemBuilder,
            childCount: itemCount,
            additionalItemBuilder: noMoreItemsIndicatorBuilder,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
          ),
        ),
        loadingListingBuilder: (context, itemBuilder, itemCount, progressIndicatorBuilder) => PageView.custom(
          key: key,
          restorationId: restorationId,
          controller: pageController,
          onPageChanged: onPageChanged,
          scrollBehavior: scrollBehavior,
          scrollDirection: scrollDirection,
          dragStartBehavior: dragStartBehavior,
          clipBehavior: clipBehavior,
          allowImplicitScrolling: allowImplicitScrolling,
          reverse: reverse,
          physics: physics,
          pageSnapping: pageSnapping,
          padEnds: padEnds,
          childrenDelegate: AdditionalSliverChildDelegate(
            builder: itemBuilder,
            childCount: itemCount,
            additionalItemBuilder: progressIndicatorBuilder,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
          ),
        ),
        errorListingBuilder: (context, itemBuilder, itemCount, errorIndicatorBuilder) => PageView.custom(
          key: key,
          restorationId: restorationId,
          controller: pageController,
          onPageChanged: onPageChanged,
          scrollBehavior: scrollBehavior,
          scrollDirection: scrollDirection,
          dragStartBehavior: dragStartBehavior,
          clipBehavior: clipBehavior,
          allowImplicitScrolling: allowImplicitScrolling,
          reverse: reverse,
          physics: physics,
          pageSnapping: pageSnapping,
          padEnds: padEnds,
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
        firstPageErrorIndicatorBuilder: builderDelegate.firstPageErrorIndicatorBuilder,
        firstPageProgressIndicatorBuilder:  builderDelegate.firstPageProgressIndicatorBuilder,
        newPageErrorIndicatorBuilder: builderDelegate.newPageErrorIndicatorBuilder,
        newPageProgressIndicatorBuilder: builderDelegate.newPageProgressIndicatorBuilder,
      );
}
