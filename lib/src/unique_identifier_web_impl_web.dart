import 'dart:async';
import 'dart:math';
import 'package:web/web.dart' as web;

Future<String?> getUniqueIdentifier() async {
  const storageKey = 'unique_identifier_3_uuid';
  String? uuid = web.window.localStorage.getItem(storageKey);
  if (uuid == null || !_isValidUuid(uuid)) {
    uuid = _generateFromFingerprint() ?? _generateUuid();
    web.window.localStorage.setItem(storageKey, uuid);
  }
  return uuid;
}

bool _isValidUuid(String uuid) {
  final uuidRegex = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
    caseSensitive: false,
  );
  return uuidRegex.hasMatch(uuid);
}

String? _generateFromFingerprint() {
  try {
    final navigator = web.window.navigator;
    final screen = web.window.screen;
    final components = [
      navigator.userAgent,
      navigator.language,
      navigator.platform,
      screen.width.toString(),
      screen.height.toString(),
      screen.colorDepth.toString(),
      DateTime.now().timeZoneOffset.inMinutes.toString(),
    ];
    final fingerprint = components.join('|');
    final hash = _simpleHash(fingerprint.codeUnits);
    return _formatUuid(hash);
  } catch (e) {
    return null;
  }
}

String _simpleHash(List<int> bytes) {
  int h = 0;
  for (final byte in bytes) {
    h = ((h << 5) - h + byte) & 0xFFFFFFFF;
  }
  return h.toRadixString(16).padLeft(8, '0');
}

String _formatUuid(String hash) {
  final padded = hash.padRight(32, '0');
  return '${padded.substring(0, 8)}-${padded.substring(8, 12)}-4${padded.substring(13, 16)}-${padded.substring(16, 20)}-${padded.substring(20, 32)}';
}

String _generateUuid() {
  final random = Random.secure();
  final bytes = List<int>.generate(16, (_) => random.nextInt(256));
  bytes[6] = (bytes[6] & 0x0f) | 0x40;
  bytes[8] = (bytes[8] & 0x3f) | 0x80;
  return [
    bytes.sublist(0, 4),
    bytes.sublist(4, 6),
    bytes.sublist(6, 8),
    bytes.sublist(8, 10),
    bytes.sublist(10, 16),
  ].map((b) => b.map((e) => e.toRadixString(16).padLeft(2, '0')).join()).join('-');
}
