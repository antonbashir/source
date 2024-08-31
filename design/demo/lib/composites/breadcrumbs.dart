part of '../composites.dart';

class _Breadcrumbs extends StatefulWidget {
  const _Breadcrumbs();

  @override
  State<_Breadcrumbs> createState() => _BreadcrumbsState();
}

class _BreadcrumbsState extends State<_Breadcrumbs> {
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
                child: Text("Breadcrumbs", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.small),
                child: Row(
                  children: [
                    Breadcrumbs(
                      visibleItemCount: 2,
                      items: [
                        BreadcrumbItem(leading: const Icon(Icons.folder), label: const Text("Root"), onTap: () {}),
                        BreadcrumbItem(leading: const Icon(Icons.folder), label: const Text("Parent"), onTap: () {}),
                        BreadcrumbItem(leading: const Icon(Icons.edit_document), label: const Text("Child"), onTap: () {}),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
