import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/borders.dart';
import 'package:design/constants/tabs.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/model/tabs.dart';
import 'package:design/theme/layouts/sidebar/sidebar/configuration.dart';
import 'package:design/theme/layouts/sidebar/sidebar/style.dart';
import 'package:design/theme/tokens/colors.dart';
import 'package:design/widgets/layouts/sidebar/drawer.dart';
import 'package:design/widgets/layouts/tabs/views/bar.dart';
import 'package:design/widgets/primitives/control/control.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Sidebar extends StatefulWidget {
  final IndexedWidgetBuilder content;
  final List<SidebarTab> tabs;
  final bool expandedContent;
  final Widget? leading;
  final Widget? trailing;
  final Color? tabBarBackgroundColor;
  final EdgeInsetsGeometry? tabBarPadding;
  final Decoration? tabBarDecoration;
  final Widget? verticalDivider;
  final double? drawerWidth;

  const Sidebar({
    super.key,
    this.expandedContent = false,
    required this.tabs,
    required this.content,
    this.drawerWidth,
    this.verticalDivider,
    this.tabBarBackgroundColor,
    this.tabBarPadding,
    this.tabBarDecoration,
    this.leading,
    this.trailing,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  var _selected = 0;

  @override
  Widget build(BuildContext context) {
    final effectiveConfiguration = context.theme.sidebarTheme().configuration;
    final effectiveStyle = context.theme.sidebarTheme().style;
    final effectiveWidth = widget.drawerWidth ?? context.theme.sidebarTheme().configuration.width;
    final effectiveTabBarPadding = widget.tabBarPadding ?? context.theme.sidebarTheme().configuration.tabBarPadding;
    final effectiveTabBarDecoration = widget.tabBarDecoration ??
        ShapeDecoration(
          shape: switch (effectiveConfiguration.tabBarBorderType) {
            BorderType.squircle => SquircleBorder(
                borderRadius: effectiveConfiguration.tabBarBorderRadius.squircle(context),
                side: BorderSide(color: effectiveStyle.tabBarBorderColor, width: context.borders.borderWidth),
              ),
            BorderType.rounded => RoundedRectangleBorder(
                borderRadius: effectiveConfiguration.tabBarBorderRadius,
                side: BorderSide(color: effectiveStyle.tabBarBorderColor, width: context.borders.borderWidth),
              )
          },
          color: widget.tabBarBackgroundColor ?? effectiveStyle.tabBarBackgroundColor,
        );
    final bar = DecoratedBox(
      decoration: effectiveTabBarDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.leading != null) widget.leading!,
          Expanded(
            child: TabBar.custom(
              padding: effectiveTabBarPadding,
              direction: TabBarDirection.column,
              onTabChanged: (value) => setState(() => _selected = value),
              customTabs: widget.tabs
                  .map(
                    (tab) => (context, isSelected) => _SidebarTabBuilder(
                          isSelected: isSelected,
                          tab: tab,
                          barConfiguration: effectiveConfiguration,
                          barStyle: effectiveStyle,
                          transitionDuration: effectiveStyle.transitionDuration,
                          transitionCurve: effectiveStyle.transitionCurve,
                        ),
                  )
                  .toList(),
            ),
          ),
          if (widget.trailing != null) widget.trailing!
        ],
      ),
    );
    final child = widget.verticalDivider != null
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: bar,
              ),
              widget.verticalDivider!,
            ],
          )
        : bar;
    return Drawer(
      show: true,
      drawerShadows: const [],
      width: effectiveWidth,
      barrierColor: Colors.transparent,
      content: widget.expandedContent ? Expanded(child: widget.content(context, _selected)) : widget.content(context, _selected),
      child: child,
    );
  }
}

class _SidebarTabBuilder extends StatefulWidget {
  final bool isSelected;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final SidebarConfiguration barConfiguration;
  final SidebarStyle barStyle;
  final SidebarTab tab;

  const _SidebarTabBuilder({
    required this.isSelected,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.barConfiguration,
    required this.barStyle,
    required this.tab,
  });

  @override
  State<_SidebarTabBuilder> createState() => _SidebarTabBuilderState();
}

