import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/borders.dart';
import 'package:design/constants/breakpoints.dart';
import 'package:design/constants/tabs.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/theme/layouts/tab/configuration.dart';
import 'package:design/widgets/layouts/tabs/controller/controller.dart';
import 'package:design/widgets/layouts/tabs/views/segmented.dart';
import 'package:design/model/tabs.dart';
import 'package:design/widgets/primitives/control/control.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

typedef CustomTabBuilder = Widget Function(BuildContext context, bool isSelected);

class TabBar extends StatefulWidget {
  final bool isExpanded;
  final int initialIndex;
  final TabBarDirection direction;
  final Duration? animationDuration;
  final double? gap;
  final double? height;
  final double? width;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final EdgeInsetsGeometry? padding;
  final BreakpointSize? tabBarSize;
  final Decoration? decoration;
  final TabController? tabController;
  final ValueChanged<int>? onTabChanged;
  final List<Tab>? tabs;
  final List<PillTab>? pillTabs;
  final List<CustomTabBuilder>? customTabs;

  const TabBar({
    super.key,
    this.isExpanded = false,
    this.initialIndex = 0,
    this.direction = TabBarDirection.row,
    this.gap,
    this.animationDuration,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.tabBarSize,
    this.decoration,
    this.tabController,
    this.onTabChanged,
    required this.tabs,
  })  : assert(height == null || height > 0),
        assert(tabs != null && tabs.length > 0),
        pillTabs = null,
        customTabs = null;

  const TabBar.pill({
    super.key,
    this.isExpanded = false,
    this.initialIndex = 0,
    this.direction = TabBarDirection.row,
    this.gap,
    this.animationDuration,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.tabBarSize,
    this.decoration,
    this.tabController,
    this.onTabChanged,
    required this.pillTabs,
  })  : assert(height == null || height > 0),
        assert(pillTabs != null && pillTabs.length > 0),
        tabs = null,
        customTabs = null;

  const TabBar.custom({
    super.key,
    this.isExpanded = false,
    this.initialIndex = 0,
    this.direction = TabBarDirection.row,
    this.gap,
    this.animationDuration,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.tabBarSize,
    this.decoration,
    this.tabController,
    this.onTabChanged,
    required this.customTabs,
  })  : assert(height == null || height > 0),
        assert(customTabs != null && customTabs.length > 0),
        tabs = null,
        pillTabs = null;

  @override
  State<TabBar> createState() => _TabBarState();
}

class _TabBarState extends State<TabBar> {
  late int _selectedIndex = widget.tabController?.index ?? widget.initialIndex;
  late TabBarVariant _tabBarVariant;

  late Duration _effectiveTransitionDuration;
  late Curve _effectiveTransitionCurve;
  late TabBarConfiguration _effectiveTabBarConfiguration;

  void _setSelectedTabBarVariant() {
    if (widget.tabs != null) {
      _tabBarVariant = TabBarVariant.indicator;
      return;
    }
    if (widget.pillTabs != null) {
      _tabBarVariant = TabBarVariant.pill;
      return;
    }
    _tabBarVariant = TabBarVariant.custom;
  }

  void _updateTabsSelectedStatus() {
    if (_tabBarVariant == TabBarVariant.indicator) {
      widget.tabs?.asMap().forEach((index, tab) => tab.isSelected?.call(index == _selectedIndex));
      return;
    }
    if (_tabBarVariant == TabBarVariant.pill) {
      widget.pillTabs?.asMap().forEach((index, pillTab) => pillTab.isSelected?.call(index == _selectedIndex));
      return;
    }
  }

