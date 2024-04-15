import 'dart:ui';

import 'package:source_demo/composites.dart';
import 'package:source_demo/layouts.dart';
import 'package:source_demo/primitives.dart';
import 'package:source_demo/views.dart';
import 'package:creator/creator.dart';
import 'package:design/design.dart';
import 'package:flutter/widgets.dart';
  
void main() => Configurator.navigable(
      wrapper: (configurator) => CreatorGraph(
        observer: const DefaultCreatorObserver(
          logDerived: false,
          logDispose: false,
          logInReleaseMode: false,
          logState: false,
          logWatcher: false,
          logStateChange: false,
        ),
        child: configurator,
      ),
      navigatingConfiguration: NavigatingConfiguration(
        home: const Screen(child: _Main()),
      ),
    );

class _Main extends StatelessWidget {
  const _Main();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            color: context.colors.layer,
            child: Padding(
              padding: EdgeInsets.all(context.spacings.medium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("The Design", style: context.typography.base.displaySmall),
                  Row(
                    children: [
                      const Text("Light/Dark"),
                      SizedBox(
                        width: context.spacings.small,
                      ),
                      Switch(
                        value: Theme.of(context).brightness == Brightness.dark ? true : false,
                        onChanged: null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const HorizontalDivider(height: 0),
          Expanded(child: _Content()),
        ],
      );
}

class _Content extends StatefulWidget {
  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) => Sidebar(
        expandedContent: true,
        tabBarBackgroundColor: context.colors.layer,
        trailing: const _ThemeCustomize(),
        tabs: [
          SidebarTab(leading: const Icon(Icons.text_fields), label: const Text("Primitives")),
          SidebarTab(leading: const Icon(Icons.group), label: const Text("Composites")),
          SidebarTab(leading: const Icon(Icons.view_array), label: const Text("Views")),
          SidebarTab(leading: const Icon(Icons.layers), label: const Text("Layouts")),
        ],
        content: (context, selected) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(context.spacings.medium),
            child: switch (selected) {
              0 => const Primitives(),
              1 => const Composites(),
              2 => const Views(),
              3 => const Layouts(),
              _ => Container(),
            },
          ),
        ),
      );
}

class _ThemeCustomize extends StatelessWidget {
  const _ThemeCustomize();

  @override
  Widget build(BuildContext context) => Expanded(
        child: Padding(
          padding: EdgeInsets.all(context.spacings.small),
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 3 / 2,
            children: [
              Colors.white,
              Colors.black,
              context.palette.slate.shade400,
              context.palette.gray.shade400,
              context.palette.zinc.shade400,
              context.palette.neutral.shade400,
              context.palette.stone.shade400,
              context.palette.red.shade400,
              context.palette.orange.shade400,
              context.palette.amber.shade400,
              context.palette.yellow.shade400,
              context.palette.lime.shade400,
              context.palette.green.shade400,
              context.palette.emerald.shade400,
              context.palette.teal.shade400,
              context.palette.cyan.shade400,
              context.palette.sky.shade400,
              context.palette.blue.shade400,
              context.palette.indigo.shade400,
              context.palette.violet.shade400,
              context.palette.purple.shade400,
              context.palette.fuchsia.shade400,
              context.palette.pink.shade400,
              context.palette.rose.shade400,
            ]
                .map(
                  (color) => Button.icon(
                    showPulseEffect: context.tokens.colors.main == color,
                    size: BreakpointSize.tiny,
                    minTouchTargetSize: 8,
                    width: 8,
                    height: 8,
                    icon: Container(
                      width: 8,
                      height: 8,
                      decoration: ShapeDecoration(
                        color: color,
                        shape: const CircleBorder(),
                      ),
                    ),
                    onTap: () => Configurator.overrideTheme(
                      context,
                      (current) => current.mutate(
                        current.tokens.copyWith(
                          colors: current.tokens.colors.copyWith(main: color),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
}