class _SidebarTabBuilderState extends State<_SidebarTabBuilder> with SingleTickerProviderStateMixin {
  final ColorTween _tabColorTween = ColorTween();
  final ColorTween _textColorTween = ColorTween();
  Animation<Color?>? _tabColor;
  Animation<Color?>? _textColor;
  AnimationController? _animationController;

  void _handleActiveEffect(bool isActive) {
    isActive ? _animationController?.forward() : _animationController?.reverse();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: widget.transitionDuration, vsync: this);
    if (widget.isSelected) _animationController?.value = 1;
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tab = widget.tab;
    final effectiveTabBorderType = tab.borderType ?? widget.barConfiguration.borderType;
    final effectiveTabBorderRadius = tab.borderRadius ?? widget.barConfiguration.borderRadius;
    final effectiveSelectedTabColor = tab.selectedTabColor ?? widget.barStyle.selectedTabColor;
    final effectiveTextColor = tab.textStyle?.color ?? tab.textColor ?? widget.barStyle.tabTextColor;
    final effectiveSelectedTextColor = tab.selectedTextColor ?? widget.barStyle.selectedTextColor;
    final effectiveTextStyle = widget.barConfiguration.textStyle.merge(tab.textStyle);
    final effectiveTabGap = tab.gap ?? widget.barConfiguration.tabGap;
    final effectiveTabPadding = tab.padding ?? widget.barConfiguration.tabPadding;
    final resolvedDirectionalPadding = effectiveTabPadding.resolve(Directionality.of(context));
    final correctedTabPadding = tab.padding == null
        ? EdgeInsetsDirectional.fromSTEB(
            widget.tab.leading == null && widget.tab.label != null ? resolvedDirectionalPadding.left : 0,
            resolvedDirectionalPadding.top,
            widget.tab.trailing == null && widget.tab.label != null ? resolvedDirectionalPadding.right : 0,
            resolvedDirectionalPadding.bottom,
          )
        : resolvedDirectionalPadding;

    _tabColor ??= _animationController!.drive(_tabColorTween.chain(CurveTween(curve: widget.transitionCurve)));
    _textColor ??= _animationController!.drive(_textColorTween.chain(CurveTween(curve: widget.transitionCurve)));
    _tabColorTween.end = effectiveSelectedTabColor;

    _textColorTween
      ..begin = effectiveTextColor
      ..end = effectiveSelectedTextColor;

    return BaseControl(
      showUpscaleEffect: true,
      semanticLabel: widget.tab.semanticLabel,
      onLongPress: widget.tab.disabled ? null : () => {},
      autofocus: widget.tab.autoFocus,
      focusNode: widget.tab.focusNode,
      isFocusable: widget.tab.isFocusable,
      showFocusEffect: widget.tab.showFocusEffect,
      minTouchTargetSize: widget.tab.minTouchTargetSize ?? widget.barConfiguration.minTouchTargetSize,
      focusEffectColor: tab.focusEffectColor,
      borderRadius: effectiveTabBorderRadius.squircle(context),
      cursor: widget.isSelected ? SystemMouseCursors.basic : SystemMouseCursors.click,
      builder: (context, isEnabled, isHovered, isFocused, isPressed) {
        final isActive = isEnabled && (widget.isSelected || isHovered || isPressed);
        _handleActiveEffect(isActive);
        return AnimatedBuilder(
          animation: _animationController!,
          builder: (context, child) => DecoratedBox(
            decoration: tab.decoration ??
                ShapeDecoration(
                  color: _tabColor!.value,
                  shape: switch (effectiveTabBorderType) {
                    BorderType.squircle => SquircleBorder(borderRadius: effectiveTabBorderRadius.squircle(context)),
                    BorderType.rounded => RoundedRectangleBorder(borderRadius: effectiveTabBorderRadius.squircle(context)),
                  },
                ),
            child: IconTheme(
              data: IconThemeData(
                size: widget.barConfiguration.iconSizeValue,
                color: _textColor!.value,
              ),
              child: DefaultTextStyle(
                style: effectiveTextStyle.copyWith(color: _textColor!.value),
                child: child!,
              ),
            ),
          ),
          child: Center(
            child: Padding(
              padding: correctedTabPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.tab.leading != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: effectiveTabGap),
                      child: widget.tab.leading,
                    ),
                  if (widget.tab.label != null) widget.tab.label!,
                  if (widget.tab.trailing != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: effectiveTabGap),
                      child: widget.tab.trailing,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
