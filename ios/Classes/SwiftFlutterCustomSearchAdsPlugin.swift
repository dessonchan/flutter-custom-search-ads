import Flutter
import UIKit

var instanceManager: AdInstanceManager?

public class SwiftFlutterCustomSearchAdsPlugin: NSObject, FlutterPlugin {
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    
      let channel = FlutterMethodChannel(name: "plugins.dessonchan.com/flutter-custom-search-ads", binaryMessenger: registrar.messenger())
      instanceManager = AdInstanceManager(channel: channel)
      let factory = CustomSearchAdsViewFactory(messenger: registrar.messenger())
    
      let instance = SwiftFlutterCustomSearchAdsPlugin()
      
      registrar.addMethodCallDelegate(instance, channel: channel) 
      registrar.register(factory, withId: "customSearchAds")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch call.method {
        case "onAdLoad":
          if let arguments = call.arguments as? Dictionary<String, Any> {
              if let adId : Int = arguments["adId"] as? Int {
                  instanceManager?.loadAd(adId: adId, arguments: arguments)
                  result(nil)
              }
          }
        default:
          break;
      }
  }
}
