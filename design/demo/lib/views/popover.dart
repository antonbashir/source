part of '../views.dart';

class _Popover extends StatefulWidget {
  const _Popover();

  @override
  State<_Popover> createState() => _PopoverState();
}

class _PopoverState extends State<_Popover> {
  var _open = false;

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
                child: Text("Popover", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.medium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Popover.hovering(
                      onTapOutside: () => setState(() => _open = false),
                      content: const Text("I am popover"),
                      child: const Text("Hover me!"),
                    ),
                    SizedBox(width: context.spacings.small),
                    Popover(
                      show: _open,
                      maxWidth: 350,
                      contentPadding: EdgeInsets.all(context.spacings.small),
                      content: Alert(
                        label: const Text("Helping information"),
                        content: const Text("More content"),
                        trailing: Button.icon(
                          icon: const Icon(Icons.clear, color: Colors.white),
                          onTap: () => setState(() => _open = false),
                        ),
                      ),
                      child: Button.icon(
                        icon: const Icon(Icons.help_center),
                        onTap: () => setState(() => _open = true),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
