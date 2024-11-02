import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/primitives/text/error.dart';
import 'package:flutter/widgets.dart';

class TextErrorMessages extends StatelessWidget {
  final List<String> errors;

  const TextErrorMessages({super.key, required this.errors});

  List<String> get _nonEmptyErrors => errors.where((String error) => error.isNotEmpty).toList();

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children:
            List.generate(_nonEmptyErrors.length * 2 - 1, (index) => index.isEven ? TextErrorMessage(errorText: _nonEmptyErrors[index ~/ 2]) : SizedBox(height: context.tokens.spacings.spacing4)),
      );
}
