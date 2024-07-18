import 'package:design/constants/platform.dart';
import 'package:design/extensions/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

var _visitedLinks = <Uri>{};

class Link extends StatefulWidget {
  final String text;
  final Uri uri;
  final TextStyle? textStyle;
  final Color? textColor;
  final LaunchMode? openMode;
  final Color? hoverTextColor;
  final bool underlineHover;
  final Color? visitedTextColor;
  final bool underlineVisited;

  const Link({
    super.key,
    required this.text,
    required this.uri,
    this.openMode = LaunchMode.platformDefault,
    this.textColor,
    this.textStyle,
    this.hoverTextColor,
    this.underlineHover = true,
    this.visitedTextColor,
    this.underlineVisited = false,
  });

  @override
  State<Link> createState() => _LinkState();
}

class _LinkState extends State<Link> {
  var _hover = false;
  late var _visited = _visitedLinks.contains(widget.uri);

  @override
  Widget build(BuildContext context) {
    final effectiveTextStyle = widget.textStyle ?? context.typography.base.bodyMedium;
    final effectiveColor = _visited
        ? (widget.visitedTextColor ?? context.colors.accent)
        : _hover
            ? (widget.hoverTextColor ?? context.colors.contentMediumHover)
            : (widget.textColor ?? context.colors.contentMedium);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () {
          setState(() => _visited = true);
          launchUrl(widget.uri).whenComplete(() => _visitedLinks.add(widget.uri));
        },
        onTertiaryTapUp: (_) {
          setState(() => _visited = true);
          launchUrl(widget.uri, webOnlyWindowName: webBlank).whenComplete(() => _visitedLinks.add(widget.uri));
        },
        child: AbsorbPointer(
          child: Text(
            widget.text,
            style: effectiveTextStyle.apply(
              decoration: (widget.underlineVisited && _visited) || (widget.underlineHover && _hover) ? TextDecoration.underline : null,
              decorationColor: effectiveColor,
              color: effectiveColor,
            ),
          ),
        ),
      ),
    );
  }
}
