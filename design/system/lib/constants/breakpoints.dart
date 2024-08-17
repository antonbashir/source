extension type const BreakpointSize(String size) {
  static const tiny = BreakpointSize("tiny");
  static const small = BreakpointSize("small");
  static const medium = BreakpointSize("medium");
  static const large = BreakpointSize("large");
  static const gigantic = BreakpointSize("gigantic");
  static const colossal = BreakpointSize("colossal");
  static const all = [
    tiny,
    small,
    medium,
    large,
    gigantic,
    colossal,
  ];
}
