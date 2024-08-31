class DataPage<T> {
  final int offset;
  final Iterable<T> data;

  const DataPage({required this.offset, required this.data});
}

class DataDelta<T> {
  final bool Function(T element) from;
  final T Function(T element) to;

  DataDelta({required this.from, required this.to});
}

class DataNew<T> {
  final T item;
  final bool first;

  DataNew({required this.item, required this.first});
}

class DataEvent<T> {
  final DataDelta<T>? update;
  final DataNew<T>? create;
  final bool Function(T element)? delete;

  DataEvent._({this.delete, this.create, this.update});

  factory DataEvent.update(bool Function(T element) from, T Function(T element) to) => DataEvent._(update: DataDelta(from: from, to: to));

  factory DataEvent.create(T element, {bool first = false}) => DataEvent._(create: DataNew(item: element, first: first));

  factory DataEvent.delete(bool Function(T element) finder) => DataEvent._(delete: finder);
}
