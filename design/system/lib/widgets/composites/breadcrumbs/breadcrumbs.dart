import 'package:design/constants/constants.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/model/breadcrumb.dart';
import 'package:design/widgets/primitives/control/control.dart';
import 'package:design/widgets/icons/icons.dart';
import 'package:flutter/widgets.dart';

class Breadcrumbs extends StatefulWidget {
  final List<BreadcrumbItem> items;
  final Color? dividerColor;
  final Color? hoverEffectColor;
  final BoxDecoration? itemDecoration;
  final double? gap;
  final EdgeInsetsGeometry? padding;
  final int? visibleItemCount;
  final String? semanticLabel;
  final TextStyle? itemTextStyle;
  final TextStyle? currentItemTextStyle;
  final Widget? divider;
  final Widget? showMoreWidget;
  final double? showMoreItemsTextSize;

  const Breadcrumbs({
    super.key,
    required this.items,
    this.dividerColor,
    this.hoverEffectColor,
    this.itemDecoration,
    this.gap,
    this.padding,
    this.visibleItemCount,
    this.semanticLabel,
    this.itemTextStyle,
    this.currentItemTextStyle,
    this.divider,
    this.showMoreWidget,
    this.showMoreItemsTextSize,
  });

  @override
  State<Breadcrumbs> createState() => _BreadcrumbsState();
}

class _BreadcrumbsState extends State<Breadcrumbs> {
  bool showFullPath = false;

  List<Widget> _buildItems() {
    final theme = context.theme.breadcrumbsTheme();
    final effectiveGap = widget.gap ?? theme.configuration.gap;
    final effectiveItemTextColor = widget.itemTextStyle?.color ?? theme.style.itemColor;
    final effectiveCurrentItemTextColor = widget.currentItemTextStyle?.color ?? theme.style.currentItemColor;
    final effectiveHoverEffectColor = widget.hoverEffectColor ?? theme.style.hoverEffectColor;
    final effectiveItemTextStyle = widget.itemTextStyle ?? theme.configuration.itemTextStyle;
    final effectiveCurrentItemTextStyle = widget.currentItemTextStyle ?? theme.configuration.currentItemTextStyle;
    final effectiveShowMoreItemTextStyle = theme.configuration.showMoreItemTextStyle;
    final effectiveTransitionDuration = theme.style.transitionDuration;
    final effectiveTransitionCurve = theme.style.transitionCurve;
    final effectiveShowMoreItemsTextSize = widget.showMoreItemsTextSize ?? theme.configuration.showMoreItemsTextSize;
    final resolvedItemCountToShow = showFullPath ? widget.items.length : widget.visibleItemCount ?? context.theme.breadcrumbsTheme().configuration.visibleItems;
    final visibleItemsList = _getVisibleItems();
    final customizedVisibleItemsList = visibleItemsList
        .map(
          (item) => Row(
            children: [
              if (item != visibleItemsList.first) SizedBox(width: effectiveGap),
              _BreadcrumbItemBuilder(
                isCurrent: item == visibleItemsList.last,
                itemColor: effectiveItemTextColor,
                currentItemColor: effectiveCurrentItemTextColor,
                hoverEffectColor: effectiveHoverEffectColor,
                decoration: widget.itemDecoration,
                itemTextStyle: effectiveItemTextStyle,
                currentItemTextStyle: effectiveCurrentItemTextStyle,
                transitionDuration: effectiveTransitionDuration,
                transitionCurve: effectiveTransitionCurve,
                onTap: item.onTap,
                item: item,
              ),
              if (item != visibleItemsList.last) ...[
                SizedBox(width: effectiveGap),
                _buildDivider(),
              ],
            ],
          ),
        )
        .toList();

    if (widget.items.length > resolvedItemCountToShow && resolvedItemCountToShow > 1) {
      customizedVisibleItemsList.insert(
        1,
        Row(
          children: [
            widget.showMoreWidget ??
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                  child: _BreadcrumbItemBuilder(
                    isCurrent: false,
                    itemColor: effectiveItemTextColor,
                    currentItemColor: effectiveCurrentItemTextColor,
                    hoverEffectColor: effectiveHoverEffectColor,
                    decoration: widget.itemDecoration,
                    itemTextStyle: effectiveItemTextStyle,
                    currentItemTextStyle: effectiveCurrentItemTextStyle,
                    transitionDuration: effectiveTransitionDuration,
                    transitionCurve: effectiveTransitionCurve,
                    onTap: () => setState(() => showFullPath = true),
                    item: BreadcrumbItem(
                      semanticLabel: widget.semanticLabel,
                      label: SizedBox(
                        width: effectiveShowMoreItemsTextSize,
                        child: Text(
                          threeDots,
                          textAlign: TextAlign.center,
                          style: effectiveShowMoreItemTextStyle.apply(color: effectiveItemTextColor),
                        ),
                      ),
                    ),
                  ),
                ),
            _buildDivider(),
          ],
        ),
      );
    }