  void _handleTabChange() {
    final int animationValue = widget.tabController?.animation?.value.round() ?? 0;
    if (animationValue != _selectedIndex) {
      setState(() {
        _selectedIndex = animationValue;
        widget.onTabChanged?.call(animationValue);
        _updateTabsSelectedStatus();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _setSelectedTabBarVariant();
    _updateTabsSelectedStatus();

    widget.tabController?.animation?.addListener(_handleTabChange);
  }

  List<Widget> _generateTabs() => switch (_tabBarVariant) { TabBarVariant.indicator => _generateIndicatorTabs(), TabBarVariant.pill => _generatePillTabs(), _ => _generateCustomTabs() };

  List<Widget> _generateIndicatorTabs() => List.generate(
        widget.tabs!.length,
        (index) => _IndicatorTabBuilder(
          transitionDuration: _effectiveTransitionDuration,
          transitionCurve: _effectiveTransitionCurve,
          isSelected: index == _selectedIndex,
          barConfiguration: _effectiveTabBarConfiguration,
          tab: widget.tabs![index],
        ),
      );

  List<Widget> _generatePillTabs() => List.generate(
        widget.pillTabs!.length,
        (index) => _PillTabBuilder(
          transitionDuration: _effectiveTransitionDuration,
          transitionCurve: _effectiveTransitionCurve,
          isSelected: index == _selectedIndex,
          barConfiguration: _effectiveTabBarConfiguration,
          tab: widget.pillTabs![index],
        ),
      );

  List<Widget> _generateCustomTabs() => List.generate(
        widget.customTabs!.length,
        (index) => widget.customTabs![index](context, index == _selectedIndex),
      );

  @override
  Widget build(BuildContext context) {
    _effectiveTabBarConfiguration = context.theme.tabBarTheme().configuration.select(widget.tabBarSize);
    _effectiveTransitionDuration = widget.transitionDuration ?? context.theme.tabBarTheme().style.transitionDuration;
    _effectiveTransitionCurve = widget.transitionCurve ?? context.theme.tabBarTheme().style.transitionCurve;
    final effectiveHeight = widget.height ?? (widget.direction == TabBarDirection.column ? double.infinity : _effectiveTabBarConfiguration.height);
    final effectiveGap = widget.gap ?? _effectiveTabBarConfiguration.gap;
    return Container(
      height: effectiveHeight,
      width: widget.width,
      padding: widget.padding,
      decoration: widget.decoration,
      constraints: BoxConstraints(minWidth: effectiveHeight),
      child: BaseSegmentedTabBar(
        gap: effectiveGap,
        animationDuration: widget.animationDuration ?? context.theme.tabBarTheme().style.animationDuration,
        isExpanded: widget.isExpanded,
        initialIndex: widget.initialIndex,
        tabController: widget.tabController,
        direction: widget.direction,
        children: _generateTabs(),
        valueChanged: (newIndex) {
          if (_selectedIndex == newIndex) return;
          if (widget.tabs != null && widget.tabs![newIndex].disabled) return;
          if (widget.pillTabs != null && widget.pillTabs![newIndex].disabled) return;
          setState(() {
            _selectedIndex = newIndex;
            if (widget.tabController == null) {
              widget.onTabChanged?.call(newIndex);
              _updateTabsSelectedStatus();
            }
          });
        },
      ),
    );
  }
}

class _IndicatorTabBuilder extends StatefulWidget {
  final bool isSelected;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final TabBarConfiguration barConfiguration;
  final Tab tab;

  const _IndicatorTabBuilder({
    required this.isSelected,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.barConfiguration,
    required this.tab,
  });

  @override
  State<_IndicatorTabBuilder> createState() => _IndicatorTabBuilderState();
}

class _IndicatorTabBuilderState extends State<_IndicatorTabBuilder> with SingleTickerProviderStateMixin {
  final ColorTween _indicatorColorTween = ColorTween();
  final ColorTween _textColorTween = ColorTween();
  final Tween<double> _indicatorWidthTween = Tween<double>(begin: 0, end: 0);

  Animation<Color?>? _indicatorColor;
  Animation<Color?>? _textColor;
  Animation<double?>? _indicatorWidth;

  AnimationController? _animationController;

  void _handleActiveEffect(bool isActive) => isActive ? _animationController?.forward() : _animationController?.reverse();

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
    final effectiveIndicatorColor = tab.indicatorColor ?? context.theme.tabBarTheme().style.indicatorColor;
    final effectiveTextColor = tab.textStyle?.color ?? tab.textColor ?? context.theme.tabBarTheme().style.segmentTextColor;
    final effectiveSelectedTextColor = tab.selectedTextColor ?? context.theme.tabBarTheme().style.selectedSegmentTextColor;
    final effectiveTextStyle = widget.barConfiguration.textStyle.merge(tab.textStyle);
    final effectiveIndicatorHeight = tab.indicatorHeight ?? widget.barConfiguration.indicatorHeight;
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

    _indicatorColor ??= _animationController!.drive(_indicatorColorTween.chain(CurveTween(curve: widget.transitionCurve)));
    _textColor ??= _animationController!.drive(_textColorTween.chain(CurveTween(curve: widget.transitionCurve)));
    _indicatorWidth ??= _animationController!.drive(_indicatorWidthTween.chain(CurveTween(curve: widget.transitionCurve)));
    _indicatorColorTween.end = effectiveIndicatorColor;

    _textColorTween
      ..begin = effectiveTextColor
      ..end = effectiveSelectedTextColor;

    return BaseControl(
      semanticLabel: widget.tab.semanticLabel,
      onLongPress: widget.tab.disabled ? null : () => {},
      autofocus: widget.tab.autoFocus,
      focusNode: widget.tab.focusNode,
      isFocusable: widget.tab.isFocusable,
      showFocusEffect: widget.tab.showFocusEffect,
      focusEffectColor: tab.focusEffectColor,
      minTouchTargetSize: tab.minTouchTargetSize ?? widget.barConfiguration.minTouchTargetSize,
      cursor: widget.isSelected ? SystemMouseCursors.basic : SystemMouseCursors.click,
      builder: (context, isEnabled, isHovered, isFocused, isPressed) {
        final isActive = isEnabled && (widget.isSelected || isHovered || isPressed);
        _handleActiveEffect(isActive);
        return Container(
          decoration: tab.decoration,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _animationController!,
                builder: (BuildContext context, Widget? child) => IconTheme(
                  data: IconThemeData(
                    color: _textColor!.value,
                    size: widget.barConfiguration.iconSizeValue,
                  ),
                  child: DefaultTextStyle(
                    style: effectiveTextStyle.copyWith(color: _textColor!.value),
                    child: child!,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: correctedTabPadding,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.tab.leading != null)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: effectiveTabGap),
                            child: widget.tab.leading,
                          ),
                        if (widget.tab.label != null)
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: widget.barConfiguration.iconSizeValue),
                            child: Center(child: widget.tab.label),
                          ),
                        if (widget.tab.trailing != null)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: effectiveTabGap),
                            child: widget.tab.trailing,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    _indicatorWidthTween.end = constraints.maxWidth;
                    return Align(
                      alignment: Directionality.of(context) == TextDirection.ltr ? Alignment.bottomLeft : Alignment.bottomRight,
                      child: AnimatedBuilder(
                        animation: _animationController!,
                        builder: (context, child) => Container(
                          color: effectiveIndicatorColor,
                          height: effectiveIndicatorHeight,
                          width: _indicatorWidth!.value,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PillTabBuilder extends StatefulWidget {
  final bool isSelected;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final TabBarConfiguration barConfiguration;
  final PillTab tab;

  const _PillTabBuilder({
    required this.isSelected,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.barConfiguration,
    required this.tab,
  });

  @override
  State<_PillTabBuilder> createState() => _PillTabBuilderState();
}

class _PillTabBuilderState extends State<_PillTabBuilder> with SingleTickerProviderStateMixin {
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
    final effectiveSelectedTabColor = tab.selectedTabColor ?? context.theme.tabBarTheme().style.selectedPillTabColor;
    final effectiveTextColor = tab.textStyle?.color ?? tab.textColor ?? context.theme.tabBarTheme().style.segmentTextColor;
    final effectiveSelectedTextColor = tab.selectedTextColor ?? context.theme.tabBarTheme().style.selectedPillTextColor;
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
      semanticLabel: widget.tab.semanticLabel,
      onLongPress: widget.tab.disabled ? null : () => {},
      autofocus: widget.tab.autoFocus,
      focusNode: widget.tab.focusNode,
      isFocusable: widget.tab.isFocusable,
      showFocusEffect: widget.tab.showFocusEffect,
      minTouchTargetSize: widget.tab.minTouchTargetSize ?? widget.barConfiguration.minTouchTargetSize,
      focusEffectColor: tab.focusEffectColor,
      borderRadius: switch (effectiveTabBorderType) {
        BorderType.squircle => effectiveTabBorderRadius.squircle(context),
        BorderType.rounded => effectiveTabBorderRadius,
      },
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
                    BorderType.rounded => RoundedRectangleBorder(borderRadius: effectiveTabBorderRadius),
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
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
