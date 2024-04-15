import 'dart:async';

import 'package:design/borders/squircle/border.dart';
import 'package:design/common/common.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/logging/logging.dart';
import 'package:design/model/data.dart';
import 'package:design/theme/tokens/colors.dart';
import 'package:design/widgets/views/containers/shimmer.dart';
import 'package:design/widgets/views/paginated/controller/controller.dart';
import 'package:design/widgets/views/paginated/delegates/child.dart';
import 'package:design/widgets/views/paginated/model/state.dart';
import 'package:design/widgets/views/paginated/views/boxes/list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef DynamicListStream<T> = Stream<DataEvent<T>>;

class DynamicListNotifier<T> extends ValueNotifier<DataPage<T>> {
  final FutureOr<Iterable<T>> Function(int offset, int limit, bool Function(T element) filter) _fetcher;
  final ObserverList<void Function()> _updateListeners = ObserverList<void Function()>();
  var _last = false;
  bool Function(T element) _filter;
  Comparator<T>? _sorter;

  bool Function(T element)? get filter => _filter;
  Comparator<T>? get sorter => _sorter;
  bool get last => _last;

  DynamicListNotifier(this._fetcher, {bool Function(T element)? filter, Comparator<T>? sorter})
      : _sorter = sorter,
        _filter = filter ?? ((_) => true),
        super(const DataPage(offset: -1, data: []));

  void update({bool Function(T element)? filter, Comparator<T>? sorter}) {
    if (filter != null) _filter = filter;
    if (sorter != null) _sorter = sorter;
    _notifyUpdateListeners();
  }

  void clear() => value = const DataPage(offset: -1, data: []);

  Future<void> _fetch(int offset, int limit) async {
    final data = await _fetcher(offset, limit, _filter);
    _last = data.length < limit;
    value = DataPage(offset: offset, data: data);
  }

  void _addUpdateListener(void Function() onUpdate) => _updateListeners.add(onUpdate);
  void _removeUpdateListener(void Function() onUpdate) => _updateListeners.remove(onUpdate);
  void _notifyUpdateListeners() {
    for (var listener in _updateListeners) {
      listener();
    }
  }
}

class DynamicListView<T> extends StatefulWidget {
  final DynamicListNotifier<T> dataProvider;
  final ItemWidgetBuilder<T> itemBuilder;
  final int pageSize;
  final DynamicListStream<T>? refreshStream;
  final ScrollController? scrollController;
  final double? height;
  final Axis? scrollDirection;
  final void Function(List<T> items)? onChanged;
  final Widget? progressIndicator;
  final Widget? emptyIndicator;
  final Widget Function(dynamic error, StackTrace stack)? errorBuilder;
  final Key? listKey;

  DynamicListView({
    super.key,
    required this.itemBuilder,
    required this.pageSize,
    required this.dataProvider,
    this.listKey,
    this.height,
    this.scrollController,
    this.scrollDirection,
    this.onChanged,
    this.progressIndicator,
    this.emptyIndicator,
    this.errorBuilder,
    DynamicListStream<T>? refreshStream,
  }) : refreshStream = refreshStream?.asBroadcastStream();

  @override
  State<StatefulWidget> createState() => _DynamicListViewState<T>();
}

class _DynamicListViewState<T> extends State<DynamicListView<T>> {
  final _controller = PaginationController<int, T>(firstPageKey: 0);
  StreamSubscription? _refresher;

  @override
  void initState() {
    super.initState();
    _controller.removePageRequestListener(_fetch);
    _controller.addPageRequestListener(_fetch);
    _controller.addListener(_notify);
    _refresher = widget.refreshStream?.listen(_onRefresh, onError: (error) => Logging.error(error), cancelOnError: false);
    widget.dataProvider.addListener(_onData);
    widget.dataProvider._addUpdateListener(_onNotifier);
  }

  @override
  void dispose() {
    _controller.removePageRequestListener(_fetch);
    _controller.removeListener(_notify);
    _refresher?.cancel();
    widget.dataProvider.removeListener(_onData);
    widget.dataProvider._removeUpdateListener(_onNotifier);
    super.dispose();
  }

  void _fetch(int page) {
    widget.dataProvider._fetch(page, widget.pageSize).onError((error, stack) {
      if (mounted) {
        _controller.error = error;
        return;
      }
    });
  }

