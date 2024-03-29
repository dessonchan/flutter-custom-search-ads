package com.example.flutter_custom_search_ads.classes

import android.app.Activity
import android.content.Context
import io.flutter.plugin.common.MethodChannel
import java.util.*

import com.example.flutter_custom_search_ads.classes.CustomSearchAd
import com.google.android.gms.ads.AdListener
import io.flutter.embedding.android.FlutterActivity

class AdInstanceManager(val channel: MethodChannel, val activity: Activity) {
    var loadedAds: MutableMap<Int, CustomSearchAd> = mutableMapOf<Int, CustomSearchAd>()

    fun loadAd(adId: Int, arguments:Map<String, Any>) {
        val ad = CustomSearchAd(this, adId,
            arguments["adUnitId"] as String,
            arguments["query"] as String,
            arguments["testAd"] as Boolean,
            arguments["channel"] as String,
            arguments["styleId"] as String
        )
        loadedAds[adId] = ad

        loadedAds[adId]?.load()
    }

    fun onAdLoad(ad: CustomSearchAd) {
        channel.invokeMethod("onAdLoaded", mapOf<String, Any>(Pair("adId", ad.adId)))
    }

    fun onFailedToLoad(ad: CustomSearchAd) {
        channel.invokeMethod("onAdFailedToLoad", mapOf<String, Any>(Pair("adId", ad.adId)))
    }

    fun onAdHeightChanged(ad: CustomSearchAd, height:Double) {
        channel.invokeMethod("onAdHeightChanged", mapOf<String, Any>(Pair("adId", ad.adId), Pair("height", height)))
    }

    fun onAdPresent(ad: CustomSearchAd) {
        channel.invokeMethod("onAdPresent", mapOf<String, Any>(Pair("adId", ad.adId)))
    }

    fun onAdImpression(ad: CustomSearchAd) {
        channel.invokeMethod("onAdImpression", mapOf<String, Any>(Pair("adId", ad.adId)))
    }

    fun onAdOpen(ad: CustomSearchAd) {
        channel.invokeMethod("onAdOpen", mapOf<String, Any>(Pair("adId", ad.adId)))
    }

    fun onAdClose(ad: CustomSearchAd) {
        channel.invokeMethod("onAdClosed", mapOf<String, Any>(Pair("adId", ad.adId)))
    }

    fun onAdWillDismissScreen(ad: CustomSearchAd) {
        channel.invokeMethod("onAdWillDismissScreen", mapOf<String, Any>(Pair("adId", ad.adId)))
    }

    fun onAdClicked(ad: CustomSearchAd) {
        channel.invokeMethod("onAdClicked", mapOf<String, Any>(Pair("adId", ad.adId)))
    }
}