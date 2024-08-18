import 'package:design/constants/breakpoints.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/model/mixins.dart';

class Breakpoints<T extends Interpolatable<T>> {
  final T _default;
  final Map<BreakpointSize, T> _sizes;

  T get fallback => _default;
  
  T get tiny => _sizes[BreakpointSize.tiny]!;
  T get small => _sizes[BreakpointSize.small]!;
  T get medium => _sizes[BreakpointSize.medium]!;
  T get large => _sizes[BreakpointSize.large]!;
  T get gigantic => _sizes[BreakpointSize.gigantic]!;
  T get colossal => _sizes[BreakpointSize.colossal]!;

  T? operator [](BreakpointSize key) => _sizes[key];

  Breakpoints(this._default, this._sizes);

  Breakpoints<T> lerp(Breakpoints<T>? other, double t) {
    if (other is! Breakpoints<T>) return this;
    return Breakpoints<T>(
      _default.lerp(other._default, t),
      _sizes.mapValues((key, value) => value.lerp(other._sizes[key], t)),
    );
  }

  T select(BreakpointSize? size) => _sizes[size] ?? _default;
}
