import 'dart:async';
import 'package:unique_identifier_3/unique_identifier_3.dart';
import 'unique_identifier_web_impl.dart'
    if (dart.library.js_interop) 'unique_identifier_web_impl_web.dart' as impl;

class WebUniqueIdentifierPlugin extends UniqueIdentifierPlatform {
  static void registerWith([dynamic registrar]) {
    UniqueIdentifier.platform = WebUniqueIdentifierPlugin();
  }

  @override
  Future<String?> getUniqueIdentifier() async {
    return impl.getUniqueIdentifier();
  }
}
