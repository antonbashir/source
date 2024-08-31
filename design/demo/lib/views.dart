import 'dart:async';
import 'dart:math';

import 'package:design/design.dart';
import 'package:flutter/widgets.dart';

part 'views/dropdown.dart';
part 'views/popover.dart';
part 'views/modal.dart';
part 'views/carousel.dart';
part 'views/list.dart';

class Views extends StatelessWidget {
  const Views({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Dropdown(),
          SizedBox(height: context.spacings.medium),
          const _Popover(),
          SizedBox(height: context.spacings.medium),
          const _Modal(),
          SizedBox(height: context.spacings.medium),
          const _Carousel(),
          SizedBox(height: context.spacings.medium),
          const _List(),
          SizedBox(height: context.spacings.medium),
        ],
      );
}
