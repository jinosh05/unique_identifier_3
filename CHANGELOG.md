## 0.1.1

* Migrated iOS to latest Flutter plugin SDK (Swift Package Manager)
* Renamed iOS `pluginClass` to `SwiftUniqueIdentifierPlugin`
* Updated `unique_identifier_3.podspec`: iOS deployment target `12.0`, Swift `5.0`, `DEFINES_MODULE`, excluded `i386` simulator arch
* Updated `Package.swift`: added `FlutterFramework` dependency and iOS `12.0` platform
* Added `UniqueIdentifier_3Plugin` compatibility alias for older `GeneratedPluginRegistrant`
* Migrated example iOS Runner (Swift `AppDelegate`, `Info.plist`, `Podfile`, Xcode project and scheme)
* Added `analysis_options.yaml` with `flutter_lints`

## 0.1.0

* Added support for **Web**, **macOS**, **Linux**, and **Windows** platforms
* **Web**: Retrieves UUID from `localStorage`, with browser fingerprint and random generation fallbacks
* **macOS**: Retrieves `IOPlatformUUID` via IOKit (uses `kIOMainPortDefault` on macOS 12+, falls back to `kIOMasterPortDefault` for macOS 11)
* **Linux**: Reads `/etc/machine-id`
* **Windows**: Reads `MachineGuid` from registry `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography`
* Fixed iOS implementation to use `UIDevice.identifierForVendor` instead of custom UUID
* Added Swift Package Manager support via `Package.swift`
* Updated `flutter_lints` to `^6.0.0`

## 0.0.1

* Initial release with Android and iOS support
