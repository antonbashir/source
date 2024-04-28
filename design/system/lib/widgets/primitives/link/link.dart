import 'package:design/constants/web.dart';
import 'package:design/extensions/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class Link extends StatefulWidget {
  final String text;
  final Uri uri;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? hoverTextColor;
  final LaunchMode? openMode;
  final bool underlineHover;

  const Link({
    super.key,
    required this.text,
    required this.uri,
    this.openMode = LaunchMode.platformDefault,
    this.textColor,
    this.textStyle,
    this.hoverTextColor,
    this.underlineHover = true,
  });

  @override
  State<Link> createState() => _LinkState();
}

class _LinkState extends State<Link> {
  var _hover = false;

  @override
  Widget build(BuildContext context) {
    final effectiveTextStyle = widget.textStyle ?? context.typography.base.bodyMedium;
    final effectiveColor = _hover ? (widget.hoverTextColor ?? context.colors.accent) : (widget.textColor ?? context.colors.contentMedium);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => launchUrl(widget.uri),
        onTertiaryTapUp: (_) => launchUrl(widget.uri, webOnlyWindowName: webBlank),
        child: AbsorbPointer(
          child: Text(
            widget.text,
            style: effectiveTextStyle.apply(
              decoration: (widget.underlineHover && _hover) ? TextDecoration.underline : null,
              decorationColor: effectiveColor,
              color: effectiveColor,
            ),
          ),
        ),
      ),
    );
  }
}
