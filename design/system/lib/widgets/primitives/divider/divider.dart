import 'package:design/extensions/extensions.dart';
import 'package:flutter/widgets.dart';

class HorizontalDivider extends StatelessWidget {
  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  static BorderSide createBorderSide(BuildContext context, {Color? color, double? width}) {
    final effectiveColor = color ?? context.theme.dividerTheme().style.color;
    final effectiveWidth = width ?? context.theme.dividerTheme().configuration.thickness;
    return BorderSide(
      color: effectiveColor,
      width: effectiveWidth,
    );
  }

  const HorizontalDivider({
    super.key,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  })  : assert(height == null || height >= 0.0),
        assert(thickness == null || thickness >= 0.0),
        assert(indent == null || indent >= 0.0),
        assert(endIndent == null || endIndent >= 0.0);

  @override
  Widget build(BuildContext context) {
    final dividerTheme = context.theme.dividerTheme();
    final height = this.height ?? dividerTheme.configuration.width;
    final thickness = this.thickness ?? dividerTheme.configuration.thickness;
    final indent = this.indent ?? dividerTheme.configuration.indent;
    final endIndent = this.endIndent ?? dividerTheme.configuration.endIndent;
    return SizedBox(
      height: height,
      child: Center(
        child: Container(
          height: thickness,
          margin: EdgeInsetsDirectional.only(start: indent, end: endIndent),
          decoration: BoxDecoration(
            border: Border(
              bottom: createBorderSide(context, color: color, width: thickness),
            ),
          ),
        ),
      ),
    );
  }
}

class VerticalDivider extends StatelessWidget {
  final double? width;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  const VerticalDivider({
    super.key,
    this.width,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  })  : assert(width == null || width >= 0.0),
        assert(thickness == null || thickness >= 0.0),
        assert(indent == null || indent >= 0.0),
        assert(endIndent == null || endIndent >= 0.0);

  @override
  Widget build(BuildContext context) {
    final dividerTheme = context.theme.dividerTheme();
    final width = this.width ?? dividerTheme.configuration.width;
    final thickness = this.thickness ?? dividerTheme.configuration.thickness;
    final indent = this.indent ?? dividerTheme.configuration.indent;
    final endIndent = this.endIndent ?? dividerTheme.configuration.endIndent;
    return SizedBox(
      width: width,
      child: Center(
        child: Container(
          width: thickness,
          margin: EdgeInsetsDirectional.only(top: indent, bottom: endIndent),
          decoration: BoxDecoration(
            border: Border(
              left: HorizontalDivider.createBorderSide(context, color: color, width: thickness),
            ),
          ),
        ),
      ),
    );
  }
}
