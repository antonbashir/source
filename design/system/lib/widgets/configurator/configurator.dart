import 'package:design/constants/theme.dart';
import 'package:design/constants/titles.dart';
import 'package:design/constants/typography.dart';
import 'package:design/constants/platform.dart';
import 'package:design/defaults/defaults.dart';
import 'package:design/theme/theme.dart';
import 'package:design/widgets/errors/handler.dart';
import 'package:design/widgets/scrollbar/scrollbar.dart';
import 'package:design/widgets/theme/theme.dart';
import 'package:design/widgets/views/popover/popover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_strategy/url_strategy.dart';

class RoutingConfiguration {
  final RouterConfig<Object>? configuration;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;

  RoutingConfiguration.configured(this.configuration)
      : routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        backButtonDispatcher = null;

  RoutingConfiguration.custom({
    required this.routerDelegate,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.backButtonDispatcher,
  }) : configuration = null;
}

class NavigatingConfiguration {
  final Widget? home;
  final String? initialRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onGenerateRoute;
  final Map<String, WidgetBuilder>? routes;
  final RouteFactory? onUnknownRoute;
  final GlobalKey<NavigatorState>? navigatorKey;
  final NotificationListenerCallback<NavigationNotification>? onNavigationNotification;
  final List<NavigatorObserver>? navigatorObservers;

  NavigatingConfiguration({
    this.home,
    this.initialRoute,
    this.onGenerateInitialRoutes,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.routes,
    this.navigatorKey,
    this.onNavigationNotification,
    this.navigatorObservers,
  });
}

class StylingConfiguration {
  final ThemeMode themeMode;
  final ThemeConfiguration lightTheme;
  final ThemeConfiguration darkTheme;
  final GenerateAppTitle title;
  final Color systemColor;

  StylingConfiguration({
    this.themeMode = ThemeMode.system,
    ThemeConfiguration? lightTheme,
    ThemeConfiguration? darkTheme,
    GenerateAppTitle? title,
    Color? systemColor,
  })  : lightTheme = lightTheme ?? Defaults.lightTheme,
        darkTheme = darkTheme ?? Defaults.darkTheme,
        title = title ?? ((_) => defaultTitle),
        systemColor = systemColor ?? Defaults.lightTokens.colors.main;
}

class ActionsConfiguration {
  final bool enableSelection;
  final Map<ShortcutActivator, Intent> shortcuts;
  final Map<Type, Action<Intent>> actions;

  ActionsConfiguration({this.enableSelection = true, Map<ShortcutActivator, Intent>? shortcuts, Map<Type, Action<Intent>>? actions})
      : shortcuts = {...shortcuts ?? {}, ...WidgetsApp.defaultShortcuts},
        actions = {...actions ?? {}, ...WidgetsApp.defaultActions};

  ActionsConfiguration.overrideShortcuts({this.enableSelection = true, required this.shortcuts, Map<Type, Action<Intent>>? actions}) : actions = actions ?? WidgetsApp.defaultActions;
  ActionsConfiguration.overrideActions({this.enableSelection = true, Map<ShortcutActivator, Intent>? shortcuts, required this.actions}) : shortcuts = shortcuts ?? WidgetsApp.defaultShortcuts;
  ActionsConfiguration.override({this.enableSelection = true, required this.shortcuts, required this.actions});
}

class ScrollingConfiguration {
  final ScrollBehavior behavior;

  ScrollingConfiguration({ScrollBehavior? behavior}) : behavior = behavior ?? const _DefaultScrollBehavior();
}

class LocalizationConfiguration {
  final Locale locale;
  final Iterable<Locale> supported;
  final Iterable<LocalizationsDelegate<dynamic>>? delegates;
  final LocaleListResolutionCallback? listResolutionCallback;
  final LocaleResolutionCallback? singleResolutionCallback;

