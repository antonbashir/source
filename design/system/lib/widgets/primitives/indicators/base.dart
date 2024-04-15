import 'package:flutter/widgets.dart';

abstract class BaseProgressIndicator extends StatefulWidget {
  final Color backgroundColor;
  final Color color;
  final Animation<Color?>? valueColor;
  final double? value;
  final String? semanticsLabel;
  final String? semanticsValue;

  const BaseProgressIndicator({
    super.key,
    required this.backgroundColor,
    required this.color,
    this.valueColor,
    this.value,
    this.semanticsLabel,
    this.semanticsValue,
  });

  Widget buildSemanticsWrapper({required BuildContext context, required Widget child}) {
    String? expandedSemanticsValue = semanticsValue;

    if (value != null) {
      expandedSemanticsValue ??= '${(value! * 100).round()}%';
    }

    return Semantics(
      label: semanticsLabel,
      value: expandedSemanticsValue,
      child: child,
    );
  }
}
