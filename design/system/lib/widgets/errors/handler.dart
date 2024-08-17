import 'package:design/widgets/configurator/configurator.dart';
import 'package:flutter/widgets.dart';

class ErrorHandler extends StatelessWidget {
  final dynamic error;
  final StackTrace? stack;

  const ErrorHandler({super.key, required this.error, this.stack});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => Configurator.of(context).errorsConfiguration.handler(error, stack));
    return Container();
  }
}
