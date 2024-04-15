part of '../primitives.dart';

class _Alert extends StatefulWidget {
  const _Alert();

  @override
  State<_Alert> createState() => _AlertState();
}

class _AlertState extends State<_Alert> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(shape: SquircleBorder(borderRadius: context.borders.medium.squircle(context), side: BorderSide(color: context.colors.border))),
      child: Padding(
        padding: EdgeInsets.all(context.spacings.small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(context.spacings.small),
              child: Text("Alert", style: context.typography.base.titleLarge),
            ),
            Padding(
              padding: EdgeInsets.all(context.spacings.medium),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(context.spacings.small),
                      child: const Alert(
                        showBorder: true,
                        label: Text("ALARMA!"),
                        show: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(context.spacings.small),
                      child: const Alert(
                        showBorder: true,
                        leading: Icon(Icons.alarm),
                        label: Text("ALARMA!"),
                        show: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(context.spacings.small),
                      child: Alert(
                        showBorder: true,
                        leading: const Icon(Icons.alarm),
                        trailing: Button.icon(
                          icon: const Icon(Icons.clear),
                          onTap: () {},
                        ),
                        label: const Text("ALARMA!"),
                        show: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(context.spacings.small),
                      child: Alert(
                        showBorder: true,
                        leading: const Icon(Icons.alarm),
                        trailing: Button.icon(
                          icon: const Icon(Icons.clear),
                          onTap: () {},
                        ),
                        label: const Text("ALARMA!"),
                        content: const Text("Content"),
                        show: true,
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
}
