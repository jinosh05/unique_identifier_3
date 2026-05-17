import 'dart:async';
import 'package:flutter/services.dart';

export 'src/linux_unique_identifier.dart';
export 'src/macos_unique_identifier.dart';
export 'src/web_unique_identifier.dart';
export 'src/windows_unique_identifier.dart';

abstract class UniqueIdentifierPlatform {
  Future<String?> getUniqueIdentifier();
}

class MethodChannelUniqueIdentifier extends UniqueIdentifierPlatform {
  static const MethodChannel _channel = MethodChannel('unique_identifier');

  @override
  Future<String?> getUniqueIdentifier() async {
    final String? identifier = await _channel.invokeMethod('getUniqueIdentifier');
    return identifier;
  }
}

class UniqueIdentifier {
  static UniqueIdentifierPlatform _platform = MethodChannelUniqueIdentifier();

  static set platform(UniqueIdentifierPlatform platform) {
    _platform = platform;
  }

  static Future<String?> get serial async {
    return await _platform.getUniqueIdentifier();
  }
}
