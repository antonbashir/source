import 'package:design/constants/assertions.dart';
import 'package:design/widgets/views/paginated/controller/controller.dart';
import 'package:design/widgets/views/paginated/delegates/child.dart';
import 'package:design/widgets/views/paginated/views/slivers/list.dart';
import 'package:flutter/widgets.dart';

class PaginatedListView<PageKeyType, ItemType> extends BoxScrollView {
  const PaginatedListView({
    required this.paginationController,
    required this.builderDelegate,
    ScrollController? scrollController,
    super.scrollDirection,
    super.reverse,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    this.itemExtent,
    this.prototypeItem,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    super.cacheExtent,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    super.key,
  })  : assert(itemExtent == null || prototypeItem == null, listItemExtentAssertion),
        _separatorBuilder = null,
        _shrinkWrapFirstPageIndicators = shrinkWrap,
        super(controller: scrollController);

  const PaginatedListView.separated({
    required this.paginationController,
    required this.builderDelegate,
    required IndexedWidgetBuilder separatorBuilder,
    ScrollController? scrollController,
    super.scrollDirection,
    super.reverse,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    this.itemExtent,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    super.cacheExtent,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    super.key,
  })  : prototypeItem = null,
        _shrinkWrapFirstPageIndicators = shrinkWrap,
        _separatorBuilder = separatorBuilder,
        super(controller: scrollController);

  final PaginationController<PageKeyType, ItemType> paginationController;
  final PaginatedChildBuilderDelegate<ItemType> builderDelegate;
  final IndexedWidgetBuilder? _separatorBuilder;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? itemExtent;
  final Widget? prototypeItem;
  final bool _shrinkWrapFirstPageIndicators;

  @override
  Widget buildChildLayout(BuildContext context) {
    final separatorBuilder = _separatorBuilder;
    return separatorBuilder != null
        ? PaginatedSliverList<PageKeyType, ItemType>.separated(
            builderDelegate: builderDelegate,
            paginationController: paginationController,
            separatorBuilder: separatorBuilder,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            itemExtent: itemExtent,
            shrinkWrapFirstPageIndicators: _shrinkWrapFirstPageIndicators,
          )
        : PaginatedSliverList<PageKeyType, ItemType>(
            builderDelegate: builderDelegate,
            paginationController: paginationController,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            itemExtent: itemExtent,
            shrinkWrapFirstPageIndicators: _shrinkWrapFirstPageIndicators,
            prototypeItem: prototypeItem,
          );
  }
}
