import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_custom_search_ads/flutter_custom_search_ads.dart';
import 'package:flutter_custom_search_ads/flutter_custom_search_ads_platform_interface.dart';
import 'package:flutter_custom_search_ads/flutter_custom_search_ads_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterCustomSearchAdsPlatform 
    with MockPlatformInterfaceMixin
    implements FlutterCustomSearchAdsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterCustomSearchAdsPlatform initialPlatform = FlutterCustomSearchAdsPlatform.instance;

  test('$MethodChannelFlutterCustomSearchAds is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterCustomSearchAds>());
  });

  test('getPlatformVersion', () async {
    FlutterCustomSearchAds flutterCustomSearchAdsPlugin = FlutterCustomSearchAds();
    MockFlutterCustomSearchAdsPlatform fakePlatform = MockFlutterCustomSearchAdsPlatform();
    FlutterCustomSearchAdsPlatform.instance = fakePlatform;
  
    expect(await flutterCustomSearchAdsPlugin.getPlatformVersion(), '42');
  });
}
