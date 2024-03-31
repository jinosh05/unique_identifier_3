import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unique_identifier_3/unique_identifier_3_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelUniqueIdentifier_3 platform = MethodChannelUniqueIdentifier_3();
  const MethodChannel channel = MethodChannel('unique_identifier_3');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
