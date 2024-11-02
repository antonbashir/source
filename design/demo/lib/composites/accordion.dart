part of '../composites.dart';

class _Accordion extends StatefulWidget {
  const _Accordion();

  @override
  State<_Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<_Accordion> {
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
                child: Text("Accordion", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.medium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(context.theme.tokens.spacings.tiny),
                      child: Accordion(
                        width: 250,
                        leading: const Icon(Icons.person),
                        showBorder: true,
                        maintainState: false,
                        label: const Text("Open me"),
                        size: BreakpointSize.small,
                        childrenPadding: EdgeInsets.all(context.spacings.small),
                        child: Column(
                          children: [
                            ListItem(
                              label: const Text("Item 1"),
                              onTap: () {},
                            ),
                            SizedBox(height: context.spacings.small),
                            ListItem(
                              label: const Text("Item 2"),
                              onTap: () {},
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(context.theme.tokens.spacings.tiny),
                      child: Accordion(
                        width: 250,
                        leading: const Icon(Icons.person),
                        showBorder: true,
                        maintainState: false,
                        label: const Text("Open me"),
                        size: BreakpointSize.medium,
                        childrenPadding: EdgeInsets.all(context.spacings.small),
                        child: Column(
                          children: [
                            ListItem(
                              label: const Text("Item 1"),
                              onTap: () {},
                            ),
                            SizedBox(height: context.spacings.small),
                            ListItem(
                              label: const Text("Item 2"),
                              onTap: () {},
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(context.theme.tokens.spacings.tiny),
                      child: Accordion(
                        width: 250,
                        leading: const Icon(Icons.person),
                        showBorder: true,
                        maintainState: false,
                        label: const Text("Open me"),
                        size: BreakpointSize.large,
                        childrenPadding: EdgeInsets.all(context.spacings.small),
                        child: Column(
                          children: [
                            ListItem(
                              label: const Text("Item 1"),
                              onTap: () {},
                            ),
                            SizedBox(height: context.spacings.small),
                            ListItem(
                              label: const Text("Item 2"),
                              onTap: () {},
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(context.theme.tokens.spacings.tiny),
                      child: Accordion(
                        width: 250,
                        leading: const Icon(Icons.person),
                        showBorder: true,
                        maintainState: false,
                        label: const Text("Open me"),
                        size: BreakpointSize.gigantic,
                        childrenPadding: EdgeInsets.all(context.spacings.small),
                        child: Column(
                          children: [
                            ListItem(
                              label: const Text("Item 1"),
                              onTap: () {},
                            ),
                            SizedBox(height: context.spacings.small),
                            ListItem(
                              label: const Text("Item 2"),
                              onTap: () {},
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
