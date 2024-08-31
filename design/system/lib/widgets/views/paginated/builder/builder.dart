import 'dart:math';

import 'package:design/common/listener.dart';
import 'package:design/constants/pagination.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/views/paginated/controller/controller.dart';
import 'package:design/widgets/views/paginated/delegates/child.dart';
import 'package:design/widgets/views/paginated/model/state.dart';
import 'package:flutter/widgets.dart';
import 'package:sliver_tools/sliver_tools.dart';

typedef PaginationCompletedListingBuilder = Widget Function(
  BuildContext context,
  IndexedWidgetBuilder itemWidgetBuilder,
  int itemCount,
  WidgetBuilder? noMoreItemsIndicatorBuilder,
);

typedef PaginationErrorListingBuilder = Widget Function(
  BuildContext context,
  IndexedWidgetBuilder itemWidgetBuilder,
  int itemCount,
  WidgetBuilder newPageErrorIndicatorBuilder,
);

typedef PaginationLoadingListingBuilder = Widget Function(
  BuildContext context,
  IndexedWidgetBuilder itemWidgetBuilder,
  int itemCount,
  WidgetBuilder newPageProgressIndicatorBuilder,
);

class PaginatedLayoutBuilder<PageKeyType, ItemType> extends StatefulWidget {
  final PaginationController<PageKeyType, ItemType> paginationController;
  final PaginatedChildBuilderDelegate<ItemType> builderDelegate;
  final PaginationLoadingListingBuilder loadingListingBuilder;
  final PaginationErrorListingBuilder errorListingBuilder;
  final PaginationCompletedListingBuilder completedListingBuilder;
  final bool shrinkWrapFirstPageIndicators;
  final PaginatedLayoutMode layoutMode;
  final WidgetBuilder noMoreItemsIndicatorBuilder;
  final WidgetBuilder firstPageProgressIndicatorBuilder;
  final WidgetBuilder firstPageErrorIndicatorBuilder;
  final WidgetBuilder newPageErrorIndicatorBuilder;
  final WidgetBuilder newPageProgressIndicatorBuilder;

  const PaginatedLayoutBuilder({
    required this.paginationController,
    required this.builderDelegate,
    required this.loadingListingBuilder,
    required this.errorListingBuilder,
    required this.completedListingBuilder,
    required this.layoutMode,
    required this.noMoreItemsIndicatorBuilder,
    required this.firstPageProgressIndicatorBuilder,
    required this.firstPageErrorIndicatorBuilder,
    required this.newPageErrorIndicatorBuilder,
    required this.newPageProgressIndicatorBuilder,
    this.shrinkWrapFirstPageIndicators = false,
    super.key,
  });

  @override
  State<PaginatedLayoutBuilder<PageKeyType, ItemType>> createState() => _PaginatedLayoutBuilderState<PageKeyType, ItemType>();
}

class _PaginatedLayoutBuilderState<PageKeyType, ItemType> extends State<PaginatedLayoutBuilder<PageKeyType, ItemType>> {
  var _hasRequestedNextPage = false;

  @override
  Widget build(BuildContext context) => ListenableListener(
        listenable: widget.paginationController,
        listener: () {
          final status = widget.paginationController.value.status;
          if (status == PaginatedLayoutStatus.loadingFirstPage) {
            widget.paginationController.notifyPageRequestListeners(
              widget.paginationController.firstPageKey,
            );
          }

          if (status == PaginatedLayoutStatus.ongoing) {
            _hasRequestedNextPage = false;
          }
        },
        child: ValueListenableBuilder<PaginatedLayoutState<PageKeyType, ItemType>>(
          valueListenable: widget.paginationController,
          builder: (context, paginationState, _) {
            final itemList = widget.paginationController.items;
            final child = switch (paginationState.status) {
              PaginatedLayoutStatus.ongoing => widget.loadingListingBuilder(
                  context,
                  (context, index) => _buildListItemWidget(
                    context,
                    index,
                    itemList!,
                  ),
                  widget.paginationController.count,
                  widget.newPageProgressIndicatorBuilder,
                ),
              PaginatedLayoutStatus.completed => widget.completedListingBuilder(
                  context,
                  (context, index) => _buildListItemWidget(
                    context,
                    index,
                    itemList!,
                  ),
                  widget.paginationController.count,
                  widget.noMoreItemsIndicatorBuilder,
                ),
              PaginatedLayoutStatus.loadingFirstPage => _FirstPageStatusIndicatorBuilder(
                  builder: widget.firstPageProgressIndicatorBuilder,
                  shrinkWrap: widget.shrinkWrapFirstPageIndicators,
                  layoutProtocol: widget.layoutMode,
                ),
              PaginatedLayoutStatus.subsequentPageError => widget.errorListingBuilder(
                  context,
                  (context, index) => _buildListItemWidget(
                    context,
                    index,
                    itemList!,
                  ),
                  widget.paginationController.count,
                  (context) => widget.newPageErrorIndicatorBuilder(context),
                ),
              PaginatedLayoutStatus.noItemsFound => _FirstPageStatusIndicatorBuilder(
                  builder: widget.noMoreItemsIndicatorBuilder,
                  shrinkWrap: widget.shrinkWrapFirstPageIndicators,
                  layoutProtocol: widget.layoutMode,
                ),
              _ => _FirstPageStatusIndicatorBuilder(
                  builder: widget.firstPageErrorIndicatorBuilder,
                  shrinkWrap: widget.shrinkWrapFirstPageIndicators,
                  layoutProtocol: widget.layoutMode,
                )
            };
            if (widget.builderDelegate.animateTransitions) {
              if (widget.layoutMode == PaginatedLayoutMode.sliver) {
                return SliverAnimatedSwitcher(
                  duration: widget.builderDelegate.transitionDuration ?? context.transitions.transitionDuration,
                  child: child,
                );
              }
              return AnimatedSwitcher(
                duration: widget.builderDelegate.transitionDuration ?? context.transitions.transitionDuration,
                child: child,
              );
            }
            return child;
          },
        ),
      );

  Widget _buildListItemWidget(BuildContext context, int index, List<ItemType> itemList) {
    if (!_hasRequestedNextPage) {
      final newPageRequestTriggerIndex = max(0, widget.paginationController.count - (widget.paginationController.invisibleItemsThreshold ?? defaultPaginationInvisibleItemsThreshold));
      final isBuildingTriggerIndexItem = index == newPageRequestTriggerIndex;
      if (widget.paginationController.hasNext && isBuildingTriggerIndexItem) {
        WidgetsBinding.instance.addPostFrameCallback((_) => widget.paginationController.notifyPageRequestListeners(widget.paginationController.nextKey as PageKeyType));
        _hasRequestedNextPage = true;
      }
    }
    return widget.builderDelegate.itemBuilder(context, itemList[index], index);
  }
}

class _FirstPageStatusIndicatorBuilder extends StatelessWidget {
  final WidgetBuilder builder;
  final bool shrinkWrap;
  final PaginatedLayoutMode layoutProtocol;

  const _FirstPageStatusIndicatorBuilder({
    required this.builder,
    required this.layoutProtocol,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) => layoutProtocol == PaginatedLayoutMode.sliver
      ? shrinkWrap
          ? SliverToBoxAdapter(child: builder(context))
          : SliverFillRemaining(hasScrollBody: false, child: builder(context))
      : shrinkWrap
          ? builder(context)
          : Center(child: builder(context));
}
