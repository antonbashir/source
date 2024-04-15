import 'package:design/borders/input/border.dart';
import 'package:design/constants/cursors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

enum VisualState {
  hovered,
  focused,
  pressed,
  dragged,
  selected,
  scrolledUnder,
  disabled,
  error,
}

typedef VisualPropertyResolver<T> = T Function(Set<VisualState> states);

abstract class VisualStateColor extends Color implements VisualStateProperty<Color> {
  const VisualStateColor(super.defaultValue);
  static VisualStateColor resolveWith(VisualPropertyResolver<Color> callback) => _VisualStateColor(callback);
  @override
  Color resolve(Set<VisualState> states);
}

class _VisualStateColor extends VisualStateColor {
  _VisualStateColor(this._resolve) : super(_resolve(_defaultStates).value);

  final VisualPropertyResolver<Color> _resolve;

  static const Set<VisualState> _defaultStates = <VisualState>{};

  @override
  Color resolve(Set<VisualState> states) => _resolve(states);
}

abstract class VisualStateMouseCursor extends MouseCursor implements VisualStateProperty<MouseCursor> {
  const VisualStateMouseCursor();

  @protected
  @override
  MouseCursorSession createSession(int device) {
    return resolve(<VisualState>{}).createSession(device);
  }

  @override
  MouseCursor resolve(Set<VisualState> states);

  static const VisualStateMouseCursor clickable = _VisualEnabledAndDisabledMouseCursor(
    enabledCursor: SystemMouseCursors.click,
    disabledCursor: SystemMouseCursors.basic,
    name: cursorClickable,
  );

  static const VisualStateMouseCursor textable = _VisualEnabledAndDisabledMouseCursor(
    enabledCursor: SystemMouseCursors.text,
    disabledCursor: SystemMouseCursors.basic,
    name: cursorTextable,
  );
}

class _VisualEnabledAndDisabledMouseCursor extends VisualStateMouseCursor {
  const _VisualEnabledAndDisabledMouseCursor({
    required this.enabledCursor,
    required this.disabledCursor,
    required this.name,
  });

  final MouseCursor enabledCursor;
  final MouseCursor disabledCursor;
  final String name;

  @override
  MouseCursor resolve(Set<VisualState> states) {
    if (states.contains(VisualState.disabled)) {
      return disabledCursor;
    }
    return enabledCursor;
  }

  @override
  String get debugDescription => 'MaterialStateMouseCursor($name)';
}

abstract class VisualStateBorderSide extends BorderSide implements VisualStateProperty<BorderSide?> {
  const VisualStateBorderSide();

  @override
  BorderSide? resolve(Set<VisualState> states);

  static VisualStateBorderSide resolveWith(VisualPropertyResolver<BorderSide?> callback) => _VisualStateBorderSide(callback);
}

class _VisualStateBorderSide extends VisualStateBorderSide {
  const _VisualStateBorderSide(this._resolve);

  final VisualPropertyResolver<BorderSide?> _resolve;

  @override
  BorderSide? resolve(Set<VisualState> states) {
    return _resolve(states);
  }
}

abstract class VisualStateOutlinedBorder extends OutlinedBorder implements VisualStateProperty<OutlinedBorder?> {
  const VisualStateOutlinedBorder();

  @override
  OutlinedBorder? resolve(Set<VisualState> states);
}

abstract class VisualStateTextStyle extends TextStyle implements VisualStateProperty<TextStyle> {
  const VisualStateTextStyle();
  static VisualStateTextStyle resolveWith(VisualPropertyResolver<TextStyle> callback) => _VisualStateTextStyle(callback);
  @override
  TextStyle resolve(Set<VisualState> states);
}

class _VisualStateTextStyle extends VisualStateTextStyle {
  const _VisualStateTextStyle(this._resolve);

  final VisualPropertyResolver<TextStyle> _resolve;

  @override
  TextStyle resolve(Set<VisualState> states) => _resolve(states);
}

abstract class VisualStateOutlineInputBorder extends OutlineInputBorder implements VisualStateProperty<InputBorder> {
  const VisualStateOutlineInputBorder();

  static VisualStateOutlineInputBorder resolveWith(VisualPropertyResolver<InputBorder> callback) => _VisualStateOutlineInputBorder(callback);

  @override
  InputBorder resolve(Set<VisualState> states);
}

class _VisualStateOutlineInputBorder extends VisualStateOutlineInputBorder {
  const _VisualStateOutlineInputBorder(this._resolve);

  final VisualPropertyResolver<InputBorder> _resolve;

  @override
  InputBorder resolve(Set<VisualState> states) => _resolve(states);
}

abstract class VisualStateUnderlineInputBorder extends UnderlineInputBorder implements VisualStateProperty<InputBorder> {
  const VisualStateUnderlineInputBorder();
  static VisualStateUnderlineInputBorder resolveWith(VisualPropertyResolver<InputBorder> callback) => _VisualStateUnderlineInputBorder(callback);
  @override
  InputBorder resolve(Set<VisualState> states);
}

class _VisualStateUnderlineInputBorder extends VisualStateUnderlineInputBorder {
  const _VisualStateUnderlineInputBorder(this._resolve);

  final VisualPropertyResolver<InputBorder> _resolve;

  @override
  InputBorder resolve(Set<VisualState> states) => _resolve(states);
}

abstract class VisualStateProperty<T> {
  T resolve(Set<VisualState> states);

  static T resolveAs<T>(T value, Set<VisualState> states) {
    if (value is VisualStateProperty<T>) {
      final VisualStateProperty<T> property = value;
      return property.resolve(states);
    }
    return value;
  }

  static VisualStateProperty<T> resolveWith<T>(VisualPropertyResolver<T> callback) => _VisualStatePropertyWith<T>(callback);
  static VisualStateProperty<T> all<T>(T value) => VisualStatePropertyAll<T>(value);
  static VisualStateProperty<T?>? lerp<T>(
    VisualStateProperty<T>? a,
    VisualStateProperty<T>? b,
    double t,
    T? Function(T?, T?, double) lerpFunction,
  ) {
    if (a == null && b == null) {
      return null;
    }
    return _VisualLerpProperties<T>(a, b, t, lerpFunction);
  }
}

class _VisualLerpProperties<T> implements VisualStateProperty<T?> {
  const _VisualLerpProperties(this.a, this.b, this.t, this.lerpFunction);

  final VisualStateProperty<T>? a;
  final VisualStateProperty<T>? b;
  final double t;
  final T? Function(T?, T?, double) lerpFunction;

  @override
  T? resolve(Set<VisualState> states) {
    final T? resolvedA = a?.resolve(states);
    final T? resolvedB = b?.resolve(states);
    return lerpFunction(resolvedA, resolvedB, t);
  }
}

class _VisualStatePropertyWith<T> implements VisualStateProperty<T> {
  _VisualStatePropertyWith(this._resolve);
  final VisualPropertyResolver<T> _resolve;
  @override
  T resolve(Set<VisualState> states) => _resolve(states);
}

class VisualStatePropertyAll<T> implements VisualStateProperty<T> {
  const VisualStatePropertyAll(this.value);
  final T value;
  @override
  T resolve(Set<VisualState> states) => value;
}

class VisualStatesController extends ValueNotifier<Set<VisualState>> {
  VisualStatesController([Set<VisualState>? value]) : super(<VisualState>{...?value});
  void update(VisualState state, bool add) {
    final bool valueChanged = add ? value.add(state) : value.remove(state);
    if (valueChanged) {
      notifyListeners();
    }
  }
}
