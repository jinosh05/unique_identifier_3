import 'package:flutter_test/flutter_test.dart';
import 'package:unique_identifier_3/unique_identifier_3.dart';

void main() {
  group('UniqueIdentifier', () {
    // These tests rely on actual platform behavior (device/emulator)
    // Ensure the device/emulator has a valid identifier

    test('should get a non-null identifier from platform', () async {
      // Act
      final identifier = await UniqueIdentifier.serial;

      // Assert
      expect(identifier, isNotNull);
    });

    test('should get a non-empty identifier from platform', () async {
      // Act
      final identifier = await UniqueIdentifier.serial;

      // Assert
      expect(identifier!.isNotEmpty, true);
    });
  });
}
