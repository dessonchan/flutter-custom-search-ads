package com.example.flutter_custom_search_ads.classes

import com.google.android.gms.ads.AdListener
import com.google.android.gms.ads.AdSize
import com.google.android.gms.ads.LoadAdError
import com.google.android.gms.ads.search.DynamicHeightSearchAdRequest
import com.google.android.gms.ads.search.SearchAdView


class CustomSearchAd(manager: AdInstanceManager,
                     adId: Int,
                     adUnitId: String,
                     query:String,
                     testAd: Boolean = false,
                     channel:String,
                     styleId: String
): AdListener() {

    var manager: AdInstanceManager
    var searchBanner: SearchAdView

    var adId: Int
    var adUnitId: String
    var query: String
    var testAd: Boolean
    var channel: String
    var styleId: String

    init {
        this.manager = manager

        this.adId = adId
        this.adUnitId = adUnitId
        this.query = query
        this.testAd = testAd
        this.channel = channel
        this.styleId = styleId

        this.searchBanner = SearchAdView(manager.context)
        this.searchBanner.setAdSize(AdSize.SEARCH)
        this.searchBanner.adListener = this
    }

    fun load() {
        this.searchBanner.adUnitId = adUnitId
        var request = DynamicHeightSearchAdRequest.Builder()
        request.setQuery(query)
        request.setAdTest(testAd)
        request.setChannel(channel)
        request.setNumber(1)
        request.setAdvancedOptionValue("csa_styleId", styleId)

        this.searchBanner.loadAd(request.build())
    }

    override fun onAdLoaded() {
        super.onAdLoaded()
        manager.onAdLoad(this)
    }

    override fun onAdFailedToLoad(p0: LoadAdError) {
        super.onAdFailedToLoad(p0)
        manager.onFailedToLoad(this)
    }

    override fun onAdOpened() {
        super.onAdOpened()
        manager.onAdPresent(this)
    }

    override fun onAdClicked() {
        super.onAdClicked()
        manager.onAdOpen(this)
    }

    override fun onAdClosed() {
        super.onAdClosed()
        manager.onAdClose(this)
    }

    override fun onAdImpression() {
        super.onAdImpression()
        manager.onAdImpression(this)
    }
}