//
//  CustomSearchAd.swift
//  flutter_custom_search_ads
//
//  Created by Desson Chan on 21/7/2022.
//

import Foundation
import GoogleMobileAds

class CustomSearchAd : NSObject {
    
    var searchBannerView: GADSearchBannerView
    
    var manager: AdInstanceManager
    var adId: Int
    var adUnitId: String
    var query: String
    var testAd: Bool
    var channel: String
    var styleId: String
    
    init(manager: AdInstanceManager, adId: Int, adUnitId: String, query: String, testAd: Bool, channel: String, styleId: String) {
        self.manager = manager
        self.adId = adId
        self.adUnitId = adUnitId
        self.query = query
        self.testAd = testAd
        self.channel = channel
        self.styleId = styleId
        self.searchBannerView = GADSearchBannerView(adSize: GADAdSizeFluid)
    }
    
    func load() {
        searchBannerView.adUnitID = adUnitId
        searchBannerView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        searchBannerView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        searchBannerView.adSizeDelegate = self
        searchBannerView.delegate = self
        
        let searchRequest = GADDynamicHeightSearchRequest()
        searchRequest.query = query
        searchRequest.channel = channel
        searchRequest.adTestEnabled = testAd
        searchRequest.numberOfAds = 1;
        searchRequest.setAdvancedOptionValue(styleId, forKey: "styleId")
        
        searchBannerView.load(searchRequest)
    }
}

extension CustomSearchAd: GADAdSizeDelegate {
    func adView(_ bannerView: GADBannerView, willChangeAdSizeTo size: GADAdSize) {
        self.manager.onAdHeightChanged(ad: self, height: size.size.height)
    }
}

extension CustomSearchAd: GADBannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        self.manager.onAdLoaded(ad: self)
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        self.manager.onAdFailedToLoad(ad: self)
    }
    
    func bannerViewDidRecordClick(_ bannerView: GADBannerView) {
        self.manager.onAdOpen(ad: self)
    }
    
    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
        self.manager.onAdImpression(ad: self)
    }
    
    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
        self.manager.onAdClosed(ad: self)
    }
    
    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        self.manager.onAdWillDismissScreen(ad: self)
    }
    
    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        self.manager.onAdPresent(ad: self)
    }
}
