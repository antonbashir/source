part of '../primitives.dart';

class _Avatar extends StatelessWidget {
  const _Avatar();

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
                child: Text("Avatar", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.small),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Avatar(
                      size: BreakpointSize.tiny,
                      content: Icon(Icons.person),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Avatar(
                      size: BreakpointSize.small,
                      content: Icon(Icons.person),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Avatar(
                      size: BreakpointSize.medium,
                      content: Icon(Icons.person),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Avatar(
                      size: BreakpointSize.large,
                      content: Icon(Icons.person),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Avatar(
                      size: BreakpointSize.gigantic,
                      content: Icon(Icons.person),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Avatar(
                      size: BreakpointSize.colossal,
                      content: Icon(Icons.person),
                    ),
                    SizedBox(width: context.spacings.tiny),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.small),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Avatar(
                      size: BreakpointSize.tiny,
                      content: Icon(Icons.person),
                      showBadge: true,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Avatar(
                      size: BreakpointSize.small,
                      content: Icon(Icons.person),
                      showBadge: true,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Avatar(
                      size: BreakpointSize.medium,
                      content: Icon(Icons.person),
                      showBadge: true,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Avatar(
                      size: BreakpointSize.large,
                      content: Icon(Icons.person),
                      showBadge: true,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Avatar(
                      size: BreakpointSize.gigantic,
                      content: Icon(Icons.person),
                      showBadge: true,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const Avatar(
                      size: BreakpointSize.colossal,
                      content: Icon(Icons.person),
                      showBadge: true,
                    ),
                    SizedBox(width: context.spacings.tiny),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
