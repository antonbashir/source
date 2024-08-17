part of '../layouts.dart';

class _Tabs extends StatefulWidget {
  const _Tabs();

  @override
  State<_Tabs> createState() => _TabsState();
}

class _TabsState extends State<_Tabs> {
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
                child: Text("Tabs", style: context.typography.base.titleLarge),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(context.spacings.small),
                    child: DecoratedBox(
                      decoration: ShapeDecoration(color: context.colors.surface, shape: SquircleBorder(borderRadius: context.borders.medium.squircle(context))),
                      child: TabBar(
                        tabs: const [
                          Tab(leading: Icon(Icons.tab), label: Text("Tab 1")),
                          Tab(leading: Icon(Icons.tab), label: Text("Tab 2")),
                          Tab(leading: Icon(Icons.tab), label: Text("Tab 3")),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(context.spacings.small),
                    child: DecoratedBox(
                      decoration: ShapeDecoration(color: context.colors.surface, shape: SquircleBorder(borderRadius: context.borders.medium.squircle(context))),
                      child: TabBar.pill(
                        pillTabs: const [
                          PillTab(leading: Icon(Icons.tab), label: Text("Tab 1")),
                          PillTab(leading: Icon(Icons.tab), label: Text("Tab 2")),
                          PillTab(leading: Icon(Icons.tab), label: Text("Tab 3")),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(context.spacings.small),
                    child: DecoratedBox(
                      decoration: ShapeDecoration(color: context.colors.surface, shape: SquircleBorder(borderRadius: context.borders.medium.squircle(context))),
                      child: TabBar.custom(
                        customTabs: [
                          (context, selected) => Container(
                                padding: EdgeInsets.all(context.spacings.small),
                                decoration: ShapeDecoration(
                                  color: selected ? context.colors.accent : context.colors.neutral,
                                  shape: SquircleBorder(borderRadius: context.borders.medium.squircle(context)),
                                ),
                                child: const Text("Tab 1"),
                              ),
                          (context, selected) => Container(
                                padding: EdgeInsets.all(context.spacings.small),
                                decoration: ShapeDecoration(
                                  color: selected ? context.colors.accent : context.colors.neutral,
                                  shape: SquircleBorder(borderRadius: context.borders.medium.squircle(context)),
                                ),
                                child: const Text("Tab 2"),
                              ),
                          (context, selected) => Container(
                                padding: EdgeInsets.all(context.spacings.small),
                                decoration: ShapeDecoration(
                                  color: selected ? context.colors.accent : context.colors.neutral,
                                  shape: SquircleBorder(borderRadius: context.borders.medium.squircle(context)),
                                ),
                                child: const Text("Tab 3"),
                              ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
