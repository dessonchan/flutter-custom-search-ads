package com.example.flutter_custom_search_ads

import androidx.annotation.NonNull
import com.example.flutter_custom_search_ads.UI.CustomSearchAdsViewFactory
import com.example.flutter_custom_search_ads.classes.AdInstanceManager
import io.flutter.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.Exception
import kotlin.math.log

var adInstanceManager: AdInstanceManager? = null

/** FlutterCustomSearchAdsPlugin */
class FlutterCustomSearchAdsPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
      flutterPluginBinding.platformViewRegistry.registerViewFactory("customSearchAds", CustomSearchAdsViewFactory())

      channel = MethodChannel(flutterPluginBinding.binaryMessenger, "plugins.dessonchan.com/flutter-custom-search-ads")
      channel.setMethodCallHandler(this)

      adInstanceManager = AdInstanceManager(channel, flutterPluginBinding.applicationContext)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "onAdLoad") {
      var adId = call.argument<Int>("adId")
      if (adId != null) {
        adInstanceManager?.loadAd(adId, call.arguments as Map<String, Any>)
        result.success("")
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
