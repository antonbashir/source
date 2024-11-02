part of '../primitives.dart';

class _Chips extends StatefulWidget {
  const _Chips();

  @override
  State<_Chips> createState() => _ChipsState();
}

class _ChipsState extends State<_Chips> {
  var _active = false;

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
                child: Text("Chips", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.medium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Chip(
                      size: BreakpointSize.small,
                      label: Text("I am chip"),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Chip(
                      size: BreakpointSize.medium,
                      label: Text("I am chip"),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Chip(
                      leading: Icon(Icons.bolt),
                      label: Text("I am chip"),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Chip(
                      leading: Icon(Icons.bolt),
                      label: Text("I am chip"),
                      trailing: Icon(Icons.check),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    Chip(
                      label: const Text("I am clickable chip. Click me"),
                      isActive: _active,
                      onTap: () => setState(() => _active = !_active),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
