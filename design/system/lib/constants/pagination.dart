const defaultPaginationInvisibleItemsThreshold = 3;

enum PaginatedLayoutMode { sliver, box }

enum PaginatedLayoutStatus {
  ongoing,
  completed,
  loadingFirstPage,
  firstPageError,
  noItemsFound,
  subsequentPageError,
}
