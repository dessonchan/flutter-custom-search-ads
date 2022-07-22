import 'package:flutter_custom_search_ads/DataModel/Ads/CustomSearchAd.dart';

class CustomSearchAdListener {
  Function(CustomSearchAd ad)? onAdLoaded;
  Function(CustomSearchAd ad)? onAdFailedToLoad;
  Function(CustomSearchAd ad, double height)? onAdHeightChanged;
  Function(CustomSearchAd ad)? onAdOpened;
  Function(CustomSearchAd ad)? onAdImpression;
  Function(CustomSearchAd ad)? onAdWillDismissScreen;
  Function(CustomSearchAd ad)? onAdClosed;
  Function(CustomSearchAd ad)? onAdPresent;

  CustomSearchAdListener({
    this.onAdLoaded,
    this.onAdFailedToLoad,
    this.onAdHeightChanged,
    this.onAdOpened,
    this.onAdImpression,
    this.onAdWillDismissScreen,
    this.onAdClosed,
    this.onAdPresent
  });
}