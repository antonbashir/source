part of '../primitives.dart';

class _Link extends StatefulWidget {
  const _Link();

  @override
  State<_Link> createState() => _LinkState();
}

class _LinkState extends State<_Link> {
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
                child: Text("Link", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.medium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(context.spacings.small),
                      child: Link(
                        text: "Google",
                        uri: Uri.parse("https://google.com"),
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
