package com.example.flutter_custom_search_ads.UI

import android.content.Context
import android.view.View
import com.example.flutter_custom_search_ads.adInstanceManager
import com.example.flutter_custom_search_ads.classes.CustomSearchAd
import io.flutter.plugin.platform.PlatformView

class CustomSearchAdsView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView, View.OnLayoutChangeListener {

    private var context: Context
    private var ad: CustomSearchAd?

    init {
        this.context = context
        ad = adInstanceManager?.loadedAds?.get(creationParams?.get("adId"))
        ad?.searchBanner?.addOnLayoutChangeListener(this)
    }

    override fun getView(): View? {
        return ad?.searchBanner
    }

    override fun dispose() {}

    override fun onLayoutChange(
        view: View?,
        left: Int,
        top: Int,
        right: Int,
        bottom: Int,
        oldLeft: Int,
        oldTop: Int,
        oldRight: Int,
        oldBottom: Int
    ) {
        ad?.searchBanner?.getChildAt(0)?.measuredHeightAndState!!.let {
            ad?.manager?.onAdHeightChanged(ad!!, convertPxToDp(it))
        }
    }

    private fun convertPxToDp(px: Int): Double {
        val resources = context.resources
        val metrics = resources.displayMetrics
        val dp = px / (metrics.densityDpi / 160f)
        return dp.toDouble()
    }
}