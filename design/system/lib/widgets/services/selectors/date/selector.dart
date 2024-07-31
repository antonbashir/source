// import 'package:design/theme/tokens/sizes.dart';
// import 'package:flutter/widgets.dart';

// import 'package:design/constants/constants.dart';
// import 'package:design/extensions/extensions.dart';
// import 'package:design/theme/common.dart';

// class DateRangeSelector extends StatefulWidget {
//   final DateTime firstDate;
//   final DateTime lastDate;
//   final double width;
//   final ValueChanged<DateTimeRange?> onSelect;
//   final ValueChanged<bool> onChecked;
//   final DateTimeRange? selected;
//   final String? saveText;
//   final String? helpText;
//   final String? labelText;
//   final double? dialogHeight;
//   final double? dialogWidth;
//   final bool? enabled;

//   const DateRangeSelector({
//     super.key,
//     required this.firstDate,
//     required this.lastDate,
//     required this.width,
//     required this.onSelect,
//     required this.onChecked,
//     this.saveText,
//     this.helpText,
//     this.labelText,
//     this.dialogHeight,
//     this.dialogWidth,
//     this.enabled,
//     this.selected,
//   });

//   @override
//   State<StatefulWidget> createState() => _DateRangeSelectorState();
// }

// class _DateRangeSelectorState extends State<DateRangeSelector> {
//   late final TextEditingController _controller;
//   late bool _enabled;

//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//     _enabled = widget.enabled == true;
//     if (widget.selected != null) {
//       _controller.value = TextEditingValue(text: "${widget.selected!.start.formatDate()} - ${widget.selected!.end.formatDate()}");
//     }
//   }

//   @override
//   void didUpdateWidget(covariant DateRangeSelector oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.enabled != widget.enabled && _enabled != widget.enabled) {
//       setState(() => _enabled = widget.enabled == true);
//     }
//     if (oldWidget.selected != widget.selected) {
//       final newValue = widget.selected == null ? empty : "${widget.selected!.start.formatDate()} - ${widget.selected!.end.formatDate()}";
//       if (_controller.text != newValue) _controller.value = TextEditingValue(text: newValue);
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final field = TextField(
//       enabled: widget.enabled,
//       decoration: InputDecoration(labelText: widget.labelText, border: InputBorder.none),
//       controller: _controller,
//       readOnly: true,
//       onTap: () {
//         showDateRangePicker(
//           builder: (context, child) => Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: widget.dialogHeight,
//                 width: widget.dialogWidth,
//                 child: child,
//               ),
//             ],
//           ),
//           context: context,
//           firstDate: widget.firstDate,
//           lastDate: widget.lastDate,
//           initialDateRange: widget.selected,
//           initialEntryMode: DatePickerEntryMode.calendarOnly,
//           saveText: widget.saveText,
//           helpText: widget.helpText,
//         ).then(
//           (value) {
//             if (value != null) {
//               setState(() => _controller.value = TextEditingValue(text: "${value.start.formatDate()} - ${value.end.formatDate()}"));
//               widget.onSelect(value);
//             }
//           },
//         );
//       },
//     );

//     return SizedBox(
//       width: widget.width,
//       child: Card(
//         elevation: searchBarElevation,
//         margin: const EdgeInsets.all(0),
//         shape: const StadiumBorder(),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: Sizes._sizes.size40),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Checkbox(
//                 onChanged: (value) {
//                   setState(() => _enabled = value == true);
//                   widget.onChecked(value == true);
//                 },
//                 value: _enabled,
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: Sizes._sizes.size40),
//                   child: field,
//                 ),
//               ),
//               IconButton(
//                   onPressed: () {
//                     setState(() => _controller.value = const TextEditingValue(text: empty));
//                     widget.onSelect(null);
//                   },
//                   icon: const Icon(Icons.cancel)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
