import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/configurator/configurator.dart';
import 'package:design/widgets/selection/selection.dart';
import 'package:flutter/widgets.dart';

class Screen extends StatelessWidget {
  final Widget child;

  const Screen({super.key, required this.child});
  @override
  Widget build(BuildContext context) => ScrollNotificationObserver(
        child: DecoratedBox(
          decoration: BoxDecoration(color: context.colors.background),
          child: Selectable(
            enabled: Configurator.of(context).actionsConfiguration.enableSelection,
            child: IconTheme(
              data: IconThemeData(color: context.colors.contentMedium),
              child: DefaultTextStyle(
                style: context.typography.base.bodyMedium,
                child: child,
              ),
            ),
          ),
        ),
      );
}
