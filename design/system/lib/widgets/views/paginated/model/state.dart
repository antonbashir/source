import 'package:design/constants/pagination.dart';

class PaginatedLayoutState<PageKeyType, ItemType> {
  final List<ItemType>? items;
  final dynamic error;
  final PageKeyType? nextPageKey;

  const PaginatedLayoutState({this.nextPageKey, this.items, this.error});

  int? get _count => items?.length;
  bool get _hasNextPage => nextPageKey != null;
  bool get _hasItems => _count != null && _count! > 0;
  bool get _hasError => error != null;
  bool get _isListingUnfinished => _hasItems && _hasNextPage;
  bool get _isOngoing => _isListingUnfinished && !_hasError;
  bool get _isCompleted => _hasItems && !_hasNextPage;
  bool get _isLoadingFirstPage => _count == null && !_hasError;
  bool get _hasSubsequentPageError => _isListingUnfinished && _hasError;
  bool get _isEmpty => _count != null && _count == 0 && !_hasError;

  PaginatedLayoutStatus get status {
    if (_isOngoing) return PaginatedLayoutStatus.ongoing;
    if (_isCompleted) return PaginatedLayoutStatus.completed;
    if (_isLoadingFirstPage) return PaginatedLayoutStatus.loadingFirstPage;
    if (_hasSubsequentPageError) return PaginatedLayoutStatus.subsequentPageError;
    return _isEmpty ? PaginatedLayoutStatus.noItemsFound : PaginatedLayoutStatus.firstPageError;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaginatedLayoutState && other.items == items && other.error == error && other.nextPageKey == nextPageKey;
  }

  @override
  int get hashCode => Object.hash(items.hashCode, error.hashCode, nextPageKey.hashCode);
}
