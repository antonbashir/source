import 'package:design/constants/pagination.dart';
import 'package:design/widgets/views/paginated/model/state.dart';
import 'package:flutter/foundation.dart';

typedef PageRequestListener<PageKeyType> = void Function(PageKeyType pageKey);
typedef PaginatedLayoutStatusListener = void Function(PaginatedLayoutStatus status);

class PaginationController<PageKeyType, ItemType> extends ValueNotifier<PaginatedLayoutState<PageKeyType, ItemType>> {
  final int? invisibleItemsThreshold;
  final PageKeyType firstPageKey;

  ObserverList<PaginatedLayoutStatusListener>? _statusListeners = ObserverList<PaginatedLayoutStatusListener>();
  ObserverList<PageRequestListener<PageKeyType>>? _pageRequestListeners = ObserverList<PageRequestListener<PageKeyType>>();

  List<ItemType>? get items => value.items;

  PaginationController({required this.firstPageKey, this.invisibleItemsThreshold}) : super(PaginatedLayoutState<PageKeyType, ItemType>(nextPageKey: firstPageKey));

  PaginationController.fromValue(super.value, {required this.firstPageKey, this.invisibleItemsThreshold});

  int get count => items?.length ?? 0;
  bool get hasNext => nextKey != null;
  dynamic get error => value.error;
  PageKeyType? get nextKey => value.nextPageKey;

  set items(List<ItemType>? newItemList) {
    value = PaginatedLayoutState<PageKeyType, ItemType>(
      error: error,
      items: newItemList,
      nextPageKey: nextKey,
    );
  }

  set error(dynamic newError) {
    value = PaginatedLayoutState<PageKeyType, ItemType>(
      error: newError,
      items: items,
      nextPageKey: nextKey,
    );
  }

  set nextKey(PageKeyType? newNextPageKey) {
    value = PaginatedLayoutState<PageKeyType, ItemType>(
      error: error,
      items: items,
      nextPageKey: newNextPageKey,
    );
  }

  @override
  set value(PaginatedLayoutState<PageKeyType, ItemType> newValue) {
    if (value.status != newValue.status) {
      notifyStatusListeners(newValue.status);
    }

    super.value = newValue;
  }

  void add(List<ItemType> newItems, PageKeyType? nextPageKey) {
    final previousItems = value.items ?? [];
    final itemList = previousItems + newItems;
    value = PaginatedLayoutState<PageKeyType, ItemType>(
      items: itemList,
      error: null,
      nextPageKey: nextPageKey,
    );
  }

  void finish(List<ItemType> newItems) => add(newItems, null);

  void retry() => error = null;

  void refresh() {
    value = PaginatedLayoutState<PageKeyType, ItemType>(
      nextPageKey: firstPageKey,
      error: null,
      items: null,
    );
  }

  void addStatusListener(PaginatedLayoutStatusListener listener) => _statusListeners!.add(listener);
  void removeStatusListener(PaginatedLayoutStatusListener listener) => _statusListeners!.remove(listener);
  void notifyStatusListeners(PaginatedLayoutStatus status) {
    if (_statusListeners!.isEmpty) {
      return;
    }

    final localListeners = List<PaginatedLayoutStatusListener>.from(_statusListeners!);
    for (var listener in localListeners) {
      if (_statusListeners!.contains(listener)) {
        listener(status);
      }
    }
  }

  void addPageRequestListener(PageRequestListener<PageKeyType> listener) => _pageRequestListeners!.add(listener);
  void removePageRequestListener(PageRequestListener<PageKeyType> listener) => _pageRequestListeners!.remove(listener);
  void notifyPageRequestListeners(PageKeyType pageKey) {
    if (_pageRequestListeners?.isEmpty ?? true) {
      return;
    }
    final localListeners = List<PageRequestListener<PageKeyType>>.from(_pageRequestListeners!);
    for (var listener in localListeners) {
      if (_pageRequestListeners!.contains(listener)) {
        listener(pageKey);
      }
    }
  }

  @override
  void dispose() {
    _statusListeners = null;
    _pageRequestListeners = null;
    super.dispose();
  }
}
