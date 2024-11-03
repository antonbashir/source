import 'package:design/constants/dropdown.dart';
import 'package:design/constants/popover.dart';
import 'package:flutter/widgets.dart';

const labelCrossAxisAlignmentAssertion = 'The CrossAxisAlignment.baseline is not supported since the label and content of menu item are aligned in a column, not in a row. Try using another constant.';
const listItemExtentAssertion = 'You can only pass itemExtent or prototypeItem, not both';
String tabControllerNullAssertion(BuildContext context) => 'DefaultTabController.of() was called with a context that does not '
    'contain a DefaultTabController widget.\n'
    'No DefaultTabController widget ancestor could be found starting from '
    'the context that was passed to DefaultTabController.of(). This can '
    'happen because you are using a widget that looks for a DefaultTabController '
    'ancestor, but no such ancestor exists.\n'
    'The context used was:\n'
    '  $context';
const testMinLinesAssertion = "MinLines can not be greater than maxLines";
const testMinLinesWithExpandsAssertion = "MinLines and maxLines must be null when 'expands' is true.";
const testObscuredFieldsAssertion = "Obscured fields cannot be multiline.";
const textKeyboardTypeWithNewLineAssertion = 'Use keyboardType TextInputType.multiline when using TextInputAction.newline on a multiline TextInput.';
const surveyVisualUpdateRequestedErrorSummary = 'Visual update was requested during survey.';
const surveyMakMethodsErrorDescription =
    'WidgetSurveyor does not support a render object calling markNeedsLayout(), markNeedsPaint(), or markNeedsSemanticUpdate() while the widget is being surveyed.';
const modalBuildContextInvalidErrorSummary = 'This BuildContext is no longer valid.';
const modalBuildContextInvalidErrorDescription = 'The showModal function context parameter is a BuildContext that is no longer valid.';
const modalBuildContextInvalidErrorHint = 'This can commonly occur when the showModal function is called after awaiting a Future. '
    'In this situation the BuildContext might refer to a widget that has already been disposed during the await. '
    'Consider using a parent context instead.';

String popoverPositionAssertion(PopoverPosition position) => "Popover position doesn't: $position";
String dropdownPositionAssertion(DropdownAnchorPosition position) => "Dropdown position doesn't: $position";
