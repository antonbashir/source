import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:design/borders/squircle/border_radius.dart';
import 'package:design/borders/squircle/radius.dart';
import 'package:design/constants/constants.dart';
import 'package:design/constants/dates.dart';
import 'package:design/theme/theme.dart';
import 'package:design/theme/tokens/borders.dart';
import 'package:design/theme/tokens/colors.dart';
import 'package:design/theme/tokens/opacities.dart';
import 'package:design/theme/tokens/palette.dart';
import 'package:design/theme/tokens/shadows.dart';
import 'package:design/theme/tokens/spacings.dart';
import 'package:design/theme/tokens/tokens.dart';
import 'package:design/theme/tokens/transitions.dart';
import 'package:design/theme/typography/typography.dart';
import 'package:design/widgets/theme/theme.dart';
import 'package:flutter/widgets.dart';

extension DateTimeExtensions on DateTime {
  String formatFull() => fullFormatter.format(toLocal());

  String formatDate() => dateFormatter.format(toLocal());

  String formatTime() => timeFormatter.format(toLocal());
}

extension StringExtensions on String {
  String reformat() => fullFormatter.format(DateTime.parse(this).toLocal());

  String reformatDate() => dateFormatter.format(DateTime.parse(this).toLocal());

  String reformatTime() => timeFormatter.format(DateTime.parse(this).toLocal());

  DateTime? parseUtc() => DateTime.tryParse(this)?.toUtc();
}

extension StringNullableExtensions on String? {
  bool get isEmpty => this == null || this! == empty;

  bool get isNotEmpty => this != null && this! != empty;
}

extension ListNullableExtensions<T> on List<T>? {
  bool get isEmpty => this == null || this!.isEmpty;

  bool get isNotEmpty => this != null && this!.isNotEmpty;
}

extension SetExtensions<T> on Set<T> {
  Set<T> copyRemove(T element) => where((current) => current != element).toSet();

  Set<T> copyAdd(T element) => {...this, element};

  Set<T> copyUpdate(T? from, T to) {
    remove(from);
    return copyAdd(to);
  }
}

extension MapExtensions<K, V> on Map<K, V>? {
  Map<K, V> copyAdd(K key, V value) => {...this ?? {}, key: value};

  Map<K, V> copyUpdate(K key, V value) {
    final currentValue = (this ?? {})[key];
    if (currentValue == null) return this ?? {};
    return copyAdd(key, value);
  }

  Map<K, V> copyReplaceKey(K key, K newKey) {
    if (key == newKey) return {...this ?? {}};
    final self = (this ?? {});
    final currentValue = self[key];
    if (currentValue == null) return this ?? {};
    return copyAdd(newKey, currentValue)..remove(key);
  }

  Map<K, V> copyReplaceValue(K key, K newKey, V newValue) {
    if (key == newKey) return copyUpdate(key, newValue);
    return copyAdd(newKey, newValue)..remove(key);
  }

  Map<K, V> copyModify(K key, V Function(V value) current) {
    final currentValue = (this ?? {})[key];
    if (currentValue == null) return this ?? {};
    return copyAdd(key, current(currentValue));
  }

  Map<K, V> copyRemove(K key) => {...this ?? {}}..removeWhere((checkingKey, value) => checkingKey == key);

  Map<K, T> mapValues<T>(T Function(K key, V value) mapper) => (this ?? {}).map((K key, V value) => MapEntry<K, T>(key, mapper(key, value)));

  Map<T, V> mapKeys<T>(T Function(K key, V value) mapper) => (this ?? {}).map((K key, V value) => MapEntry<T, V>(mapper(key, value), value));
}

extension ListExtensions<T> on List<T> {
  List<T> copyAdd(T element) => [...this, element];

  List<T> copyUpdate(T from, T to) => toSet().copyUpdate(from, to).toList();

  List<O> mapIndexed<O>(O Function(int index, T element) callback) {
    var index = 0;
    final returnList = <O>[];
    for (var element in this) {
      returnList.add(callback(index++, element));
    }
    return returnList;
  }

  List<T> copyRemove(T element) => where((current) => current != element).toList();
}

extension IterableExtensions<T extends num> on Iterable<T> {
  T sum() => reduce((value, element) => (value + element) as T);
  T max() => reduce((value, element) => (value > element) ? value : element);
  T min() => reduce((value, element) => (value < element) ? value : element);
}

extension NullableExtensions<T> on T? {
  R? let<R>(R Function(T) action) {
    if (this != null) return action(this as T);
    return null;
  }
}

extension FutureExtensions<T> on Future<T> {
  Future<T> consumeError(void Function(dynamic error, StackTrace? stack) onError) => catchError((error, stack) {
        onError(error, stack);
        return this;
      });
}

extension BuildContextExtensions on BuildContext {
  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

extension BorderRadiusGeometryExtensions on BorderRadiusGeometry {
  SquircleBorderRadius squircle(BuildContext context) {
    final borderRadius = resolve(Directionality.of(context));
    return SquircleBorderRadius.only(
      topLeft: SquircleRadius(cornerRadius: borderRadius.topLeft.x),
      topRight: SquircleRadius(cornerRadius: borderRadius.topRight.x),
      bottomLeft: SquircleRadius(cornerRadius: borderRadius.bottomLeft.x),
      bottomRight: SquircleRadius(cornerRadius: borderRadius.bottomRight.x),
    );
  }
}

extension BytesExtension on Uint8List {
  double brightness() {
    var totalScore = 0.0;
    for (int i = 0; i < length; i += 4) {
      final r = this[i];
      final g = this[i + 1];
      final b = this[i + 2];
      final a = this[i + 3];
      final brightness = 0.2126 * r + 0.7152 * g + 0.0722 * b;
      final normalized = (brightness / 127.5 - 1) * (a / 255);
      totalScore += normalized;
    }
    return totalScore;
  }
}

extension ThemeExtensions on BuildContext {
  ThemeConfiguration get theme => Theme.of(this);
  Tokens get tokens => theme.tokens;
  Borders get borders => tokens.borders;
  Palette get palette => tokens.palette;
  Colors get colors => tokens.colors;
  Opacities get opacities => tokens.opacities;
  Shadows get shadows => tokens.shadows;
  Spacings get spacings => tokens.spacings;
  Transitions get transitions => tokens.transitions;
  Typography get typography => tokens.typography;
}
