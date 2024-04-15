part of '../primitives.dart';

class _Inputs extends StatelessWidget {
  const _Inputs();

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
                child: Text("Inputs", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.small),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const TextInput(
                      width: 250,
                      size: BreakpointSize.small,
                      hintText: "Here...",
                      helper: Text("Print something..."),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const TextInput(
                      width: 250,
                      size: BreakpointSize.medium,
                      hintText: "Here...",
                      helper: Text("Print something..."),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const TextInput(
                      width: 250,
                      size: BreakpointSize.large,
                      hintText: "Here...",
                      helper: Text("Print something..."),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const TextInput(
                      width: 250,
                      size: BreakpointSize.gigantic,
                      hintText: "Here...",
                      helper: Text("Print something..."),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.small),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const TextInput(
                      width: 250,
                      size: BreakpointSize.small,
                      hintText: "Here...",
                      helper: Text("Print something..."),
                      leading: Icon(Icons.search),
                      trailing: Icon(Icons.check),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const TextInput(
                      width: 250,
                      size: BreakpointSize.medium,
                      hintText: "Here...",
                      helper: Text("Print something..."),
                      leading: Icon(Icons.search),
                      trailing: Icon(Icons.check),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const TextInput(
                      width: 250,
                      size: BreakpointSize.large,
                      leading: Icon(Icons.search),
                      trailing: Icon(Icons.check),
                      hintText: "Here...",
                      helper: Text("Print something..."),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    const TextInput(
                      width: 250,
                      size: BreakpointSize.gigantic,
                      hintText: "Here...",
                      helper: Text("Print something..."),
                      leading: Icon(Icons.search),
                      trailing: Icon(Icons.check),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.small),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextInput(
                      width: 250,
                      size: BreakpointSize.small,
                      hintText: "Here...",
                      helper: const Text("Print something..."),
                      hasFloatingLabel: true,
                      leading: const Icon(Icons.search),
                      trailing: Padding(
                        padding: EdgeInsets.symmetric(vertical: context.spacings.small),
                        child: Button.icon(
                          size: BreakpointSize.tiny,
                          icon: const Icon(Icons.clear),
                          onTap: () {},
                        ),
                      ),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    TextInput(
                      width: 250,
                      size: BreakpointSize.medium,
                      hintText: "Here...",
                      helper: const Text("Print something..."),
                      hasFloatingLabel: true,
                      leading: const Icon(Icons.search),
                      trailing: Padding(
                        padding: EdgeInsets.symmetric(vertical: context.spacings.small),
                        child: Button.icon(
                          size: BreakpointSize.tiny,
                          icon: const Icon(Icons.clear),
                          onTap: () {},
                        ),
                      ),
                    ),
                    SizedBox(width: context.spacings.tiny),
                    TextInput(
                      width: 250,
                      size: BreakpointSize.large,
                      leading: const Icon(Icons.search),
                      trailing: Padding(
                        padding: EdgeInsets.symmetric(vertical: context.spacings.small),
                        child: Button.icon(
                          size: BreakpointSize.small,
                          icon: const Icon(Icons.clear),
                          onTap: () {},
                        ),
                      ),
                      hintText: "Here...",
                      helper: const Text("Print something..."),
                      hasFloatingLabel: true,
                    ),
                    SizedBox(width: context.spacings.tiny),
                    TextInput(
                      width: 250,
                      size: BreakpointSize.gigantic,
                      hintText: "Here...",
                      helper: const Text("Print something..."),
                      leading: const Icon(Icons.search),
                      hasFloatingLabel: true,
                      trailing: Padding(
                        padding: EdgeInsets.symmetric(vertical: context.spacings.small),
                        child: Button.icon(
                          icon: const Icon(Icons.clear),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.small),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const TextArea(
                      hintText: "Here...",
                      width: 1000,
                      height: 150,
                      helper: Text("Print something..."),
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
