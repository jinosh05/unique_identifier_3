import Flutter
import UIKit

public class SwiftUniqueIdentifierPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "unique_identifier", binaryMessenger: registrar.messenger())
    let instance = SwiftUniqueIdentifierPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
  if call.method == "getUniqueIdentifier" {
    let userDefaults = UserDefaults.standard
    var uniqueID = userDefaults.string(forKey: "custom_unique_identifier")
    if uniqueID == nil {
      uniqueID = UUID().uuidString
      userDefaults.set(uniqueID, forKey: "custom_unique_identifier")
      userDefaults.synchronize()
    }
    result(uniqueID)
  } else {
    result(FlutterMethodNotImplemented)
  }
}
}