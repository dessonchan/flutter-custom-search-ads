import 'package:flutter/foundation.dart';
import 'package:flutter_custom_search_ads/DataModel/AdInstanceManager.dart';

import 'CustomSearchAdListener.dart';
import 'CustomSearchAdRequest.dart';

class CustomSearchAd {
  late String adUnitId;
  late CustomSearchAdRequest request;
  late CustomSearchAdListener listener;

  ValueNotifier<double> adHeight = ValueNotifier<double>(0);

  CustomSearchAd({
    required this.adUnitId,
    required this.request,
    required this.listener,
  });

  load() {
    instanceManager.load(this);
  }

  Map<String, dynamic> toPlatformArgs() {
    return {
      'adUnitId': adUnitId,
      ...request.toPlatformArgs(),
    };
  }

  onAdLoad() {
    print("onAdLoaded");
    if (listener.onAdLoaded != null) {
      listener.onAdLoaded!(this);
    }
  }

  onAdFailedToLoad() {
    if (listener.onAdFailedToLoad != null) {
      listener.onAdFailedToLoad!(this);
    }
  }

  onAdHeightChanged(double height) {
    if (listener.onAdHeightChanged != null) {
      listener.onAdHeightChanged!(this, height);
    }
    adHeight.value = height;
  }

  onAdImpression() {
    if (listener.onAdImpression != null) {
      listener.onAdImpression!(this);
    }
  }

  onAdOpen() {
    if (listener.onAdOpened != null) {
      listener.onAdOpened!(this);
    }
  }

  onAdWillDismissScreen() {
    if (listener.onAdWillDismissScreen != null) {
      listener.onAdWillDismissScreen!(this);
    }
  }

  onAdClosed() {
    if (listener.onAdClosed != null) {
      listener.onAdClosed!(this);
    }
  }

  onAdPresent() {
    if (listener.onAdPresent != null) {
      listener.onAdPresent!(this);
    }
  }
}