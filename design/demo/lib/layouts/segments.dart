part of '../layouts.dart';

class _Segments extends StatefulWidget {
  const _Segments();

  @override
  State<_Segments> createState() => _SegmentsState();
}

class _SegmentsState extends State<_Segments> {
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
                child: Text("Segments", style: context.typography.base.titleLarge),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(context.spacings.small),
                    child: DecoratedBox(
                      decoration: ShapeDecoration(color: context.colors.surface, shape: SquircleBorder(borderRadius: context.borders.medium.squircle(context))),
                      child: SegmentedControl(
                        segments: const [
                          Segment(leading: Icon(Icons.segment), label: Text("Segment 1")),
                          Segment(leading: Icon(Icons.segment), label: Text("Segment 2")),
                          Segment(leading: Icon(Icons.segment), label: Text("Segment 3")),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(context.spacings.small),
                    child: DecoratedBox(
                      decoration: ShapeDecoration(color: context.colors.surface, shape: SquircleBorder(borderRadius: context.borders.medium.squircle(context))),
                      child: SegmentedControl.custom(
                        customSegments: [
                          (context, selected) => Avatar(content: const Icon(Icons.person), showBadge: selected),
                          (context, selected) => Avatar(content: const Icon(Icons.person), showBadge: selected),
                          (context, selected) => Avatar(content: const Icon(Icons.person), showBadge: selected),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
}
