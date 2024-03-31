import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'unique_identifier_3_method_channel.dart';

abstract class UniqueIdentifier_3Platform extends PlatformInterface {
  /// Constructs a UniqueIdentifier_3Platform.
  UniqueIdentifier_3Platform() : super(token: _token);

  static final Object _token = Object();

  static UniqueIdentifier_3Platform _instance = MethodChannelUniqueIdentifier_3();

  /// The default instance of [UniqueIdentifier_3Platform] to use.
  ///
  /// Defaults to [MethodChannelUniqueIdentifier_3].
  static UniqueIdentifier_3Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UniqueIdentifier_3Platform] when
  /// they register themselves.
  static set instance(UniqueIdentifier_3Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