  LocalizationConfiguration({
    this.locale = Defaults.locale,
    this.supported = Defaults.supportedLocales,
    this.delegates = const [
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    this.listResolutionCallback,
    this.singleResolutionCallback,
  });
}

class ErrorsConfiguration {
  final void Function(dynamic error, StackTrace? stack) handler;
  final bool handleWidgetErrors;

  ErrorsConfiguration({
    void Function(dynamic error, StackTrace? stack)? handler,
    this.handleWidgetErrors = false,
  }) : handler = handler ?? ((error, stack) {});
}

class WebConfiguration {
  final UrlStrategy urlStrategy;

  WebConfiguration({
    this.urlStrategy = UrlStrategy.unspecified,
  });
}

class Configurator extends StatefulWidget {
  final StylingConfiguration stylingConfiguration;
  final ScrollingConfiguration scrollingConfiguration;
  final LocalizationConfiguration localizationConfiguration;
  final ActionsConfiguration actionsConfiguration;
  final ErrorsConfiguration errorsConfiguration;
  final WebConfiguration webConfiguration;
  final RoutingConfiguration? routingConfiguration;
  final NavigatingConfiguration? navigatingConfiguration;
  final TransitionBuilder? builder;
  late final ValueNotifier<ThemeMode> themeModeChanger = ValueNotifier(stylingConfiguration.themeMode);
  late final ValueNotifier<ThemeConfiguration?> themeChanger = ValueNotifier(null);
  final Widget Function(Configurator configurator)? wrapper;

  static Configurator of(BuildContext context) => context.findAncestorWidgetOfExactType<Configurator>()!;

  static void switchTheme(BuildContext context) {
    final configurator = Configurator.of(context);
    final theme = Theme.of(context);
    configurator.themeModeChanger.value = theme.brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
  }

  static void overrideTheme(BuildContext context, ThemeConfiguration Function(ThemeConfiguration current) override) {
    final configurator = Configurator.of(context);
    configurator.themeChanger.value = override(Theme.of(context)).copyWith();
  }

  Configurator.navigable({
    super.key,
    required this.navigatingConfiguration,
    this.builder,
    this.wrapper,
    ActionsConfiguration? actionsConfiguration,
    StylingConfiguration? stylingConfiguration,
    ScrollingConfiguration? scrollingConfiguration,
    LocalizationConfiguration? localizationConfiguration,
    ErrorsConfiguration? errorsConfiguration,
    WebConfiguration? webConfiguration,
  })  : routingConfiguration = null,
        actionsConfiguration = actionsConfiguration ?? ActionsConfiguration(),
        errorsConfiguration = errorsConfiguration ?? ErrorsConfiguration(),
        stylingConfiguration = stylingConfiguration ?? StylingConfiguration(),
        localizationConfiguration = localizationConfiguration ?? LocalizationConfiguration(),
        webConfiguration = webConfiguration ?? WebConfiguration(),
        scrollingConfiguration = scrollingConfiguration ?? ScrollingConfiguration() {
    _launch();
  }

  Configurator.routable({
    super.key,
    required this.routingConfiguration,
    this.builder,
    this.wrapper,
    ActionsConfiguration? actionsConfiguration,
    StylingConfiguration? stylingConfiguration,
    ScrollingConfiguration? scrollingConfiguration,
    LocalizationConfiguration? localizationConfiguration,
    ErrorsConfiguration? errorsConfiguration,
    WebConfiguration? webConfiguration,
  })  : navigatingConfiguration = null,
        actionsConfiguration = actionsConfiguration ?? ActionsConfiguration(),
        errorsConfiguration = errorsConfiguration ?? ErrorsConfiguration(),
        stylingConfiguration = stylingConfiguration ?? StylingConfiguration(),
        localizationConfiguration = localizationConfiguration ?? LocalizationConfiguration(),
        webConfiguration = webConfiguration ?? WebConfiguration(),
        scrollingConfiguration = scrollingConfiguration ?? ScrollingConfiguration() {
    _launch();
  }

