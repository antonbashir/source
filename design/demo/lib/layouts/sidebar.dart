part of '../layouts.dart';

class _Sidebar extends StatefulWidget {
  const _Sidebar();

  @override
  State<_Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<_Sidebar> {
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
                child: Text("Sidebar", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.small),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 350,
                        child: Sidebar(
                          drawerWidth: 150,
                          expandedContent: true,
                          content: (context, index) => switch (index) {
                            0 => const Center(child: Text("First screen")),
                            1 => const Center(child: Text("Second screen")),
                            2 => const Center(child: Text("Third screen")),
                            _ => Container(),
                          },
                          tabs: [
                            SidebarTab(leading: const Icon(Icons.tab), label: const Text("Tab 1")),
                            SidebarTab(leading: const Icon(Icons.tab), label: const Text("Tab 2")),
                            SidebarTab(leading: const Icon(Icons.tab), label: const Text("Tab 3")),
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
