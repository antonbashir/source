import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class AdditionalSliverChildDelegate extends SliverChildBuilderDelegate {
  AdditionalSliverChildDelegate({
    required IndexedWidgetBuilder builder,
    required int childCount,
    WidgetBuilder? additionalItemBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback? semanticIndexCallback,
  }) : super(
          additionalItemBuilder == null ? builder : (context, index) => index == childCount ? additionalItemBuilder(context) : builder(context, index),
          childCount: additionalItemBuilder == null ? childCount : childCount + 1,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          semanticIndexCallback: semanticIndexCallback ?? (_, index) => index,
        );

  AdditionalSliverChildDelegate.separated({
    required IndexedWidgetBuilder builder,
    required int childCount,
    required IndexedWidgetBuilder separatorBuilder,
    WidgetBuilder? additionalItemBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
  }) : this(
          builder: (context, index) {
            final itemIndex = index ~/ 2;
            if (index.isEven) {
              return builder(context, itemIndex);
            }
            return separatorBuilder(context, itemIndex);
          },
          childCount: math.max(0, childCount * 2 - (additionalItemBuilder != null ? 0 : 1)),
          additionalItemBuilder: additionalItemBuilder,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          semanticIndexCallback: (_, index) => index.isEven ? index ~/ 2 : null,
        );
}
