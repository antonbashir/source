part of '../defaults.dart';

final _darkTokens = Tokens(
  borders: _borders,
  opacities: _opacities,
  transitions: _transitions,
  spacings: _spacings,
  palette: _palette,
  shadows: const Shadows(
    small: [
      BoxShadow(
        color: Color(0x8E000000),
        blurRadius: 1,
      ),
      BoxShadow(
        color: Color(0xA3000000),
        blurRadius: 6,
        offset: Offset(0, 6),
        spreadRadius: -6,
      ),
    ],
    medium: [
      BoxShadow(
        color: Color(0x8E000000),
        blurRadius: 1,
      ),
      BoxShadow(
        color: Color(0xA3000000),
        blurRadius: 12,
        offset: Offset(0, 12),
      ),
    ],
    large: [
      BoxShadow(
        color: Color(0x8E000000),
        blurRadius: 1,
      ),
      BoxShadow(
        color: Color(0xA3000000),
        blurRadius: 24,
        offset: Offset(0, 24),
      ),
    ],
    gigantic: [
      BoxShadow(
        color: Color(0xB7000000),
        blurRadius: 1,
      ),
      BoxShadow(
        color: Color(0xE0000000),
        blurRadius: 48,
        offset: Offset(0, 48),
      ),
    ],
  ),
  colors: Colors(
    main: Colors.white,
    mainContent: _neutral.shade900,
    mainHover: Colors.white10,
    mainHoverContent: _neutral.shade800,
    additional: Colors.white,
    additionalContent: _neutral.shade900,
    additionalHover: Colors.white10,
    additionalHoverContent: _neutral.shade800,
    accent: const Color(0xff9822ef),
    accentContent: Colors.white,
    accentHover: Colors.white10,
    accentHoverContent: Colors.white,
    background: const Color(0xff161719),
    surface: const Color(0xff202327),
    layer: const Color(0xff1a1c1e),
    border: _neutral.shade700,
    hover: const Color(0xff36383c),
    focus: _neutral.shade500,
    active: const Color(0xff36383c),
    contentWeak: _gray.shade400,
    contentWeakHover: _gray.shade200,
    contentWeakActive: Colors.white,
    contentMedium: _gray.shade300,
    contentMediumHover: _gray.shade200,
    contentMediumActive: Colors.white,
    contentStrong: Colors.white,
    contentStrongHover: Colors.white,
    contentStrongActive: Colors.white,
    overlay: Colors.black38,
    scroll: const Color(0xff2d2e2f),
    neutral: const Color(0xff202327),
    neutralContent: _gray.shade300,
    information: _sky.shade600,
    informationContent: Colors.white,
    success: _emerald.shade500,
    successContent: Colors.white,
    error: _red.shade600,
    errorContent: _slate.shade700,
    warning: _amber.shade500,
    warningContent: Colors.white,
  ),
  typography: _typography.copyWith(
    base: _typography.base.applyDisplay(color: Colors.white).applyHeadline(color: Colors.white).applyTitle(color: Colors.white).applyBody(color: _gray.shade200).applyLabel(color: _gray.shade300),
    dense: _typography.dense.applyDisplay(color: Colors.white).applyHeadline(color: Colors.white).applyTitle(color: Colors.white).applyBody(color: _gray.shade200).applyLabel(color: _gray.shade300),
    tall: _typography.tall.applyDisplay(color: Colors.white).applyHeadline(color: Colors.white).applyTitle(color: Colors.white).applyBody(color: _gray.shade200).applyLabel(color: _gray.shade300),
  ),
);
