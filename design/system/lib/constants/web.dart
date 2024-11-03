import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

const webBlank = "_blank";

enum UrlStrategy { path, hash, unspecified }

class WebEndpoints {
  WebEndpoints._();

  static String base() => "${web.window.location.protocol}//${web.window.location.host}/ui";
  static String server() => kDebugMode ? const String.fromEnvironment("origin") : "${web.window.location.protocol}//${web.window.location.host}";
  static String ws() => server().replaceFirst("http", "ws");
}
