part of '../views.dart';

class _List extends StatefulWidget {
  const _List();

  @override
  State<_List> createState() => _ListState();
}

class _ListState extends State<_List> {
  final data = List.generate(100, (index) => "item-$index").reversed;
  var _filter = "";
  var _sort = false;
  var _refresh = false;

  late final Timer timer;

  late final refresher = StreamController<DataEvent<String>>();

  late final provider = DynamicListNotifier<String>((offset, limit, filter) => Future.delayed(const Duration(seconds: 1)).then((value) => data.where(filter).skip(offset).take(limit)),
      filter: (element) => _filter.isEmpty || element.contains(_filter),
      sorter: (a, b) => _sort
          ? int.parse(a.substring(a.indexOf("-") + 1)).compareTo(int.parse(b.substring(b.indexOf("-") + 1)))
          : int.parse(b.substring(b.indexOf("-") + 1)).compareTo(int.parse(a.substring(a.indexOf("-") + 1))));

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_refresh) {
        refresher.add(DataEvent.update((element) => true, (element) => "refreshed:${Random().nextInt(1024)}${element.substring(element.indexOf("-"))}"));
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

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
                child: Text("Dynamic List", style: context.typography.base.titleLarge),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(context.spacings.small),
                    child: TextInput(
                      width: 350,
                      hintText: "Filter",
                      onChanged: (value) => setState(() {
                        _filter = value;
                        provider.update();
                      }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(context.spacings.small),
                    child: Label(
                      width: 100,
                      label: const Text("Sort"),
                      trailing: Checkbox(
                        value: _sort,
                        onChanged: (value) => setState(() {
                          _sort = value == true;
                          provider.update(
                              sorter: (a, b) => value == true
                                  ? int.parse(a.substring(a.indexOf("-") + 1)).compareTo(int.parse(b.substring(b.indexOf("-") + 1)))
                                  : int.parse(b.substring(b.indexOf("-") + 1)).compareTo(int.parse(a.substring(a.indexOf("-") + 1))));
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.small),
                child: Row(
                  children: [
                    const Text("Refresh"),
                    SizedBox(width: context.spacings.small),
                    Switch(
                      value: _refresh,
                      onChanged: (value) => setState(() {
                        _refresh = value;
                      }),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.small),
                child: DecoratedBox(
                  decoration: ShapeDecoration(color: context.colors.surface, shape: SquircleBorder(borderRadius: context.borders.medium.squircle(context))),
                  child: DynamicListView<String>(
                    height: 350,
                    pageSize: 10,
                    itemBuilder: (context, item, index) => Label(key: Key(item), label: Text(item), content: const Text("Content")),
                    dataProvider: provider,
                    refreshStream: refresher.stream,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
