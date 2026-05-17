# Unique Identifier

[![pub package](https://img.shields.io/badge/pub-0.1.0-green.svg)](https://pub.dartlang.org/packages/unique_identifier_3)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A Flutter plugin for retrieving a device's unique identifier across Android, iOS, Web, macOS, Linux, and Windows platforms.

| Platform | Method |
|----------|--------|
| 🤖 **Android** | `ANDROID_ID` (scoped to app-signing key, user, and device) |
| 🍎 **iOS** | `UIDevice.identifierForVendor` |
| 💻 **macOS** | `IOPlatformUUID` via IOKit (uses `kIOMainPortDefault` on macOS 12+, falls back to `kIOMasterPortDefault` for macOS 11) |
| 🐧 **Linux** | Reads `/etc/machine-id` |
| 🪟 **Windows** | Reads registry value `MachineGuid` from `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography` |
| 🌐 **Web** | Attempts to read UUID from `localStorage`. If missing/invalid, generates from browser fingerprint. Falls back to random UUID generation. Stores result in `localStorage` for persistence. |

## Features

- **Android**: Retrieves `ANDROID_ID` (64-bit hex string scoped to app-signing key, user, and device)
- **iOS**: Retrieves `identifierForVendor` (IDFV unique per vendor)
- **macOS**: Retrieves `IOPlatformUUID` via IOKit framework
- **Linux**: Reads `/etc/machine-id`
- **Windows**: Reads `MachineGuid` from registry
- **Web**: Generates/persists UUID via `localStorage` with fingerprint fallback
- Cross-platform support with a single API
- Privacy-compliant device tracking
- Swift Package Manager support on iOS

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  unique_identifier_3: ^0.1.0
```

Then run:

```bash
flutter pub get
```

### Import the Package

```dart
import 'package:unique_identifier_3/unique_identifier_3.dart';
```

## Usage

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unique_identifier_3/unique_identifier_3.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _identifier = 'Unknown';

  @override
  void initState() {
    super.initState();
    initUniqueIdentifier();
  }

  Future<void> initUniqueIdentifier() async {
    String identifier;
    try {
      identifier = await UniqueIdentifier.serial;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;

    setState(() {
      _identifier = identifier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Unique Identifier Example'),
        ),
        body: Center(
          child: Text('Device ID: $_identifier'),
        ),
      ),
    );
  }
}
```

## Platform-Specific Behavior

### Android

- Uses `ANDROID_ID`, a 64-bit hexadecimal string
- Unique to each combination of app-signing key, user, and device
- Value may change after:
  - Factory reset
  - App-signing key change

### iOS

- Uses `identifierForVendor` (IDFV)
- Unique per vendor across all apps from the same vendor
- Value may change if:
  - All apps from the vendor are uninstalled and reinstalled

### macOS

- Uses `IOPlatformUUID` via IOKit framework
- Automatically uses `kIOMainPortDefault` on macOS 12+ (no deprecation warning)
- Falls back to `kIOMasterPortDefault` for compatibility with macOS 11 and earlier

### Linux

- Reads `/etc/machine-id`
- Returns the machine ID as stored by the system

### Windows

- Reads `MachineGuid` from registry key `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography`
- Returns the system's unique machine identifier

### Web

- Attempts to read a UUID from `window.localStorage`
- If the value is missing or invalid, it tries to generate one based on browser fingerprint
- If fingerprinting fails, generates a new UUID using Dart code
- The newly generated UUID is stored in `localStorage` for future reuse
- Ensures the same UUID persists across reloads and sessions
- Users can manually clear the UUID through browser storage settings

## Notes

- On iOS and Android, the UUID may change after uninstalling and reinstalling the app
- macOS implementation avoids deprecated APIs on macOS 12+
- On Web, the UUID persists across reloads and sessions but can be cleared by the user

## iOS App Tracking Transparency

If your app uses tracking on iOS, consider requesting App Tracking Transparency (ATT) permission. Below is an example using the `app_tracking_transparency` package:

```dart
import 'package:flutter/material.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> initTrackingTransparency(BuildContext context) async {
  final status = await AppTrackingTransparency.trackingAuthorizationStatus;

  if (status == TrackingStatus.notDetermined || status == TrackingStatus.denied) {
    await showCustomTrackingDialog(
      context,
      'We use tracking to enhance your experience and provide personalized content and ads.',
    );

    await Future.delayed(const Duration(milliseconds: 1000));

    final newStatus = await AppTrackingTransparency.requestTrackingAuthorization();
    if (newStatus == TrackingStatus.notDetermined || newStatus == TrackingStatus.denied) {
      await showSettingsDialog(
        context,
        'Please enable tracking in Settings > Privacy & Security > Tracking.',
      );
    }
  }

  final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
  if (uuid == '00000000-0000-0000-0000-000000000000') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Unable to track your device")),
    );
  }
}

Future<void> showCustomTrackingDialog(BuildContext context, String message) async {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Attention'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Continue'),
        ),
      ],
    ),
  );
}

Future<void> showSettingsDialog(BuildContext context, String message) async {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Settings Required'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () async {
            const url = 'app-settings:';
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            }
            Navigator.pop(context);
          },
          child: const Text('Settings'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Not Now'),
        ),
      ],
    ),
  );
}
```

## Bugs & Feature Requests

Please [open an issue](https://github.com/jinosh05/unique_identifier_3/issues) on GitHub for bugs or feature requests. Pull requests are welcome!

## License

This project is licensed under the [MIT License](LICENSE).
