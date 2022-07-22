import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_custom_search_ads_platform_interface.dart';

/// An implementation of [FlutterCustomSearchAdsPlatform] that uses method channels.
class MethodChannelFlutterCustomSearchAds extends FlutterCustomSearchAdsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_custom_search_ads');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
