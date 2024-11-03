part of '../primitives.dart';

class _Checkbox extends StatefulWidget {
  const _Checkbox();

  @override
  State<_Checkbox> createState() => _CheckboxState();
}

class _CheckboxState extends State<_Checkbox> {
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
                child: Text("Checkbox", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.medium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Checkbox(
                      onChanged: (value) => setState(() => _selected = value ?? true),
                      value: _selected,
                      size: BreakpointSize.tiny,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    Checkbox(
                      onChanged: (value) => setState(() => _selected = value ?? true),
                      value: _selected,
                      size: BreakpointSize.small,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    Checkbox(
                      onChanged: (value) => setState(() => _selected = value ?? true),
                      value: _selected,
                      size: BreakpointSize.medium,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    Checkbox(
                      onChanged: (value) => setState(() => _selected = value ?? true),
                      value: null,
                      tristate: true,
                      size: BreakpointSize.medium,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Checkbox(
                      onChanged: null,
                      value: true,
                      tristate: true,
                      size: BreakpointSize.medium,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Checkbox(
                      onChanged: null,
                      value: false,
                      tristate: true,
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
