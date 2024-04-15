import 'dart:ui';

import 'package:design/extensions/extensions.dart';
import 'package:design/model/state.dart';
import 'package:design/theme/tokens/colors.dart';
import 'package:design/widgets/icons/icons.dart';
import 'package:design/widgets/theme/theme.dart';
import 'package:flutter/widgets.dart';

enum StepState {
  indexed,
  editing,
  complete,
  disabled,
  error,
}

enum StepperType {
  vertical,
  horizontal,
}

@immutable
class StepperControlsDetails {
  const StepperControlsDetails({
    required this.currentStep,
    required this.stepIndex,
    this.onStepCancel,
    this.onStepContinue,
  });

  final int currentStep;
  final int stepIndex;
  final VoidCallback? onStepContinue;
  final VoidCallback? onStepCancel;
  bool get isActive => currentStep == stepIndex;
}

typedef StepperControlsWidgetBuilder = Widget Function(BuildContext context, StepperControlsDetails details);

typedef StepIconBuilder = Widget? Function(int stepIndex, StepState stepState);

const _kStepStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.white,
);

const _kCircleActiveLight = Colors.white;
const _kCircleActiveDark = Colors.black87;
const _kDisabledLight = Colors.black38;
const _kDisabledDark = Colors.white38;
const _kStepSize = 24.0;
const _kTriangleHeight = _kStepSize * 0.866025;

@immutable
class Step {
  final Widget title;
  final Widget? subtitle;
  final Widget content;
  final StepState state;
  final bool isActive;
  final Widget? label;

  const Step({
    required this.title,
    required this.content,
    this.subtitle,
    this.state = StepState.indexed,
    this.isActive = false,
    this.label,
  });
}

class Stepper extends StatefulWidget {
  const Stepper({
    super.key,
    required this.steps,
    required this.controlsBuilder,
    this.controller,
    this.physics,
    this.type = StepperType.vertical,
    this.currentStep = 0,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.elevation,
    this.margin,
    this.connectorColor,
    this.connectorThickness,
    this.stepIconBuilder,
  }) : assert(0 <= currentStep && currentStep < steps.length);

  final List<Step> steps;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final StepperType type;
  final int currentStep;
  final ValueChanged<int>? onStepTapped;
  final VoidCallback? onStepContinue;
  final VoidCallback? onStepCancel;
  final StepperControlsWidgetBuilder controlsBuilder;
  final double? elevation;
  final EdgeInsetsGeometry? margin;
  final VisualStateProperty<Color>? connectorColor;
  final double? connectorThickness;
  final StepIconBuilder? stepIconBuilder;

  @override
  State<Stepper> createState() => _StepperState();
}

class _StepperState extends State<Stepper> with TickerProviderStateMixin {
  late List<GlobalKey> _keys;
  final Map<int, StepState> _oldStates = <int, StepState>{};

  @override
  void initState() {
    super.initState();
    _keys = List<GlobalKey>.generate(
      widget.steps.length,
      (int i) => GlobalKey(),
    );

    for (int i = 0; i < widget.steps.length; i += 1) {
      _oldStates[i] = widget.steps[i].state;
    }
  }

