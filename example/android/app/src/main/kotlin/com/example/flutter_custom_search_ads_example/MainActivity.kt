package com.example.flutter_custom_search_ads_example

import com.example.flutter_custom_search_ads.FlutterCustomSearchAdsPlugin
import com.example.flutter_custom_search_ads.UI.CustomSearchAdsViewFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.platformViewsController.registry.registerViewFactory("customSearchAds", CustomSearchAdsViewFactory())
    }
}
