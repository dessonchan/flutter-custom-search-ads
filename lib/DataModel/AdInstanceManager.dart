import 'package:flutter/services.dart';
import 'package:flutter_custom_search_ads/DataModel/Ads/CustomSearchAd.dart';

AdInstanceManager instanceManager = AdInstanceManager();

class AdInstanceManager {
  Map<int, CustomSearchAd> _loadedAds = {};
  int _nextAdId = 0;
  late MethodChannel channel;

  AdInstanceManager() {
    channel = const MethodChannel('plugins.dessonchan.com/flutter-custom-search-ads');
    channel.setMethodCallHandler((call) async {
      final int? adId = call.arguments['adId'];
      final String eventName = call.method;
      if (adId != null) {
        final CustomSearchAd? ad = adFor(adId);
        if (ad != null) {
          _onAdEvent(ad, eventName, Map<String, dynamic>.from(call.arguments));
        }
      }
    });
  }

  _onAdEvent(CustomSearchAd ad, String event, Map<String, dynamic> arguments) {
    switch(event) {
      case "onAdLoaded":
        ad.onAdLoad();
        break;
      case "onAdFailedToLoad":
        ad.onAdFailedToLoad();
        break;
      case "onAdHeightChanged":
        ad.onAdHeightChanged(arguments['height']);
        break;
      case "onAdPresent":
        ad.onAdPresent();
        break;
      case "onAdImpression":
        ad.onAdImpression();
        break;
      case "onAdOpen":
        ad.onAdOpen();
        break;
      case "onAdClosed":
        ad.onAdClosed();
        break;
      case "onAdWillDismissScreen":
        ad.onAdWillDismissScreen();
        break;
      default:
        return;
    }
  }

  CustomSearchAd? adFor(adId) {
    try {
      return _loadedAds[adId];
    } catch(_) {
      return null;
    }
  }

  int? adIdFor(CustomSearchAd ad) {
    try {
      return _loadedAds.entries.firstWhere((element) => element.value == ad).key;
    } catch (_) {
      return null;
    }
  }

  Future<void> load(CustomSearchAd ad) {
    if (adIdFor(ad) != null) {
      return Future<void>.value();
    }

    final int adId = _nextAdId++;
    _loadedAds[adId] = ad;
    return channel.invokeMethod("onAdLoad", {
      'adId': adId,
      ...ad.toPlatformArgs()
    });
  }
}