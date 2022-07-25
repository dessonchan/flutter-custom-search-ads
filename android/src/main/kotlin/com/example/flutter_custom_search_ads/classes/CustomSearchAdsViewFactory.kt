package com.example.flutter_custom_search_ads.UI

import android.content.Context
import android.view.View
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import java.lang.Exception

class CustomSearchAdsViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        if (context != null)
            return CustomSearchAdsView(context, viewId, creationParams)
        throw Exception("No Context")
    }
}