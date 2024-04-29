import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class Colors implements ThemeComponent<Colors> {
  static const Color transparent = Color(0x00000000);
  static const Color black = Color(0xFF000000);
  static const Color black87 = Color(0xDD000000);
  static const Color black54 = Color(0x8A000000);
  static const Color black45 = Color(0x73000000);
  static const Color black38 = Color(0x61000000);
  static const Color black26 = Color(0x42000000);
  static const Color black12 = Color(0x1F000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color white60 = Color(0x99FFFFFF);
  static const Color white54 = Color(0x8AFFFFFF);
  static const Color white38 = Color(0x62FFFFFF);
  static const Color white30 = Color(0x4DFFFFFF);
  static const Color white24 = Color(0x3DFFFFFF);
  static const Color white12 = Color(0x1FFFFFFF);
  static const Color white10 = Color(0x1AFFFFFF);

  final Color main;
  final Color mainContent;
  final Color mainHover;
  final Color mainHoverContent;
  final Color additional;
  final Color additionalContent;
  final Color additionalHover;
  final Color additionalHoverContent;
  final Color accent;
  final Color accentContent;
  final Color accentHover;
  final Color accentHoverContent;

  final Color contentWeak;
  final Color contentWeakHover;
  final Color contentWeakActive;

  final Color contentMedium;
  final Color contentMediumHover;
  final Color contentMediumActive;

  final Color contentStrong;
  final Color contentStrongHover;
  final Color contentStrongActive;

  final Color layer;
  final Color surface;
  final Color background;
  final Color border;
  final Color overlay;
  final Color active;
  final Color hover;
  final Color scroll;
  final Color focus;

  final Color neutral;
  final Color neutralContent;
  final Color information;
  final Color informationContent;
  final Color success;
  final Color successContent;
  final Color warning;
  final Color warningContent;
  final Color error;
  final Color errorContent;

  const Colors({
    required this.main,
    required this.mainContent,
    required this.mainHover,
    required this.mainHoverContent,
    required this.additional,
    required this.additionalContent,
    required this.additionalHover,
    required this.additionalHoverContent,
    required this.accent,
    required this.accentContent,
    required this.accentHover,
    required this.accentHoverContent,
    required this.contentWeak,
    required this.contentWeakHover,
    required this.contentWeakActive,
    required this.contentMedium,
    required this.contentMediumHover,
    required this.contentMediumActive,
    required this.contentStrong,
    required this.contentStrongHover,
    required this.contentStrongActive,
    required this.layer,
    required this.active,
    required this.hover,
    required this.focus,
    required this.surface,
    required this.background,
    required this.border,
    required this.overlay,
    required this.scroll,
    required this.neutral,
    required this.neutralContent,
    required this.information,
    required this.informationContent,
    required this.success,
    required this.successContent,
    required this.warning,
    required this.warningContent,
    required this.error,
    required this.errorContent,
  });

  @override
  Colors copyWith({
    Color? main,
    Color? mainContent,
    Color? mainHover,
    Color? mainHoverContent,
    Color? additional,
    Color? additionalContent,
    Color? additionalHover,
    Color? additionalHoverContent,
    Color? accent,
    Color? accentContent,
    Color? accentHover,
    Color? accentHoverContent,
    Color? contentWeak,
    Color? contentWeakHover,
    Color? contentWeakActive,
    Color? contentMedium,
    Color? contentMediumHover,
    Color? contentMediumActive,
    Color? contentStrong,
    Color? contentStrongHover,
    Color? contentStrongActive,
    Color? layer,
    Color? surface,
    Color? background,
    Color? border,
    Color? overlay,
    Color? active,
    Color? hover,
    Color? scroll,
    Color? focus,
    Color? neutral,
    Color? neutralContent,
    Color? information,
    Color? informationContent,
    Color? success,
    Color? successContent,
    Color? warning,
    Color? warningContent,
    Color? error,
    Color? errorContent,
  }) =>
      Colors(
        main: main ?? this.main,
        mainContent: mainContent ?? this.mainContent,
        mainHover: mainHover ?? this.mainHover,
        mainHoverContent: mainHoverContent ?? this.mainHoverContent,
        additional: additional ?? this.additional,
        additionalContent: additionalContent ?? this.additionalContent,
        additionalHoverContent: additionalHoverContent ?? this.additionalHoverContent,
        additionalHover: additionalHover ?? this.additionalHover,
        accent: accent ?? this.accent,
        accentContent: accentContent ?? this.accentContent,
        accentHover: accentHover ?? this.accentHover,
        accentHoverContent: accentHoverContent ?? this.accentHoverContent,
        contentWeak: contentWeak ?? this.contentWeak,
        contentWeakHover: contentWeakHover ?? this.contentWeakHover,
        contentWeakActive: contentWeakActive ?? this.contentWeakActive,
        contentMedium: contentMedium ?? this.contentMedium,
        contentMediumHover: contentMediumHover ?? this.contentMediumHover,
        contentMediumActive: contentMediumActive ?? this.contentMediumActive,
        contentStrong: contentStrong ?? this.contentStrong,
        contentStrongHover: contentStrongHover ?? this.contentStrongHover,
        contentStrongActive: contentStrongActive ?? this.contentStrongActive,
        border: border ?? this.border,
        background: background ?? this.background,
        layer: layer ?? this.layer,
        surface: surface ?? this.surface,
        overlay: overlay ?? this.overlay,
        active: active ?? this.active,
        hover: hover ?? this.hover,
        focus: focus ?? this.focus,
        scroll: scroll ?? this.scroll,
        neutral: neutral ?? this.neutral,
        neutralContent: neutralContent ?? this.neutralContent,
        warning: warning ?? this.warning,
        warningContent: warningContent ?? this.warningContent,
        error: error ?? this.error,
        errorContent: errorContent ?? this.errorContent,
        success: success ?? this.success,
        successContent: successContent ?? this.successContent,
        information: information ?? this.information,
        informationContent: informationContent ?? this.informationContent,
      );

  @override
  Colors lerp(Colors? other, double t) {
    if (other is! Colors) return this;
    return Colors(
      main: Color.lerp(main, other.main, t)!,
      mainContent: Color.lerp(mainContent, other.mainContent, t)!,
      mainHover: Color.lerp(mainHover, other.mainHover, t)!,
      mainHoverContent: Color.lerp(mainHoverContent, other.mainHoverContent, t)!,
      additional: Color.lerp(additional, other.additional, t)!,
      additionalContent: Color.lerp(additionalContent, other.additionalContent, t)!,
      additionalHover: Color.lerp(additionalHover, other.additionalHover, t)!,
      additionalHoverContent: Color.lerp(additionalHoverContent, other.additionalHoverContent, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentContent: Color.lerp(accentContent, other.accentContent, t)!,
      accentHover: Color.lerp(accentHover, other.accentHover, t)!,
      accentHoverContent: Color.lerp(accentHoverContent, other.accentHoverContent, t)!,
      contentWeak: Color.lerp(contentWeak, other.contentWeak, t)!,
      contentWeakHover: Color.lerp(contentWeakHover, other.contentWeakHover, t)!,
      contentWeakActive: Color.lerp(contentWeakActive, other.contentWeakActive, t)!,
      contentMedium: Color.lerp(contentMedium, other.contentMedium, t)!,
      contentMediumHover: Color.lerp(contentMediumHover, other.contentMediumHover, t)!,
      contentMediumActive: Color.lerp(contentMediumActive, other.contentMediumActive, t)!,
      contentStrong: Color.lerp(contentStrong, other.contentStrong, t)!,
      contentStrongHover: Color.lerp(contentStrongHover, other.contentStrongHover, t)!,
      contentStrongActive: Color.lerp(contentStrong, other.contentStrong, t)!,
      border: Color.lerp(border, other.border, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      layer: Color.lerp(layer, other.layer, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
      active: Color.lerp(active, other.active, t)!,
      hover: Color.lerp(hover, other.hover, t)!,
      focus: Color.lerp(focus, other.focus, t)!,
      scroll: Color.lerp(scroll, other.scroll, t)!,
      neutral: Color.lerp(neutral, other.neutral, t)!,
      neutralContent: Color.lerp(neutralContent, other.neutralContent, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningContent: Color.lerp(warningContent, other.warningContent, t)!,
      error: Color.lerp(error, other.error, t)!,
      errorContent: Color.lerp(errorContent, other.errorContent, t)!,
      success: Color.lerp(success, other.success, t)!,
      successContent: Color.lerp(successContent, other.successContent, t)!,
      information: Color.lerp(information, other.information, t)!,
      informationContent: Color.lerp(informationContent, other.informationContent, t)!,
    );
  }
}
