import 'package:design/model/mixins.dart';

class ThemeMutable<T extends ThemeComponent<T>, I extends ThemeComponent<I>> {
  T Function(I input) _factory;
  late I _input;
  T? _current;

  ThemeMutable(this._factory);

  ThemeMutable<T, I> initialize(I input) {
    _input = input;
    return this;
  }

  void mutate(I input, {T Function(I input)? override}) {
    if (input == _input && override == null) return;
    _factory = override ?? _factory;
    _input = input;
    _current = null;
  }

  ThemeMutable<T, I> lerp(ThemeMutable<T, I> other, double t) {
    final mutable = ThemeMutable(_factory);
    mutable._input = _input;
    mutable._current = _current?.lerp(other._current, t);
    return mutable;
  }

  @pragma("vm:prefer-inline")
  T call() {
    if (_current == null) {
      _current = _factory(_input);
      return _current!;
    }
    return _current!;
  }
}
