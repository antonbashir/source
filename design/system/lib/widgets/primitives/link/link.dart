import 'package:design/extensions/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class Link extends StatefulWidget {
  static final _tracked = <Uri>{};

  final String text;
  final Uri uri;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? activeTextColor;
  final Color? hoverTextColor;
  final LaunchMode? openMode;
  final bool active;
  final bool track;
  final bool underlineActive;

  const Link({
    super.key,
    required this.text,
    required this.uri,
    this.openMode = LaunchMode.platformDefault,
    this.textColor,
    this.textStyle,
    this.hoverTextColor,
    this.activeTextColor,
    this.active = false,
    this.track = true,
    this.underlineActive = true,
  });

  @override
  State<Link> createState() => _LinkState();
}

class _LinkState extends State<Link> {
  var _hover = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.active || (widget.track && Link._tracked.contains(widget.uri));
    final effectiveTextStyle = widget.textStyle ?? context.typography.base.bodyMedium;
    final effectiveColor = active
        ? (widget.textColor ?? context.colors.accent)
        : _hover
            ? (widget.hoverTextColor ?? context.colors.contentMedium)
            : (widget.textColor ?? context.colors.contentMediumHover);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => launchUrl(widget.uri).whenComplete(() => setState(() => Link._tracked.add(widget.uri))),
        onTertiaryTapUp: (_) => launchUrl(widget.uri).whenComplete(() => setState(() => Link._tracked.add(widget.uri))),
        child: AbsorbPointer(
          child: Text(
            widget.text,
            style: effectiveTextStyle.apply(
              decoration: (widget.underlineActive && active) ? TextDecoration.underline : null,
              decorationColor: effectiveColor,
              color: effectiveColor,
            ),
          ),
        ),
      ),
    );
  }
}
