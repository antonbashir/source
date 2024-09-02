part of '../primitives.dart';

class _Tags extends StatefulWidget {
  const _Tags();

  @override
  State<_Tags> createState() => _TagsState();
}

class _TagsState extends State<_Tags> {
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
                child: Text("Tags", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.medium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Tag(
                      size: BreakpointSize.tiny,
                      label: Text("I am tag"),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Tag(
                      size: BreakpointSize.small,
                      label: Text("I am tag"),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Tag(
                      leading: Icon(Icons.bolt),
                      size: BreakpointSize.medium,
                      label: Text("I am tag"),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Tag(
                      leading: Icon(Icons.bolt),
                      label: Text("I am tag"),
                      trailing: Icon(Icons.check),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    Tag(
                      label: const Text("I am tag. Click me"),
                      onTap: () => Toast.show(context, label: const Text("You clicked tag")),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
