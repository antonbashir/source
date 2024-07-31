import 'package:flutter/widgets.dart';

class FutureLoader<T> extends StatefulWidget {
  final Widget loader;
  final Widget Function(BuildContext context, T data, void Function() refresh) content;
  final Future<T> Function()? provider;
  final Widget Function(dynamic error, StackTrace? stack)? error;
  final Future<T>? future;

  const FutureLoader({
    super.key,
    required this.loader,
    required this.content,
    required this.error,
    this.future,
    this.provider,
  });

  @override
  State<FutureLoader<T>> createState() => _FutureLoaderState<T>();
}

class _FutureLoaderState<T> extends State<FutureLoader<T>> {
  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: widget.provider == null ? widget.future : widget.provider!(),
        builder: (context, state) => state.hasError
            ? widget.error?.call(state.error, state.stackTrace) ?? widget.loader
            : state.hasData
                ? widget.content(context, state.requireData, () => setState(() => {}))
                : widget.loader,
      );
}
