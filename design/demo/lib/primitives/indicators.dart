part of '../primitives.dart';

class _Indicators extends StatefulWidget {
  const _Indicators();

  @override
  State<_Indicators> createState() => _IndicatorsState();
}

class _IndicatorsState extends State<_Indicators> {
  var _active = false;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: ShapeDecoration(shape: SquircleBorder(borderRadius: context.borders.medium.squircle(context), side: BorderSide(color: context.colors.border))),
        child: Padding(
          padding: EdgeInsets.all(context.spacings.small),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(context.spacings.small),
                    child: Text("Indicators", style: context.typography.base.titleLarge),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(context.spacings.small),
                        child: Text("Active", style: context.typography.base.bodyMedium),
                      ),
                      Padding(
                        padding: EdgeInsets.all(context.spacings.small),
                        child: Checkbox(value: _active, onChanged: (value) => setState(() => _active = value!)),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: context.spacings.medium),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [DotsIndicator(count: 3, selected: 0)],
              ),
              SizedBox(height: context.spacings.medium),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: context.spacings.tiny),
                  CircularLoader(size: BreakpointSize.tiny, active: _active),
                  SizedBox(width: context.spacings.tiny),
                  CircularLoader(size: BreakpointSize.small, active: _active),
                  SizedBox(width: context.spacings.tiny),
                  CircularLoader(size: BreakpointSize.medium, active: _active),
                  SizedBox(width: context.spacings.tiny),
                  CircularLoader(size: BreakpointSize.large, active: _active),
                  SizedBox(width: context.spacings.tiny),
                  CircularLoader(size: BreakpointSize.gigantic, active: _active),
                ],
              ),
              SizedBox(height: context.spacings.medium),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: context.spacings.tiny),
                  const CircularProgress(value: 0.5, size: BreakpointSize.tiny),
                  SizedBox(width: context.spacings.tiny),
                  const CircularProgress(value: 0.5, size: BreakpointSize.small),
                  SizedBox(width: context.spacings.tiny),
                  const CircularProgress(value: 0.5, size: BreakpointSize.medium),
                  SizedBox(width: context.spacings.tiny),
                  const CircularProgress(value: 0.5, size: BreakpointSize.large),
                  SizedBox(width: context.spacings.tiny),
                  const CircularProgress(value: 0.5, size: BreakpointSize.gigantic),
                ],
              ),
              SizedBox(height: context.spacings.medium),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: context.spacings.tiny),
                  const LinearProgress(width: 150, value: 0.5, size: BreakpointSize.tiny),
                  SizedBox(width: context.spacings.tiny),
                  const LinearProgress(width: 150, value: 0.5, size: BreakpointSize.small),
                  SizedBox(width: context.spacings.tiny),
                  const LinearProgress(width: 150, value: 0.5, size: BreakpointSize.medium),
                  SizedBox(width: context.spacings.tiny),
                  const LinearProgress(width: 150, value: 0.5, size: BreakpointSize.large),
                  SizedBox(width: context.spacings.tiny),
                  const LinearProgress(width: 150, value: 0.5, size: BreakpointSize.gigantic),
                ],
              ),
              SizedBox(height: context.spacings.medium),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: context.spacings.tiny),
                  const LinearProgress(width: 150, value: 0.5, showPin: true, showMaxLabel: true, showMinLabel: true, size: BreakpointSize.tiny),
                  SizedBox(width: context.spacings.tiny),
                  const LinearProgress(width: 150, value: 0.5, showPin: true, showMaxLabel: true, showMinLabel: true, size: BreakpointSize.small),
                  SizedBox(width: context.spacings.tiny),
                  const LinearProgress(width: 150, value: 0.5, showPin: true, showMaxLabel: true, showMinLabel: true, size: BreakpointSize.medium),
                  SizedBox(width: context.spacings.tiny),
                  const LinearProgress(width: 150, value: 0.5, showPin: true, showMaxLabel: true, showMinLabel: true, size: BreakpointSize.large),
                  SizedBox(width: context.spacings.tiny),
                  const LinearProgress(width: 150, value: 0.5, showPin: true, showMaxLabel: true, showMinLabel: true, size: BreakpointSize.gigantic),
                ],
              ),
              SizedBox(height: context.spacings.medium),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: context.spacings.tiny),
                  LinearLoader(width: 150, size: BreakpointSize.tiny, active: _active),
                  SizedBox(width: context.spacings.tiny),
                  LinearLoader(width: 150, size: BreakpointSize.small, active: _active),
                  SizedBox(width: context.spacings.tiny),
                  LinearLoader(width: 150, size: BreakpointSize.medium, active: _active),
                  SizedBox(width: context.spacings.tiny),
                  LinearLoader(width: 150, size: BreakpointSize.large, active: _active),
                  SizedBox(width: context.spacings.tiny),
                  LinearLoader(width: 150, size: BreakpointSize.gigantic, active: _active),
                ],
              ),
            ],
          ),
        ),
      );
}
