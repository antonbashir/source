import 'package:design/design.dart';
import 'package:flutter/widgets.dart';

part 'layouts/segments.dart';
part 'layouts/sidebar.dart';
part 'layouts/tabs.dart';
part 'layouts/stepper.dart';

class Layouts extends StatelessWidget {
  const Layouts({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Segments(),
          SizedBox(height: context.spacings.medium),
          const _Tabs(),
          SizedBox(height: context.spacings.medium),
          const _Sidebar(),
          SizedBox(height: context.spacings.medium),
          const _Stepper(),
          SizedBox(height: context.spacings.medium),
        ],
      );
}
