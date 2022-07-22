import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_custom_search_ads_method_channel.dart';

abstract class FlutterCustomSearchAdsPlatform extends PlatformInterface {
  /// Constructs a FlutterCustomSearchAdsPlatform.
  FlutterCustomSearchAdsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterCustomSearchAdsPlatform _instance = MethodChannelFlutterCustomSearchAds();

  /// The default instance of [FlutterCustomSearchAdsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterCustomSearchAds].
  static FlutterCustomSearchAdsPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterCustomSearchAdsPlatform] when
  /// they register themselves.
  static set instance(FlutterCustomSearchAdsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
