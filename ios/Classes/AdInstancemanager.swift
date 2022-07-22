//
//  AdInstancemanager.swift
//  flutter_custom_search_ads
//
//  Created by Desson Chan on 21/7/2022.
//

import Foundation

class AdInstanceManager {
    
    let channel: FlutterMethodChannel
    var loadedAds : [Int: CustomSearchAd] = [:]
    
    init(channel: FlutterMethodChannel) {
        self.channel = channel;
    }
    
    func loadAd(adId: Int, arguments: Dictionary<String, Any>?) {
        loadedAds[adId] = CustomSearchAd(
            manager: self,
            adId: adId,
            adUnitId: arguments?["adUnitId"] as? String ?? "",
            query: arguments?["query"] as? String ?? "",
            testAd: arguments?["testAd"] as? Bool ?? false,
            channel: arguments?["channel"] as? String ?? "",
            styleId: arguments?["styleId"] as? String ?? ""
        )
        loadedAds[adId]?.load()
    }
    
    func onAdLoaded(ad: CustomSearchAd) {
        channel.invokeMethod("onAdLoaded", arguments: ["adId": ad.adId])
    }
    
    func onAdFailedToLoad(ad: CustomSearchAd) {
        channel.invokeMethod("onAdFailedToLoad", arguments: ["adId": ad.adId])
    }
    
    func onAdHeightChanged(ad: CustomSearchAd, height: Double) {
        channel.invokeMethod("onAdHeightChanged", arguments: ["adId": ad.adId, "height": height])
    }
    
    func onAdPresent(ad: CustomSearchAd) {
        channel.invokeMethod("onAdPresent", arguments: ["adId": ad.adId])
    }
    
    func onAdImpression(ad: CustomSearchAd) {
        channel.invokeMethod("onAdImpression", arguments: ["adId": ad.adId])
    }
    
    func onAdOpen(ad: CustomSearchAd) {
        channel.invokeMethod("onAdOpen", arguments: ["adId": ad.adId])
    }
    
    func onAdClosed(ad: CustomSearchAd) {
        channel.invokeMethod("onAdClosed", arguments: ["adId": ad.adId])
    }
    
    func onAdWillDismissScreen(ad: CustomSearchAd) {
        channel.invokeMethod("onAdWillDismissScreen", arguments: ["adId": ad.adId])
    }
}
