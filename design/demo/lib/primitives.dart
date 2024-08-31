import 'package:design/design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

part 'primitives/avatar.dart';
part 'primitives/alert.dart';
part 'primitives/buttons.dart';
part 'primitives/checkbox.dart';
part 'primitives/radio.dart';
part 'primitives/chips.dart';
part 'primitives/indicators.dart';
part 'primitives/switch.dart';
part 'primitives/tags.dart';
part 'primitives/inputs.dart';
part 'primitives/link.dart';

class Primitives extends StatelessWidget {
  const Primitives({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Avatar(),
          SizedBox(height: context.spacings.medium),
          const _Buttons(),
          SizedBox(height: context.spacings.medium),
          const _Checkbox(),
          SizedBox(height: context.spacings.medium),
          const _Radio(),
          SizedBox(height: context.spacings.medium),
          const _Switch(),
          SizedBox(height: context.spacings.medium),
          const _Chips(),
          SizedBox(height: context.spacings.medium),
          const _Tags(),
          SizedBox(height: context.spacings.medium),
          const _Indicators(),
          SizedBox(height: context.spacings.medium),
          const _Inputs(),
          SizedBox(height: context.spacings.medium),
          const _Alert(),
          SizedBox(height: context.spacings.medium),
          const _Link(),
        ],
      );
}
