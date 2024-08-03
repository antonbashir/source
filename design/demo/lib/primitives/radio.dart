part of '../primitives.dart';

class _Radio extends StatefulWidget {
  const _Radio();

  @override
  State<_Radio> createState() => _RadioState();
}

class _RadioState extends State<_Radio> {
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
                child: Text("Radio", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.medium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Radio(
                      onChanged: (value) => setState(() => _selected = value),
                      selected: _selected,
                      size: BreakpointSize.tiny,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    Radio(
                      onChanged: (value) => setState(() => _selected = value),
                      selected: _selected,
                      size: BreakpointSize.small,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    Radio(
                      onChanged: (value) => setState(() => _selected = value),
                      selected: _selected,
                      size: BreakpointSize.medium,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Radio(
                      onChanged: null,
                      selected: true,
                      toggleable: true,
                      size: BreakpointSize.medium,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Radio(
                      onChanged: null,
                      selected: false,
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
