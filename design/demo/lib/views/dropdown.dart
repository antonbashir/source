part of '../views.dart';

class _Dropdown extends StatefulWidget {
  const _Dropdown();

  @override
  State<_Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<_Dropdown> {
  var _open = false;
  var _search = "";
  final _allItems = [
    "Item 1",
    "Item 2",
    "Item 3",
  ];
  final _controller = TextEditingController();

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
                child: Text("Dropdown", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.medium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(context.spacings.small),
                      child: Dropdown(
                        maxContentHeight: 350,
                        show: _open,
                        onTapOutside: () => setState(() => _open = false),
                        constrainWidthToChild: true,
                        content: ListView.builder(
                          itemCount: (_allItems.where((element) => _search.isEmpty || element.contains(_search)).toList()).length,
                          itemBuilder: (context, index) => ListItem(
                            key: UniqueKey(),
                            label: Text((_allItems.where((element) => _search.isEmpty || element.contains(_search)).toList())[index]),
                            onTap: () => setState(
                              () {
                                _controller.text = (_allItems.where((element) => _search.isEmpty || element.contains(_search)).toList())[index];
                                _open = false;
                              },
                            ),
                          ),
                        ),
                        child: TextInput(
                          width: 350,
                          hintText: "Write something...",
                          leading: const Icon(Icons.search),
                          onTap: () => setState(() => _open = true),
                          onChanged: (value) => setState(() {
                            _search = value;
                            _open = true;
                          }),
                          controller: _controller,
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
