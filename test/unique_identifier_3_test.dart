import 'package:flutter_test/flutter_test.dart';
import 'package:unique_identifier_3/unique_identifier_3.dart';
import 'package:unique_identifier_3/unique_identifier_3_platform_interface.dart';
import 'package:unique_identifier_3/unique_identifier_3_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUniqueIdentifier_3Platform
    with MockPlatformInterfaceMixin
    implements UniqueIdentifier_3Platform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final UniqueIdentifier_3Platform initialPlatform = UniqueIdentifier_3Platform.instance;

  test('$MethodChannelUniqueIdentifier_3 is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUniqueIdentifier_3>());
  });

  test('getPlatformVersion', () async {
    UniqueIdentifier_3 uniqueIdentifier_3Plugin = UniqueIdentifier_3();
    MockUniqueIdentifier_3Platform fakePlatform = MockUniqueIdentifier_3Platform();
    UniqueIdentifier_3Platform.instance = fakePlatform;

    expect(await uniqueIdentifier_3Plugin.getPlatformVersion(), '42');
  });
}