  @override
  State<Configurator> createState() => _ConfiguratorState();

  void _launch() {
    WidgetsFlutterBinding.ensureInitialized();
    switch (webConfiguration.urlStrategy) {
      case UrlStrategy.path:
        setPathUrlStrategy();
        break;
      case UrlStrategy.hash:
        setHashUrlStrategy();
        break;
      default:
        break;
    }
    runApp(wrapper?.call(this) ?? this);
  }
}

class _ConfiguratorState extends State<Configurator> {
  late var themeMode = widget.stylingConfiguration.themeMode;
  late var theme = (themeMode == ThemeMode.dark || (themeMode == ThemeMode.system && MediaQuery.platformBrightnessOf(context) == Brightness.dark))
      ? widget.stylingConfiguration.darkTheme
      : widget.stylingConfiguration.lightTheme;

  @override
  void initState() {
    super.initState();
    widget.themeChanger.addListener(_overrideTheme);
    widget.themeModeChanger.addListener(_switchTheme);
  }

  void _switchTheme() {
    if (widget.themeModeChanger.value == ThemeMode.light) {
      setState(() {
        themeMode = ThemeMode.light;
        theme = widget.stylingConfiguration.lightTheme.copyWith();
      });
      return;
    }
    if (widget.themeModeChanger.value == ThemeMode.dark) {
      setState(() {
        themeMode = ThemeMode.dark;
        theme = widget.stylingConfiguration.darkTheme.copyWith();
      });
      return;
    }
  }

  void _overrideTheme() {
    if (widget.themeChanger.value != null) {
      setState(() => theme = widget.themeChanger.value!);
    }
  }

  Widget _builder(BuildContext context, Widget? child) {
    final effectiveSelectionColor = theme.textSelectionTheme().selectionColor;
    final effectiveCursorColor = theme.textSelectionTheme().cursorColor;

    Widget childWidget = child ?? const SizedBox.shrink();
    if (widget.builder != null) {
      childWidget = Builder(builder: (context) => widget.builder!(context, child));
    }

    childWidget = Theme(
      configuration: theme,
      child: childWidget,
    );

    return DefaultSelectionStyle(
      selectionColor: effectiveSelectionColor,
      cursorColor: effectiveCursorColor,
      child: childWidget,
    );
  }

