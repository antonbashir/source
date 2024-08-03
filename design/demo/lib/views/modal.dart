part of '../views.dart';

class _Modal extends StatefulWidget {
  const _Modal();

  @override
  State<_Modal> createState() => _ModalState();
}

class _ModalState extends State<_Modal> {
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
                child: Text("Modal", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.medium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Button.icon(
                      icon: const Icon(Icons.help_center),
                      onTap: () => setState(
                        () {
                          showModal(
                            context: context,
                            builder: (context) => Modal(
                              child: Alert(
                                width: 350,
                                height: 150,
                                label: const Text("Helping information"),
                                content: const Text("More content"),
                                trailing: Button.icon(
                                  icon: const Icon(Icons.clear, color: Colors.white),
                                  onTap: () => setState(() => Navigator.of(context).pop()),
                                ),
                              ),
                            ),
                          );
                        },
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