  void _onData() {
    if (mounted) {
      final provider = widget.dataProvider;
      final page = provider.value;
      final data = page.data;
      if (data.isEmpty) {
        if (provider.sorter != null) {
          List<T> items = [..._controller.items ?? [], ...data];
          items.sort((a, b) => provider.sorter!(a, b));
          _controller.value = PaginatedLayoutState(items: items, error: null, nextPageKey: null);
          return;
        }
        _controller.finish([]);
        return;
      }
      final isLastPage = data.length < widget.pageSize;
      if (isLastPage) {
        if (provider.sorter != null) {
          List<T> items = [..._controller.items ?? [], ...data];
          items.sort((a, b) => provider.sorter!(a, b));
          _controller.value = PaginatedLayoutState(items: items, error: null, nextPageKey: null);
          return;
        }
        _controller.finish(data.toList());
        return;
      }
      if (provider.sorter != null) {
        List<T> items = [..._controller.items ?? [], ...data];
        items.sort((a, b) => provider.sorter!(a, b));
        _controller.value = PaginatedLayoutState(items: items, error: null, nextPageKey: page.offset + data.length);
        return;
      }
      _controller.add(data.toList(), page.offset + data.length);
    }
  }

  void _onNotifier() {
    if (mounted) {
      if (_controller.value.items?.isNotEmpty == true) {
        _controller.refresh();
        return;
      }
      _fetch(_controller.firstPageKey);
    }
  }

  void _onRefresh(DataEvent<T> value) {
    if (mounted) {
      final provider = widget.dataProvider;
      final filter = provider._filter;
      final sorter = provider._sorter;
      final last = provider.last;
      var changed = false;
      var modified = [...(_controller.items ?? <T>[])];
      if (value.update != null) {
        final allExisted = modified.indexed.where((element) => value.update!.from(element.$2));
        if (allExisted.isNotEmpty) {
          for (var existed in allExisted) {
            final permitted = filter(value.update!.to(modified[existed.$1]));
            if (permitted) {
              modified[existed.$1] = value.update!.to(modified[existed.$1]);
            }
            if (!permitted) {
              modified.removeWhere(value.update!.from);
            }
          }
          changed = true;
        }
      }
      if (value.delete != null) {
        modified.removeWhere(value.delete!);
        changed = true;
      }
      if (value.create != null && (last || value.create!.first) && filter(value.create!.item)) {
        modified = value.create!.first ? [value.create!.item, ...modified] : [...modified, value.create!.item];
        changed = true;
      }
      if (changed) {
        sorter?.let(modified.sort);
        _controller.items = modified;
      }
    }
  }

  void _notify() => widget.onChanged?.call(_controller.items ?? []);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: widget.height,
        child: PaginatedListView<int, T>(
          key: widget.listKey,
          scrollDirection: widget.scrollDirection ?? Axis.vertical,
          scrollController: widget.scrollController ?? ScrollController(),
          builderDelegate: PaginatedChildBuilderDelegate<T>(
            noItemsFoundIndicatorBuilder: (context) => widget.emptyIndicator ?? Container(),
            noMoreItemsIndicatorBuilder: (context) => widget.emptyIndicator ?? Container(),
            firstPageProgressIndicatorBuilder: (context) =>
                widget.progressIndicator ??
                Shimmer.fromColors(
                  baseColor: context.palette.neutral.shade700,
                  highlightColor: context.palette.neutral.shade600,
                  child: Column(
                    children: List.generate(
                      widget.pageSize,
                      (_) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                          child: Container(
                            height: double.infinity,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: SquircleBorder(
                                borderRadius: context.borders.tiny.squircle(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            newPageProgressIndicatorBuilder: (context) => widget.progressIndicator ?? Container(),
            firstPageErrorIndicatorBuilder: (context) => widget.errorBuilder?.call(_controller.error, StackTrace.current) ?? Container(),
            newPageErrorIndicatorBuilder: (context) => widget.errorBuilder?.call(_controller.error, StackTrace.current) ?? Container(),
            itemBuilder: widget.itemBuilder,
            animateTransitions: false,
          ),
          paginationController: _controller,
        ),
      );
}
