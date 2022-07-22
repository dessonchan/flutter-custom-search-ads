
import 'flutter_custom_search_ads_platform_interface.dart';

class FlutterCustomSearchAds {
  Future<String?> getPlatformVersion() {
    return FlutterCustomSearchAdsPlatform.instance.getPlatformVersion();
  }
}
