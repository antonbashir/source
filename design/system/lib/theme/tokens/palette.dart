import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class PaletteColor {
  const PaletteColor(this._swatch);

  final Map<int, Color> _swatch;

  Color get shade50 => this[50]!;
  Color get shade100 => this[100]!;
  Color get shade200 => this[200]!;
  Color get shade300 => this[300]!;
  Color get shade400 => this[400]!;
  Color get shade500 => this[500]!;
  Color get shade600 => this[600]!;
  Color get shade700 => this[700]!;
  Color get shade800 => this[800]!;
  Color get shade900 => this[900]!;
  Color get shade950 => this[950]!;

  Color? operator [](int index) => _swatch[index];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return super == other && other is PaletteColor && mapEquals<int, Color>(other._swatch, _swatch);
  }

  @override
  int get hashCode => Object.hash(runtimeType, _swatch);

  PaletteColor lerp(PaletteColor? other, double t) {
    if (identical(this, other)) {
      return this;
    }

    if (other == null) {
      return PaletteColor(_swatch.map((int key, Color color) => MapEntry<int, Color>(key, Color.lerp(color, null, t)!)));
    }

    return PaletteColor(_swatch.map((int key, Color color) => MapEntry<int, Color>(key, Color.lerp(color, other[key], t)!)));
  }

  PaletteColor copyWith({Map<int, Color>? swatch}) => PaletteColor(swatch ?? _swatch);
}

@immutable
class Palette implements ThemeComponent<Palette> {
  final PaletteColor slate;
  final PaletteColor gray;
  final PaletteColor zinc;
  final PaletteColor neutral;
  final PaletteColor stone;
  final PaletteColor red;
  final PaletteColor orange;
  final PaletteColor amber;
  final PaletteColor yellow;
  final PaletteColor lime;
  final PaletteColor green;
  final PaletteColor emerald;
  final PaletteColor teal;
  final PaletteColor cyan;
  final PaletteColor sky;
  final PaletteColor blue;
  final PaletteColor indigo;
  final PaletteColor violet;
  final PaletteColor purple;
  final PaletteColor fuchsia;
  final PaletteColor pink;
  final PaletteColor rose;

  const Palette({
    required this.slate,
    required this.gray,
    required this.zinc,
    required this.neutral,
    required this.stone,
    required this.red,
    required this.orange,
    required this.amber,
    required this.yellow,
    required this.lime,
    required this.green,
    required this.emerald,
    required this.teal,
    required this.cyan,
    required this.sky,
    required this.blue,
    required this.indigo,
    required this.violet,
    required this.purple,
    required this.fuchsia,
    required this.pink,
    required this.rose,
  });

  @override
  Palette copyWith({
    PaletteColor? slate,
    PaletteColor? gray,
    PaletteColor? zinc,
    PaletteColor? neutral,
    PaletteColor? stone,
    PaletteColor? red,
    PaletteColor? orange,
    PaletteColor? amber,
    PaletteColor? yellow,
    PaletteColor? lime,
    PaletteColor? green,
    PaletteColor? emerald,
    PaletteColor? teal,
    PaletteColor? cyan,
    PaletteColor? sky,
    PaletteColor? blue,
    PaletteColor? indigo,
    PaletteColor? violet,
    PaletteColor? purple,
    PaletteColor? fuchsia,
    PaletteColor? pink,
    PaletteColor? rose,
  }) =>
      Palette(
        slate: slate ?? this.slate,
        gray: gray ?? this.gray,
        zinc: zinc ?? this.zinc,
        neutral: neutral ?? this.neutral,
        stone: stone ?? this.stone,
        red: red ?? this.red,
        orange: orange ?? this.orange,
        amber: amber ?? this.amber,
        yellow: yellow ?? this.yellow,
        lime: lime ?? this.lime,
        green: green ?? this.green,
        emerald: emerald ?? this.emerald,
        teal: teal ?? this.teal,
        cyan: cyan ?? this.cyan,
        sky: sky ?? this.sky,
        blue: blue ?? this.blue,
        indigo: indigo ?? this.indigo,
        violet: violet ?? this.violet,
        purple: purple ?? this.purple,
        fuchsia: fuchsia ?? this.fuchsia,
        pink: pink ?? this.pink,
        rose: rose ?? this.rose,
      );

  @override
  Palette lerp(covariant Palette? other, double t) {
    if (identical(this, other)) {
      return this;
    }

    if (other == null) {
      return Palette(
        slate: slate.lerp(null, t),
        gray: gray.lerp(null, t),
        zinc: zinc.lerp(null, t),
        neutral: neutral.lerp(null, t),
        stone: stone.lerp(null, t),
        red: red.lerp(null, t),
        orange: orange.lerp(null, t),
        amber: amber.lerp(null, t),
        yellow: yellow.lerp(null, t),
        lime: lime.lerp(null, t),
        green: green.lerp(null, t),
        emerald: emerald.lerp(null, t),
        teal: teal.lerp(null, t),
        cyan: cyan.lerp(null, t),
        sky: sky.lerp(null, t),
        blue: blue.lerp(null, t),
        indigo: indigo.lerp(null, t),
        violet: violet.lerp(null, t),
        purple: purple.lerp(null, t),
        fuchsia: fuchsia.lerp(null, t),
        pink: pink.lerp(null, t),
        rose: rose.lerp(null, t),
      );
    }

    return Palette(
      slate: slate.lerp(other.slate, t),
      gray: gray.lerp(other.gray, t),
      zinc: zinc.lerp(other.zinc, t),
      neutral: neutral.lerp(other.neutral, t),
      stone: stone.lerp(other.stone, t),
      red: red.lerp(other.red, t),
      orange: orange.lerp(other.orange, t),
      amber: amber.lerp(other.amber, t),
      yellow: yellow.lerp(other.yellow, t),
      lime: lime.lerp(other.lime, t),
      green: green.lerp(other.green, t),
      emerald: emerald.lerp(other.emerald, t),
      teal: teal.lerp(other.teal, t),
      cyan: cyan.lerp(other.cyan, t),
      sky: sky.lerp(other.sky, t),
      blue: blue.lerp(other.blue, t),
      indigo: indigo.lerp(other.indigo, t),
      violet: violet.lerp(other.violet, t),
      purple: purple.lerp(other.purple, t),
      fuchsia: fuchsia.lerp(other.fuchsia, t),
      pink: pink.lerp(other.pink, t),
      rose: rose.lerp(other.rose, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return super == other &&
        other is Palette &&
        listEquals(
          [
            slate,
            gray,
            zinc,
            neutral,
            stone,
            red,
            orange,
            amber,
            yellow,
            lime,
            green,
            emerald,
            teal,
            cyan,
            sky,
            blue,
            indigo,
            violet,
            purple,
            fuchsia,
            pink,
            rose,
          ],
          [
            other.slate,
            other.gray,
            other.zinc,
            other.neutral,
            other.stone,
            other.red,
            other.orange,
            other.amber,
            other.yellow,
            other.lime,
            other.green,
            other.emerald,
            other.teal,
            other.cyan,
            other.sky,
            other.blue,
            other.indigo,
            other.violet,
            other.purple,
            other.fuchsia,
            other.pink,
            other.rose,
          ],
        );
  }

  @override
  int get hashCode => Object.hashAll([
        slate,
        gray,
        zinc,
        neutral,
        stone,
        red,
        orange,
        amber,
        yellow,
        lime,
        green,
        emerald,
        teal,
        cyan,
        sky,
        blue,
        indigo,
        violet,
        purple,
        fuchsia,
        pink,
        rose,
      ]);
}
