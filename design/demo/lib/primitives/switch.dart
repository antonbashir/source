part of '../primitives.dart';

class _Switch extends StatefulWidget {
  const _Switch();

  @override
  State<_Switch> createState() => _SwitchState();
}

class _SwitchState extends State<_Switch> {
  var _selected = false;

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
                child: Text("Switch", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.medium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Switch(
                      size: BreakpointSize.tiny,
                      onChanged: (value) => setState(() => _selected = value),
                      value: _selected,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    Switch(
                      size: BreakpointSize.small,
                      onChanged: (value) => setState(() => _selected = value),
                      value: _selected,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    Switch(
                      size: BreakpointSize.medium,
                      onChanged: (value) => setState(() => _selected = value),
                      value: _selected,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Switch(
                      onChanged: null,
                      value: true,
                      size: BreakpointSize.medium,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Switch(
                      onChanged: null,
                      value: false,
                      size: BreakpointSize.medium,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
