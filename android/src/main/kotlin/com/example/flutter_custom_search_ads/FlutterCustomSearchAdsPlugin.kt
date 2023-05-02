package com.example.flutter_custom_search_ads

import android.app.Activity
import androidx.annotation.NonNull
import com.example.flutter_custom_search_ads.UI.CustomSearchAdsViewFactory
import com.example.flutter_custom_search_ads.classes.AdInstanceManager
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
    private var channel: MethodChannel? = null
    private var activity: Activity? = null
    private var binaryMessenger: BinaryMessenger? = null

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
        channel?.setMethodCallHandler(null)
    }

    /**
     * Since search ad needs an activity instance of context
     * we can get the activity by implementing ActivityAware
     * https://stackoverflow.com/questions/59887901/get-activity-reference-in-flutter-plugin
     */
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binaryMessenger?.let { messenger ->
            channel = MethodChannel(messenger, "plugins.dessonchan.com/flutter-custom-search-ads")
            channel?.setMethodCallHandler(this)
            activity?.let {
                adInstanceManager = AdInstanceManager(channel!!, it)
            }
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

    }

    override fun onDetachedFromActivity() {

    }
}