  @override
  void didUpdateWidget(Stepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.steps.length == oldWidget.steps.length);
    for (int i = 0; i < oldWidget.steps.length; i += 1) {
      _oldStates[i] = oldWidget.steps[i].state;
    }
  }

  bool _isFirst(int index) => index == 0;
  bool _isLast(int index) => widget.steps.length - 1 == index;
  bool _isCurrent(int index) => widget.currentStep == index;
  bool _isDark() => Theme.of(context).brightness == Brightness.dark;
  bool _isLabel() {
    for (final Step step in widget.steps) {
      if (step.label != null) {
        return true;
      }
    }
    return false;
  }

  Color _connectorColor(bool isActive) {
    final Set<VisualState> states = <VisualState>{
      if (isActive) VisualState.selected else VisualState.disabled,
    };
    if (widget.connectorColor?.resolve(states) case final resolvedConnectorColor?) return resolvedConnectorColor;
    return isActive ? context.colors.main : context.palette.gray.shade400;
  }

  Widget _buildLine(bool visible, bool isActive) => Container(
        width: visible ? widget.connectorThickness ?? 1.0 : 0.0,
        height: 16.0,
        color: _connectorColor(isActive),
      );

  Widget _buildCircleChild(int index, bool oldState) {
    final StepState state = oldState ? _oldStates[index]! : widget.steps[index].state;
    final bool isDarkActive = _isDark() && widget.steps[index].isActive;
    if (widget.stepIconBuilder?.call(index, state) case final icon?) return icon;
    switch (state) {
      case StepState.indexed:
      case StepState.disabled:
        return Text(
          '${index + 1}',
          style: isDarkActive ? _kStepStyle.copyWith(color: Colors.black87) : _kStepStyle,
        );
      case StepState.editing:
        return Icon(
          Icons.edit,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case StepState.complete:
        return Icon(
          Icons.check,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case StepState.error:
        return const Text('!', style: _kStepStyle);
    }
  }

  Color _circleColor(int index) {
    final bool isActive = widget.steps[index].isActive;
    final Set<VisualState> states = <VisualState>{
      if (isActive) VisualState.selected else VisualState.disabled,
    };
    final Color? resolvedConnectorColor = widget.connectorColor?.resolve(states);
    if (resolvedConnectorColor != null) {
      return resolvedConnectorColor;
    }

    return !_isDark()
        ? isActive
            ? context.colors.main
            : context.colors.contentMedium.withOpacity(0.38)
        : isActive
            ? context.colors.additional
            : context.colors.background;
  }

  Widget _buildCircle(int index, bool oldState) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        width: _kStepSize,
        height: _kStepSize,
        child: AnimatedContainer(
          curve: Curves.fastOutSlowIn,
          duration: context.transitions.transitionDuration,
          decoration: BoxDecoration(
            color: _circleColor(index),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: _buildCircleChild(index, oldState && widget.steps[index].state == StepState.error),
          ),
        ),
      );

  Widget _buildTriangle(int index, bool oldState) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        width: _kStepSize,
        height: _kStepSize,
        child: Center(
          child: SizedBox(
            width: _kStepSize,
            height: _kTriangleHeight,
            child: CustomPaint(
              painter: _TrianglePainter(
                color: context.colors.error,
              ),
              child: Align(
                alignment: const Alignment(0.0, 0.8),
                child: _buildCircleChild(index, oldState && widget.steps[index].state != StepState.error),
              ),
            ),
          ),
        ),
      );

  Widget _buildIcon(int index) {
    if (widget.steps[index].state != _oldStates[index]) {
      return AnimatedCrossFade(
        firstChild: _buildCircle(index, true),
        secondChild: _buildTriangle(index, true),
        firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.fastOutSlowIn,
        crossFadeState: widget.steps[index].state == StepState.error ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: context.transitions.transitionDuration,
      );
    }
    return widget.steps[index].state != StepState.error ? _buildCircle(index, false) : _buildTriangle(index, false);
  }

  Widget _buildVerticalControls(int stepIndex) => widget.controlsBuilder(
        context,
        StepperControlsDetails(
          currentStep: widget.currentStep,
          onStepContinue: widget.onStepContinue,
          onStepCancel: widget.onStepCancel,
          stepIndex: stepIndex,
        ),
      );

  TextStyle _titleStyle(int index) {
    switch (widget.steps[index].state) {
      case StepState.indexed:
      case StepState.editing:
      case StepState.complete:
        return context.typography.base.bodyLarge;
      case StepState.disabled:
        return context.typography.base.bodyLarge.copyWith(color: _isDark() ? _kDisabledDark : _kDisabledLight);
      case StepState.error:
        return context.typography.base.bodyLarge.copyWith(color: context.colors.error);
    }
  }

  TextStyle _subtitleStyle(int index) {
    switch (widget.steps[index].state) {
      case StepState.indexed:
      case StepState.editing:
      case StepState.complete:
        return context.typography.base.bodySmall;
      case StepState.disabled:
        return context.typography.base.bodySmall.copyWith(
          color: _isDark() ? _kDisabledDark : _kDisabledLight,
        );
      case StepState.error:
        return context.typography.base.bodySmall.copyWith(
          color: context.colors.error,
        );
    }
  }

  TextStyle _labelStyle(int index) {
    switch (widget.steps[index].state) {
      case StepState.indexed:
      case StepState.editing:
      case StepState.complete:
        return context.typography.base.bodyLarge;
      case StepState.disabled:
        return context.typography.base.bodyLarge.copyWith(color: _isDark() ? _kDisabledDark : _kDisabledLight);
      case StepState.error:
        return context.typography.base.bodyLarge.copyWith(color: context.colors.error);
    }
  }

  Widget _buildHeaderText(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedDefaultTextStyle(
          style: _titleStyle(index),
          duration: context.transitions.transitionDuration,
          curve: Curves.fastOutSlowIn,
          child: widget.steps[index].title,
        ),
        if (widget.steps[index].subtitle != null)
          Container(
            margin: const EdgeInsets.only(top: 2.0),
            child: AnimatedDefaultTextStyle(
              style: _subtitleStyle(index),
              duration: context.transitions.transitionDuration,
              curve: Curves.fastOutSlowIn,
              child: widget.steps[index].subtitle!,
            ),
          ),
      ],
    );
  }

  Widget _buildLabelText(int index) {
    if (widget.steps[index].label != null) {
      return AnimatedDefaultTextStyle(
        style: _labelStyle(index),
        duration: context.transitions.transitionDuration,
        child: widget.steps[index].label!,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildVerticalHeader(int index) {
    final isActive = widget.steps[index].isActive;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildLine(!_isFirst(index), isActive),
              _buildIcon(index),
              _buildLine(!_isLast(index), isActive),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsetsDirectional.only(start: 12.0),
              child: _buildHeaderText(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalBody(int index) => Stack(
        children: <Widget>[
          PositionedDirectional(
            start: 24.0,
            top: 0.0,
            bottom: 0.0,
            child: SizedBox(
              width: 24.0,
              child: Center(
                child: SizedBox(
                  width: widget.connectorThickness ?? 1.0,
                  child: Container(
                    color: _connectorColor(widget.steps[index].isActive),
                  ),
                ),
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(height: 0.0),
            secondChild: Container(
              margin: widget.margin ??
                  const EdgeInsetsDirectional.only(
                    start: 60.0,
                    end: 24.0,
                    bottom: 24.0,
                  ),
              child: Column(
                children: <Widget>[
                  widget.steps[index].content,
                  _buildVerticalControls(index),
                ],
              ),
            ),
            firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
            secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
            sizeCurve: Curves.fastOutSlowIn,
            crossFadeState: _isCurrent(index) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: context.transitions.transitionDuration,
          ),
        ],
      );

  Widget _buildVertical() => ListView(
        controller: widget.controller,
        shrinkWrap: true,
        physics: widget.physics,
        children: <Widget>[
          for (int i = 0; i < widget.steps.length; i += 1)
            Column(
              key: _keys[i],
              children: <Widget>[
                _buildVerticalHeader(i),
                _buildVerticalBody(i),
              ],
            ),
        ],
      );

  Widget _buildHorizontal() {
    final List<Widget> children = <Widget>[
      for (int i = 0; i < widget.steps.length; i += 1) ...<Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              height: _isLabel() ? 104.0 : 72.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (widget.steps[i].label != null)
                    const SizedBox(
                      height: 24.0,
                    ),
                  Center(child: _buildIcon(i)),
                  if (widget.steps[i].label != null)
                    SizedBox(
                      height: 24.0,
                      child: _buildLabelText(i),
                    ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(start: 12.0),
              child: _buildHeaderText(i),
            ),
          ],
        ),
        if (!_isLast(i))
          Expanded(
            child: Container(
              key: Key('line$i'),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              height: widget.connectorThickness ?? 1.0,
              color: _connectorColor(widget.steps[i + 1].isActive),
            ),
          ),
      ],
    ];

    final List<Widget> stepPanels = <Widget>[];
    for (int i = 0; i < widget.steps.length; i += 1) {
      stepPanels.add(
        Visibility(
          maintainState: true,
          visible: i == widget.currentStep,
          child: widget.steps[i].content,
        ),
      );
    }

    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: children,
          ),
        ),
        Expanded(
          child: ListView(
            controller: widget.controller,
            physics: widget.physics,
            padding: const EdgeInsets.all(24.0),
            children: <Widget>[
              AnimatedSize(
                curve: Curves.fastOutSlowIn,
                duration: context.transitions.transitionDuration,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: stepPanels),
              ),
              _buildVerticalControls(widget.currentStep),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => switch (widget.type) { StepperType.vertical => _buildVertical(), StepperType.horizontal => _buildHorizontal() };
}

class _TrianglePainter extends CustomPainter {
  _TrianglePainter({required this.color});

  final Color color;

  @override
  bool hitTest(Offset point) => true;

  @override
  bool shouldRepaint(_TrianglePainter oldPainter) => oldPainter.color != color;

  @override
  void paint(Canvas canvas, Size size) {
    final double base = size.width;
    final double halfBase = size.width / 2.0;
    final double height = size.height;
    final List<Offset> points = <Offset>[
      Offset(0.0, height),
      Offset(base, height),
      Offset(halfBase, 0.0),
    ];

    canvas.drawPath(
      Path()..addPolygon(points, true),
      Paint()..color = color,
    );
  }
}
