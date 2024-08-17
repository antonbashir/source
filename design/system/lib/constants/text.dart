import 'package:flutter/widgets.dart';

enum TextInputGroupOrientation {
  vertical,
  horizontal,
}

enum AuthenticationCodeFieldShape {
  box,
  underline,
  circle,
}

enum AuthenticationCodeErrorAnimationType {
  nothing,
  shake,
}

const defaultAuthenticationInputFieldCount = 6;
const defaultAuthenticationInputFieldScrollPadding = EdgeInsets.all(24.0);
const defaultTextAreaScrollPadding = EdgeInsets.all(24.0);
const defaultFormTextInputScrollPadding = EdgeInsets.all(20.0);
const defaultTextInputScrollPadding = EdgeInsets.all(20.0);

const textNoMaxLength = -1;
const cursorIOSHorizontalOffset = -2;
