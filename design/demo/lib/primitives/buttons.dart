part of '../primitives.dart';

class _Buttons extends StatefulWidget {
  const _Buttons();

  @override
  State<_Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<_Buttons> {
  var _pulse = false;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: ShapeDecoration(shape: SquircleBorder(borderRadius: context.borders.medium.squircle(context), side: BorderSide(color: context.colors.border))),
        child: Padding(
          padding: EdgeInsets.all(context.spacings.small),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(context.spacings.small),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Buttons", style: context.typography.base.titleLarge),
                    Row(
                      children: [
                        const Text("Pulse"),
                        SizedBox(
                          width: context.spacings.small,
                        ),
                        Checkbox(value: _pulse, onChanged: (value) => setState(() => _pulse = value!)),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.medium),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FilledButton(
                          showPulseEffect: _pulse,
                          size: BreakpointSize.tiny,
                          label: const Text("Press me"),
                        ),
                        SizedBox(width: context.spacings.small),
                        FilledButton(
                          showPulseEffect: _pulse,
                          size: BreakpointSize.tiny,
                          label: const Text("Press me"),
                          onTap: () {},
                        ),
                        SizedBox(width: context.spacings.small),
                        FilledButton(
                          showPulseEffect: _pulse,
                          size: BreakpointSize.small,
                          label: const Text("Press me"),
                          onTap: () {},
                        ),
                        SizedBox(width: context.spacings.small),
                        FilledButton(
                          showPulseEffect: _pulse,
                          size: BreakpointSize.medium,
                          label: const Text("Press me"),
                          onTap: () {},
                        ),
                        SizedBox(width: context.spacings.small),
                        FilledButton(
                          showPulseEffect: _pulse,
                          size: BreakpointSize.large,
                          label: const Text("Press me"),
                          onTap: () {},
                        ),
                        SizedBox(width: context.spacings.small),
                        FilledButton(
                          showPulseEffect: _pulse,
                          size: BreakpointSize.gigantic,
                          label: const Text("Press me"),
                          onTap: () {},
                        ),
                        SizedBox(width: context.spacings.small),
                      ],
                    ),
                    SizedBox(height: context.spacings.medium),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          showPulseEffect: _pulse,
                          buttonSize: BreakpointSize.tiny,
                          label: const Text("Press me"),
                        ),
                        SizedBox(width: context.spacings.small),
                        OutlinedButton(
                          showPulseEffect: _pulse,
                          buttonSize: BreakpointSize.tiny,
                          label: const Text("Press me"),
                          onTap: () {},
                        ),
                        SizedBox(width: context.spacings.small),
                        OutlinedButton(
                          showPulseEffect: _pulse,
                          buttonSize: BreakpointSize.small,
                          label: const Text("Press me"),
                          onTap: () {},
                        ),
                        SizedBox(width: context.spacings.small),
                        OutlinedButton(
                          showPulseEffect: _pulse,
                          buttonSize: BreakpointSize.medium,
                          label: const Text("Press me"),
                          onTap: () {},
                        ),
                        SizedBox(width: context.spacings.small),
                        OutlinedButton(
                          showPulseEffect: _pulse,
                          buttonSize: BreakpointSize.large,
                          label: const Text("Press me"),
                          onTap: () {},
                        ),
                        SizedBox(width: context.spacings.small),
                        OutlinedButton(
                          showPulseEffect: _pulse,
                          buttonSize: BreakpointSize.gigantic,
                          label: const Text("Press me"),
                          onTap: () {},
                        ),
                        SizedBox(width: context.spacings.small),
                      ],
                    ),
                    SizedBox(height: context.spacings.medium),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                          showPulseEffect: _pulse,
                          buttonSize: BreakpointSize.tiny,
                          label: const Text("Press me"),
                        ),
                        SizedBox(width: context.spacings.small),
                        TextButton(
                          showPulseEffect: _pulse,
                          buttonSize: BreakpointSize.tiny,
                          label: const Text("Press me"),
                          onTap: () {},
                        ),
                        SizedBox(width: context.spacings.small),
                        TextButton(
                          showPulseEffect: _pulse,
                          buttonSize: BreakpointSize.small,
                          label: const Text("Press me"),
                          onTap: () {},
                        ),
                        SizedBox(width: context.spacings.small),
                        TextButton(
                          showPulseEffect: _pulse,
                          buttonSize: BreakpointSize.medium,
                          label: const Text("Press me"),
                          onTap: () {},
                        ),
                        SizedBox(width: context.spacings.small),
                        TextButton(
                          showPulseEffect: _pulse,
                          buttonSize: BreakpointSize.large,
                          label: const Text("Press me"),
                          onTap: () {},
                        ),
                        SizedBox(width: context.spacings.small),
                        TextButton(
                          showPulseEffect: _pulse,
                          buttonSize: BreakpointSize.gigantic,
                          label: const Text("Press me"),
                          onTap: () {},
                        ),
                        SizedBox(width: context.spacings.small),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
