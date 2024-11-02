part of '../composites.dart';

class _Toast extends StatefulWidget {
  const _Toast();

  @override
  State<_Toast> createState() => _ToastState();
}

class _ToastState extends State<_Toast> {
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
                child: Text("Toast", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.medium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Popover.hovering(
                      content: const Text("Press me"),
                      child: Button.icon(
                        icon: Icon(
                          Icons.man,
                          color: context.colors.main,
                        ),
                        onTap: () => Toast.show(
                          context,
                          label: const Text("I am toast"),
                        ),
                      ),
                    ),
                    Popover.hovering(
                      content: const Text("Press me"),
                      child: Button.icon(
                        icon: Icon(
                          Icons.info,
                          color: context.colors.information,
                        ),
                        onTap: () => Toast.show(
                          context,
                          variant: ToastVariant.information,
                          alignment: Alignment.center,
                          leading: const Icon(Icons.info),
                          trailing: Button.icon(
                            icon: const Icon(Icons.clear),
                            onTap: () {},
                          ),
                          label: const Text("I am information"),
                          content: const Text("Information"),
                        ),
                      ),
                    ),
                    Popover.hovering(
                      content: const Text("Press me"),
                      child: Button.icon(
                        icon: Icon(
                          Icons.error,
                          color: context.colors.success,
                        ),
                        onTap: () => Toast.show(
                          context,
                          variant: ToastVariant.success,
                          alignment: Alignment.bottomCenter,
                          leading: const Icon(Icons.done),
                          trailing: Button.icon(
                            icon: const Icon(Icons.clear),
                            onTap: () {},
                          ),
                          label: const Text("I am success"),
                          content: const Text("Success"),
                        ),
                      ),
                    ),
                    Popover.hovering(
                      content: const Text("Press me"),
                      child: Button.icon(
                        icon: Icon(
                          Icons.error,
                          color: context.colors.error,
                        ),
                        onTap: () => Toast.show(
                          context,
                          variant: ToastVariant.error,
                          alignment: Alignment.bottomCenter,
                          leading: const Icon(Icons.error),
                          trailing: Button.icon(
                            icon: const Icon(Icons.clear),
                            onTap: () {},
                          ),
                          label: const Text("I am error"),
                          content: const Text("Error"),
                        ),
                      ),
                    ),
                    Popover.hovering(
                      content: const Text("Press me"),
                      child: Button.icon(
                        icon: Icon(
                          Icons.warning,
                          color: context.colors.warning,
                        ),
                        onTap: () => Toast.show(
                          context,
                          variant: ToastVariant.warning,
                          alignment: Alignment.center,
                          leading: const Icon(Icons.warning),
                          trailing: Button.icon(
                            icon: const Icon(Icons.clear),
                            onTap: () {},
                          ),
                          label: const Text("I am warning"),
                          content: const Text("Warning"),
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
