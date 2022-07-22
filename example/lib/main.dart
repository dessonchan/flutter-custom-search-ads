import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_custom_search_ads/DataModel/Ads/CustomSearchAd.dart';
import 'package:flutter_custom_search_ads/DataModel/Ads/CustomSearchAdListener.dart';
import 'package:flutter_custom_search_ads/DataModel/Ads/CustomSearchAdRequest.dart';
import 'package:flutter_custom_search_ads/UI/CustomSearchAdsWidget.dart';
import 'package:flutter_custom_search_ads/flutter_custom_search_ads.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? adBanner;

  @override
  void initState() {
    super.initState();
  }

  _refresh() {
    CustomSearchAd(
        adUnitId: "ms-app-pub-9616389000213823",
        request: CustomSearchAdRequest(
            channel: '',
            query: 'apple',
            styleId: '0000000001',
            testAd: true
        ),
        listener: CustomSearchAdListener(
            onAdLoaded: (CustomSearchAd ad) {
              setState(() {
                adBanner = CustomSearchAdsWidget(ad: ad);
              });
            },
            onAdFailedToLoad: (CustomSearchAd ad) {
              print("onAdFailedToLoad");
            },
            onAdHeightChanged: (CustomSearchAd ad, double height) {
              print("onAdHeightChanged: $height");
            }
        )
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _refresh,
              )
            ],
          ),
          body: adBanner ?? Container()
      ),
    );
  }
}
