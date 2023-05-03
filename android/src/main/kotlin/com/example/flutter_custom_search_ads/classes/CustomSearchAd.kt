package com.example.flutter_custom_search_ads.classes

import com.google.android.gms.ads.AdListener
import com.google.android.gms.ads.AdSize
import com.google.android.gms.ads.LoadAdError
import com.google.android.gms.ads.search.DynamicHeightSearchAdRequest
import com.google.android.gms.ads.search.SearchAdView

class CustomSearchAd(val manager: AdInstanceManager,
                     val adId: Int,
                     val adUnitId: String,
                     val query: String,
                     val testAd: Boolean = false,
                     val channel:String,
                     val styleId: String
): AdListener() {

    var searchBanner: SearchAdView = SearchAdView(manager.activity)

    init {
        searchBanner.setAdSize(AdSize.SEARCH)
        searchBanner.adListener = this
    }

    fun load() {
        searchBanner.adUnitId = adUnitId
        val request = DynamicHeightSearchAdRequest.Builder()
        request.setQuery(query)
        request.setAdTest(testAd)
        request.setChannel(channel)
        request.setNumber(1)
        request.setAdvancedOptionValue("csa_styleId", styleId)
        searchBanner.loadAd(request.build())
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
        manager.onAdOpen(this)
    }

    override fun onAdClicked() {
        super.onAdClicked()
        manager.onAdClicked(this)
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