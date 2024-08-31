import 'package:flutter/widgets.dart';

import 'package:design/common/common.dart';

class PaginatedChildBuilderDelegate<ItemType> {
  final ItemWidgetBuilder<ItemType> itemBuilder;
  final WidgetBuilder firstPageErrorIndicatorBuilder;
  final WidgetBuilder newPageErrorIndicatorBuilder;
  final WidgetBuilder firstPageProgressIndicatorBuilder;
  final WidgetBuilder newPageProgressIndicatorBuilder;
  final WidgetBuilder noItemsFoundIndicatorBuilder;
  final WidgetBuilder noMoreItemsIndicatorBuilder;
  final Duration? transitionDuration;
  final bool animateTransitions;

  const PaginatedChildBuilderDelegate({
    required this.itemBuilder,
    required this.firstPageErrorIndicatorBuilder,
    required this.newPageErrorIndicatorBuilder,
    required this.firstPageProgressIndicatorBuilder,
    required this.newPageProgressIndicatorBuilder,
    required this.noItemsFoundIndicatorBuilder,
    required this.noMoreItemsIndicatorBuilder,
    this.animateTransitions = false,
    this.transitionDuration,
  });
}