  Widget _buildApplication(BuildContext context) {
    if (widget.routingConfiguration != null) {
      return WidgetsApp.router(
        key: GlobalObjectKey(this),
        routeInformationProvider: widget.routingConfiguration!.routeInformationProvider,
        routeInformationParser: widget.routingConfiguration!.routeInformationParser,
        routerDelegate: widget.routingConfiguration!.routerDelegate,
        routerConfig: widget.routingConfiguration!.configuration,
        backButtonDispatcher: widget.routingConfiguration!.backButtonDispatcher,
        onGenerateTitle: widget.stylingConfiguration.title,
        textStyle: fallbackTextStyle,
        color: widget.stylingConfiguration.systemColor,
        locale: widget.localizationConfiguration.locale,
        supportedLocales: widget.localizationConfiguration.supported,
        localizationsDelegates: widget.localizationConfiguration.delegates,
        localeResolutionCallback: widget.localizationConfiguration.singleResolutionCallback,
        localeListResolutionCallback: widget.localizationConfiguration.listResolutionCallback,
        shortcuts: widget.actionsConfiguration.shortcuts,
        actions: widget.actionsConfiguration.actions,
        debugShowCheckedModeBanner: false,
        debugShowWidgetInspector: false,
        checkerboardOffscreenLayers: false,
        checkerboardRasterCacheImages: false,
        showPerformanceOverlay: false,
        showSemanticsDebugger: false,
        builder: _builder,
      );
    }

    return WidgetsApp(
      key: GlobalObjectKey(this),
      navigatorKey: widget.navigatingConfiguration!.navigatorKey,
      navigatorObservers: widget.navigatingConfiguration!.navigatorObservers ?? [],
      pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) => _DefaultPageRoute<T>(settings: settings, builder: builder),
      home: widget.navigatingConfiguration!.home,
      routes: widget.navigatingConfiguration!.routes ?? {},
      initialRoute: widget.navigatingConfiguration!.initialRoute,
      onGenerateRoute: widget.navigatingConfiguration!.onGenerateRoute,
      onGenerateInitialRoutes: widget.navigatingConfiguration!.onGenerateInitialRoutes,
      onUnknownRoute: widget.navigatingConfiguration!.onUnknownRoute,
      onNavigationNotification: widget.navigatingConfiguration!.onNavigationNotification,
      onGenerateTitle: widget.stylingConfiguration.title,
      textStyle: fallbackTextStyle,
      color: widget.stylingConfiguration.systemColor,
      locale: widget.localizationConfiguration.locale,
      supportedLocales: widget.localizationConfiguration.supported,
      localizationsDelegates: widget.localizationConfiguration.delegates,
      localeResolutionCallback: widget.localizationConfiguration.singleResolutionCallback,
      localeListResolutionCallback: widget.localizationConfiguration.listResolutionCallback,
      shortcuts: widget.actionsConfiguration.shortcuts,
      actions: widget.actionsConfiguration.actions,
      debugShowCheckedModeBanner: false,
      debugShowWidgetInspector: false,
      checkerboardOffscreenLayers: false,
      checkerboardRasterCacheImages: false,
      showPerformanceOverlay: false,
      showSemanticsDebugger: false,
      builder: _builder,
    );
  }

  @override
  Widget build(BuildContext context) => Builder(
        builder: (_) {
          if (widget.errorsConfiguration.handleWidgetErrors) {
            ErrorWidget.builder = (errorDetails) => ErrorHandler(error: errorDetails.exception, stack: errorDetails.stack);
          }
          return ScrollConfiguration(
            behavior: widget.scrollingConfiguration.behavior,
            child: Focus(
              canRequestFocus: false,
              onKeyEvent: (node, event) {
                if ((event is! KeyDownEvent && event is! KeyRepeatEvent) || event.logicalKey != LogicalKeyboardKey.escape) {
                  return KeyEventResult.ignored;
                }
                return Popover.dismissAll() ? KeyEventResult.handled : KeyEventResult.ignored;
              },
              child: _buildApplication(context),
            ),
          );
        },
      );
}

class _DefaultPageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;

  @override
  final bool maintainState;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => Duration.zero;

  _DefaultPageRoute({
    required this.builder,
    this.maintainState = true,
    super.settings,
    super.fullscreenDialog,
    super.allowSnapshotting = true,
    super.barrierDismissible = false,
  });

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: builder(context),
      );
}

class _DefaultScrollBehavior extends ScrollBehavior {
  const _DefaultScrollBehavior();

  @override
  TargetPlatform getPlatform(BuildContext context) => defaultTargetPlatform;

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        assert(details.controller != null);
        return Scrollbar(
          controller: details.controller,
          child: child,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return child;
    }
  }

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    const indicator = AndroidOverscrollIndicator.stretch;
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
      case TargetPlatform.android:
        switch (indicator) {
          case AndroidOverscrollIndicator.stretch:
            return StretchingOverscrollIndicator(
              axisDirection: details.direction,
              clipBehavior: details.decorationClipBehavior ?? Clip.hardEdge,
              child: child,
            );
          case AndroidOverscrollIndicator.glow:
            break;
        }
      case TargetPlatform.fuchsia:
        break;
    }
    return GlowingOverscrollIndicator(
      axisDirection: details.direction,
      color: Theme.of(context).tokens.colors.additional,
      child: child,
    );
  }
}
