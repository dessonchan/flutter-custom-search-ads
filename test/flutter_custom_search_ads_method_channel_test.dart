import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_custom_search_ads/flutter_custom_search_ads_method_channel.dart';

void main() {
  MethodChannelFlutterCustomSearchAds platform = MethodChannelFlutterCustomSearchAds();
  const MethodChannel channel = MethodChannel('flutter_custom_search_ads');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
