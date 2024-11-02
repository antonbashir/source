import 'package:flutter/widgets.dart';

class ListenableListener extends StatefulWidget {
  final Listenable listenable;
  final VoidCallback? listener;
  final Widget child;

  const ListenableListener({
    required this.listenable,
    required this.child,
    this.listener,
    super.key,
  });

  @override
  State<ListenableListener> createState() => _ListenableListenerState();
}

class _ListenableListenerState extends State<ListenableListener> {
  Listenable get _listenable => widget.listenable;

  @override
  void initState() {
    super.initState();
    _listenable.addListener(_handleChange);
    _handleChange();
  }

  @override
  void didUpdateWidget(ListenableListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_listenable != oldWidget.listenable) {
      oldWidget.listenable.removeListener(_handleChange);
      _listenable.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    _listenable.removeListener(_handleChange);
    super.dispose();
  }

  void _handleChange() {
    widget.listener?.call();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
