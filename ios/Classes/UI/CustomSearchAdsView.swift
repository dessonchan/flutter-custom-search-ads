//
//  File.swift
//  flutter_custom_search_ads
//
//  Created by Desson Chan on 21/7/2022.
//

import Flutter
import UIKit
import GoogleMobileAds

class CustomSearchAdsView: NSObject, FlutterPlatformView {
    private var _view: UIView
    var searchBannerView: GADSearchBannerView = GADSearchBannerView(adSize: GADAdSizeFluid)
    private var ad: CustomSearchAd?
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView(frame: frame)
        if let argsDict = args as? Dictionary<String, Any>? {
            self.ad = instanceManager?.loadedAds[argsDict?["adId"] as! Int]
        }
        super.init()
        // iOS views can be created here
        createNativeView(view: _view)
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView){
        if (ad != nil) {
            _view.addSubview(ad!.searchBannerView)
        }
    }
}
