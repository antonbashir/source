import 'package:design/constants/assertions.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class WidgetSurveyor {
  const WidgetSurveyor();

  Size measureBuilder(
    WidgetBuilder builder, {
    BoxConstraints constraints = const BoxConstraints(),
  }) =>
      measureWidget(Builder(builder: builder), constraints: constraints);

  Size measureWidget(
    Widget widget, {
    BoxConstraints constraints = const BoxConstraints(),
  }) {
    final SurveyorView rendered = _render(widget, constraints);
    assert(rendered.hasSize);
    return rendered.size;
  }

  double measureDistanceToBaseline(
    Widget widget, {
    TextBaseline baseline = TextBaseline.alphabetic,
    BoxConstraints constraints = const BoxConstraints(),
  }) {
    final SurveyorView rendered = _render(widget, constraints, baselineToCalculate: baseline);
    return rendered.childBaseline ?? rendered.size.height;
  }

  double? measureDistanceToActualBaseline(
    Widget widget, {
    TextBaseline baseline = TextBaseline.alphabetic,
    BoxConstraints constraints = const BoxConstraints(),
  }) {
    final SurveyorView rendered = _render(widget, constraints, baselineToCalculate: baseline);
    return rendered.childBaseline;
  }

  SurveyorView _render(
    Widget widget,
    BoxConstraints constraints, {
    TextBaseline? baselineToCalculate,
  }) {
    bool debugIsPerformingCleanup = false;
    final pipelineOwner = PipelineOwner(
      onNeedVisualUpdate: () {
        assert(() {
          if (!debugIsPerformingCleanup) {
            throw FlutterError.fromParts(
              <DiagnosticsNode>[
                ErrorSummary(surveyVisualUpdateRequestedErrorSummary),
                ErrorDescription(surveyMakMethodsErrorDescription),
              ],
            );
          }
          return true;
        }());
      },
    );
    final rootView = pipelineOwner.rootNode = SurveyorView();
    final buildOwner = BuildOwner(focusManager: FocusManager());
    assert(buildOwner.globalKeyCount == 0);
    final element = RenderObjectToWidgetAdapter<RenderBox>(
      container: rootView,
      debugShortDescription: '[root]',
      child: widget,
    ).attachToRenderTree(buildOwner);
    try {
      rootView.baselineToCalculate = baselineToCalculate;
      rootView.childConstraints = constraints;
      rootView.scheduleInitialLayout();
      pipelineOwner.flushLayout();
      assert(rootView.child != null);
      return rootView;
    } finally {
      debugIsPerformingCleanup = true;
      try {
        element.update(RenderObjectToWidgetAdapter<RenderBox>(container: rootView));
        buildOwner.finalizeTree();
      } finally {
        debugIsPerformingCleanup = false;
      }
      assert(buildOwner.globalKeyCount == 1);
    }
  }
}

class SurveyorView extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  BoxConstraints? childConstraints;
  TextBaseline? baselineToCalculate;
  double? childBaseline;

  @override
  void performLayout() {
    assert(child != null);
    assert(childConstraints != null);
    child!.layout(childConstraints!, parentUsesSize: true);
    if (baselineToCalculate != null) {
      childBaseline = child!.getDistanceToBaseline(baselineToCalculate!);
    }
    size = child!.size;
  }

  @override
  void debugAssertDoesMeetConstraints() => true;
}
