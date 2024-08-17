part of '../views.dart';

class _Carousel extends StatefulWidget {
  const _Carousel();

  @override
  State<_Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<_Carousel> {
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
                child: Text("Carousel", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.medium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(context.spacings.small),
                        child: Carousel(
                          height: 150,
                          isCentered: true,
                          autoPlay: true,
                          loop: true,
                          itemExtent: 120,
                          itemCount: 10,
                          itemBuilder: (context, itemIndex, realIndex) => Label(
                            backgroundColor: context.colors.neutral,
                            label: Center(child: Text("Item - $itemIndex")),
                          ),
                        ),
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
