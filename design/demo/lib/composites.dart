import 'package:design/design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

part 'composites/authentication.dart';
part 'composites/toast.dart';
part 'composites/accordion.dart';
part 'composites/breadcrumbs.dart';

class Composites extends StatelessWidget {
  const Composites({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _AuthenticationCode(),
          SizedBox(height: context.spacings.medium),
          const _Toast(),
          SizedBox(height: context.spacings.medium),
          const _Accordion(),
          SizedBox(height: context.spacings.medium),
          const _Breadcrumbs(),
          SizedBox(height: context.spacings.medium),
        ],
      );
}
