import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'unique_identifier_3_platform_interface.dart';

/// An implementation of [UniqueIdentifier_3Platform] that uses method channels.
class MethodChannelUniqueIdentifier_3 extends UniqueIdentifier_3Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('unique_identifier_3');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
