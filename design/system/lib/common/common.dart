import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

typedef ItemWidgetBuilder<ItemType> = Widget Function(BuildContext context, ItemType item, int index);
typedef SliverSimpleGridDelegateBuilder = SliverSimpleGridDelegate Function(int childCount);
typedef SliverGridBuilder = SliverWithKeepAliveWidget Function(int childCount, SliverChildDelegate delegate);
