package com.example.flutter_custom_search_ads

import android.util.Log
import androidx.annotation.NonNull
import com.example.flutter_custom_search_ads.UI.CustomSearchAdsViewFactory
import com.example.flutter_custom_search_ads.classes.AdInstanceManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

var adInstanceManager: AdInstanceManager? = null

/** FlutterCustomSearchAdsPlugin */
class FlutterCustomSearchAdsPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var activity: FlutterActivity
    private lateinit var binaryMessenger: BinaryMessenger

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        binaryMessenger = flutterPluginBinding.binaryMessenger
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            "customSearchAds",
            CustomSearchAdsViewFactory()
        )
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "onAdLoad") {
            val adId = call.argument<Int>("adId")
            if (adId != null) {
                adInstanceManager?.loadAd(adId, call.arguments as Map<String, Any>)
                result.success("")
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        // check the channel is isInitialized or not
        if (this::channel.isInitialized) {
            channel.setMethodCallHandler(null)
        }
    }

    /**
     * Since search ad needs an activity instance of context
     * we can get the activity by implementing ActivityAware
     * https://stackoverflow.com/questions/59887901/get-activity-reference-in-flutter-plugin
     */
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity as FlutterActivity
        channel = MethodChannel(binaryMessenger, "plugins.dessonchan.com/flutter-custom-search-ads")
        channel.setMethodCallHandler(this)
        adInstanceManager = AdInstanceManager(channel, activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

    }

    override fun onDetachedFromActivity() {

    }
}
