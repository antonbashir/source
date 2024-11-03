part of '../layouts.dart';

class _Stepper extends StatefulWidget {
  const _Stepper();

  @override
  State<_Stepper> createState() => _StepperState();
}

class _StepperState extends State<_Stepper> {
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
                child: Text("Stepper", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.small),
                child: Row(
                  children: [
                    SizedBox(
                      width: 500,
                      height: 350,
                      child: Container(
                        decoration: ShapeDecoration(shape: SquircleBorder(borderRadius: context.borders.small.squircle(context)), color: context.colors.surface),
                        child: Stepper(
                          margin: EdgeInsets.all(context.spacings.medium),
                          controlsBuilder: (context, details) => Container(),
                          type: StepperType.vertical,
                          steps: const [
                            Step(title: Text("First step"), content: Text("First step content"), isActive: true),
                            Step(title: Text("Second step"), content: Text("Second step content")),
                            Step(title: Text("Third step"), content: Text("Third step content")),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: context.spacings.large,
                    ),
                    SizedBox(
                      width: 500,
                      height: 350,
                      child: Container(
                        decoration: ShapeDecoration(shape: SquircleBorder(borderRadius: context.borders.small.squircle(context)), color: context.colors.surface),
                        child: Stepper(
                          margin: EdgeInsets.all(context.spacings.medium),
                          controlsBuilder: (context, details) => Container(),
                          type: StepperType.horizontal,
                          steps: const [
                            Step(title: Text("First step"), content: Text("First step content"), isActive: true),
                            Step(title: Text("Second step"), content: Text("Second step content")),
                            Step(title: Text("Third step"), content: Text("Third step content")),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
