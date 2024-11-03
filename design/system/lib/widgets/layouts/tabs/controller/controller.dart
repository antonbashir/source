import 'dart:math' as math;

import 'package:design/constants/assertions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class TabController extends ChangeNotifier {
  TabController({
    int initialIndex = 0,
    required Duration animationDuration,
    required this.length,
    required TickerProvider vsync,
  })  : assert(length >= 0),
        assert(initialIndex >= 0 && (length == 0 || initialIndex < length)),
        _index = initialIndex,
        _previousIndex = initialIndex,
        _animationDuration = animationDuration,
        _animationController = AnimationController.unbounded(
          value: initialIndex.toDouble(),
          vsync: vsync,
        ) {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  TabController._({
    required int index,
    required int previousIndex,
    required AnimationController? animationController,
    required Duration animationDuration,
    required this.length,
  })  : _index = index,
        _previousIndex = previousIndex,
        _animationController = animationController,
        _animationDuration = animationDuration {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  TabController _copyWithAndDispose({
    required int? index,
    required int? length,
    required int? previousIndex,
    required Duration? animationDuration,
  }) {
    if (index != null) {
      _animationController!.value = index.toDouble();
    }
    final TabController newController = TabController._(
      index: index ?? _index,
      length: length ?? this.length,
      animationController: _animationController,
      previousIndex: previousIndex ?? _previousIndex,
      animationDuration: animationDuration ?? _animationDuration,
    );

    _animationController = null;
    dispose();

    return newController;
  }

  Animation<double>? get animation => _animationController?.view;
  AnimationController? _animationController;
  Duration get animationDuration => _animationDuration;
  final Duration _animationDuration;
  final int length;

  void _changeIndex(int value, {Duration? duration, Curve? curve}) {
    assert(value >= 0 && (value < length || length == 0));
    assert(duration != null || curve == null);
    assert(_indexIsChangingCount >= 0);
    if (value == _index || length < 2) {
      return;
    }
    _previousIndex = index;
    _index = value;
    if (duration != null && duration > Duration.zero) {
      _indexIsChangingCount += 1;
      notifyListeners();
      _animationController!.animateTo(_index.toDouble(), duration: duration, curve: curve!).whenCompleteOrCancel(() {
        if (_animationController != null) {
          _indexIsChangingCount -= 1;
          notifyListeners();
        }
      });
    } else {
      _indexIsChangingCount += 1;
      _animationController!.value = _index.toDouble();
      _indexIsChangingCount -= 1;
      notifyListeners();
    }
  }

  int get index => _index;
  int _index;
  set index(int value) {
    _changeIndex(value);
  }

  int get previousIndex => _previousIndex;
  int _previousIndex;

  bool get indexIsChanging => _indexIsChangingCount != 0;
  int _indexIsChangingCount = 0;

  void animateTo(int value, {Duration? duration, Curve curve = Curves.ease}) {
    _changeIndex(value, duration: duration ?? _animationDuration, curve: curve);
  }

  double get offset => _animationController!.value - _index.toDouble();
  set offset(double value) {
    assert(value >= -1.0 && value <= 1.0);
    assert(!indexIsChanging);
    if (value == offset) {
      return;
    }
    _animationController!.value = value + _index.toDouble();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _animationController = null;
    super.dispose();
  }
}

class _TabControllerScope extends InheritedWidget {
  const _TabControllerScope({
    required this.controller,
    required this.enabled,
    required super.child,
  });

  final TabController controller;
  final bool enabled;

  @override
  bool updateShouldNotify(_TabControllerScope old) {
    return enabled != old.enabled || controller != old.controller;
  }
}

class DefaultTabController extends StatefulWidget {
  const DefaultTabController({
    super.key,
    this.initialIndex = 0,
    required this.length,
    required this.child,
    required this.animationDuration,
  })  : assert(length >= 0),
        assert(length == 0 || (initialIndex >= 0 && initialIndex < length));

  final int length;
  final int initialIndex;
  final Duration animationDuration;
  final Widget child;

  static TabController? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<_TabControllerScope>()?.controller;

  static TabController of(BuildContext context) {
    final TabController? controller = maybeOf(context);
    assert(() {
      if (controller == null) {
        throw FlutterError(tabControllerNullAssertion(context));
      }
      return true;
    }());
    return controller!;
  }

  @override
  State<DefaultTabController> createState() => _DefaultTabControllerState();
}

class _DefaultTabControllerState extends State<DefaultTabController> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      vsync: this,
      length: widget.length,
      initialIndex: widget.initialIndex,
      animationDuration: widget.animationDuration,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _TabControllerScope(
      controller: _controller,
      enabled: TickerMode.of(context),
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(DefaultTabController oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.length != widget.length) {
      int? newIndex;
      int previousIndex = _controller.previousIndex;
      if (_controller.index >= widget.length) {
        newIndex = math.max(0, widget.length - 1);
        previousIndex = _controller.index;
      }
      _controller = _controller._copyWithAndDispose(
        length: widget.length,
        animationDuration: widget.animationDuration,
        index: newIndex,
        previousIndex: previousIndex,
      );
    }

    if (oldWidget.animationDuration != widget.animationDuration) {
      _controller = _controller._copyWithAndDispose(
        length: widget.length,
        animationDuration: widget.animationDuration,
        index: _controller.index,
        previousIndex: _controller.previousIndex,
      );
    }
  }
}
