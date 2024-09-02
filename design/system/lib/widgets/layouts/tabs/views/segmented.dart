import 'package:design/constants/tabs.dart';
import 'package:design/widgets/layouts/tabs/controller/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class BaseSegmentedTabBar extends StatefulWidget {
  final bool isExpanded;
  final double gap;
  final int initialIndex;
  final ValueChanged<int> valueChanged;
  final List<Widget> children;
  final Duration animationDuration;
  final TabBarDirection direction;
  final TabController? tabController;

  const BaseSegmentedTabBar({
    super.key,
    required this.animationDuration,
    required this.isExpanded,
    required this.gap,
    required this.initialIndex,
    required this.valueChanged,
    required this.children,
    this.direction = TabBarDirection.row,
    this.tabController,
  });

  @override
  State<BaseSegmentedTabBar> createState() => _BaseSegmentedTabBarState();
}

class _BaseSegmentedTabBarState extends State<BaseSegmentedTabBar> with TickerProviderStateMixin {
  late List<GlobalKey> _tabKeys;
  late TabController? _controller;

  @override
  void initState() {
    super.initState();
    _tabKeys = widget.children.map((Widget tab) => GlobalKey()).toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = widget.tabController ??
        DefaultTabController.maybeOf(context) ??
        TabController(
          length: widget.children.length,
          vsync: this,
          initialIndex: widget.initialIndex,
          animationDuration: widget.animationDuration,
        );
  }

  @override
  void didUpdateWidget(BaseSegmentedTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children.length > _tabKeys.length) {
      final int delta = widget.children.length - _tabKeys.length;
      _tabKeys.addAll(List<GlobalKey>.generate(delta, (_) => GlobalKey()));
      return;
    }
    if (widget.children.length < _tabKeys.length) {
      _tabKeys.removeRange(widget.children.length, _tabKeys.length);
    }
  }

  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }

  void _handleTap(int index) {
    assert(index >= 0 && index < widget.children.length);
    _controller!.index = index;
    widget.valueChanged.call(index);
  }

  @override
  Widget build(BuildContext context) => switch (widget.direction) {
        TabBarDirection.row => Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              widget.children.length * 2 - 1,
              (index) {
                final derivedIndex = index ~/ 2;
                return widget.isExpanded
                    ? index.isEven
                        ? Expanded(
                            child: Listener(
                              onPointerDown: (_) => _handleTap(derivedIndex),
                              child: widget.children[derivedIndex],
                            ),
                          )
                        : SizedBox(width: widget.gap)
                    : index.isEven
                        ? Listener(
                            onPointerDown: (_) => _handleTap(derivedIndex),
                            child: widget.children[derivedIndex],
                          )
                        : SizedBox(width: widget.gap);
              },
            ),
          ),
        TabBarDirection.column => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              widget.children.length * 2 - 1,
              (index) {
                final derivedIndex = index ~/ 2;
                return widget.isExpanded
                    ? index.isEven
                        ? Expanded(
                            child: Listener(
                              onPointerDown: (_) => _handleTap(derivedIndex),
                              child: widget.children[derivedIndex],
                            ),
                          )
                        : SizedBox(height: widget.gap)
                    : index.isEven
                        ? Listener(
                            onPointerDown: (_) => _handleTap(derivedIndex),
                            child: widget.children[derivedIndex],
                          )
                        : SizedBox(height: widget.gap);
              },
            ),
          ),
      };
}