    showFullPath = false;

    return customizedVisibleItemsList;
  }

  List<BreadcrumbItem> _getVisibleItems() {
    final resolvedItemCountToShow = showFullPath ? widget.items.length : widget.visibleItemCount ?? context.theme.breadcrumbsTheme().configuration.visibleItems;

    final List<BreadcrumbItem> visibleItems = resolvedItemCountToShow == 0
        ? []
        : widget.items.length > resolvedItemCountToShow
            ? [
                widget.items[0],
                ...List.generate(resolvedItemCountToShow - 1, (index) => widget.items.length - index).reversed.map((int index) => widget.items[index - 1]),
              ]
            : widget.items;

    return visibleItems;
  }

  Widget _buildDivider() => IconTheme(
        data: IconThemeData(color: widget.dividerColor ?? widget.itemTextStyle?.color ?? context.theme.breadcrumbsTheme().style.itemColor),
        child: widget.divider ??
            Icon(
              Directionality.of(context) == TextDirection.ltr ? Icons.arrow_right : Icons.arrow_left,
              size: context.theme.breadcrumbsTheme().configuration.iconSize,
            ),
      );

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: widget.padding,
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: _buildItems(),
        ),
      );
}

class _BreadcrumbItemBuilder extends StatefulWidget {
  final bool isCurrent;
  final Color itemColor;
  final Color currentItemColor;
  final Color hoverEffectColor;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final TextStyle itemTextStyle;
  final TextStyle currentItemTextStyle;
  final BreadcrumbItem item;
  final BoxDecoration? decoration;
  final VoidCallback? onTap;

  const _BreadcrumbItemBuilder({
    required this.isCurrent,
    required this.itemColor,
    required this.currentItemColor,
    required this.hoverEffectColor,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.itemTextStyle,
    required this.currentItemTextStyle,
    required this.item,
    this.onTap,
    this.decoration,
  });

  @override
  State<_BreadcrumbItemBuilder> createState() => _BreadCrumbItemBuilderState();
}

class _BreadCrumbItemBuilderState extends State<_BreadcrumbItemBuilder> with SingleTickerProviderStateMixin {
  final ColorTween _itemColorTween = ColorTween();

  Animation<Color?>? _itemColor;
  AnimationController? _animationController;

  void _handleActiveEffect(bool isActive) {
    isActive ? _animationController?.forward() : _animationController?.reverse();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: widget.transitionDuration, vsync: this);
    if (widget.isCurrent) _animationController?.value = 1;
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveGap = widget.item.gap ?? context.theme.breadcrumbsTheme().configuration.itemGap;
    final effectiveMinTargetSize = widget.item.minTouchTargetSize ?? context.theme.breadcrumbsTheme().configuration.minTouchTargetSize;
    final resolvedItemColor = widget.isCurrent ? widget.currentItemColor : widget.itemColor;
    final resolvedHoverEffectColor = widget.isCurrent ? widget.currentItemColor : widget.hoverEffectColor;
    final resolvedTextStyle = widget.isCurrent ? widget.currentItemTextStyle : widget.itemTextStyle;

    _itemColor ??= _animationController!.drive(
      _itemColorTween.chain(CurveTween(curve: widget.transitionCurve)),
    );

    _itemColorTween
      ..begin = resolvedItemColor
      ..end = resolvedHoverEffectColor;

    return BaseControl(
      semanticLabel: widget.item.semanticLabel,
      backgroundColor: widget.decoration?.color,
      borderRadius: widget.decoration?.borderRadius,
      onTap: widget.onTap,
      minTouchTargetSize: effectiveMinTargetSize,
      builder: (context, isEnabled, isHovered, isFocused, isPressed) {
        final isActive = isEnabled && (widget.isCurrent || isHovered || isPressed);
        _handleActiveEffect(isActive);
        return AnimatedBuilder(
          animation: _animationController!,
          builder: (context, child) => IconTheme(
            data: IconThemeData(
              color: _itemColor!.value,
            ),
            child: DefaultTextStyle(
              style: resolvedTextStyle.copyWith(color: _itemColor?.value),
              child: child!,
            ),
          ),
          child: DecoratedBox(
            decoration: widget.decoration ?? const BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (widget.item.leading != null) ...[
                  widget.item.leading!,
                  SizedBox(width: effectiveGap),
                ],
                widget.item.label,
                if (widget.item.trailing != null) ...[
                  SizedBox(width: effectiveGap),
                  widget.item.trailing!,
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
