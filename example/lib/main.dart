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

  @override
  void initState() {
    super.initState();
  }

  Future<CustomSearchAd> _loadAd() async {
    Completer<CustomSearchAd> _completer = Completer();
    CustomSearchAd(
        adUnitId: "ms-app-pub-", // replace with valid adUnit id
        request: CustomSearchAdRequest(
            channel: '',
            query: 'flutter',
            styleId: '',
            testAd: true
        ),
        listener: CustomSearchAdListener(
            onAdLoaded: (CustomSearchAd ad) {
              _completer.complete(ad);
            },
            onAdFailedToLoad: (CustomSearchAd ad) {
              _completer.completeError("onAdFailedToLoad");
            },
            onAdHeightChanged: (CustomSearchAd ad, double height) {
              print("onAdHeightChanged: $height");
            }
        )
    ).load();
    return _completer.future;
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
                onPressed: () {
                  setState(() {});
                },
              )
            ],
          ),
          body: Container(
            child: Center(
              child: Container(
                child: FutureBuilder<CustomSearchAd>(
                    future: _loadAd(),
                    builder: (BuildContext context, AsyncSnapshot<CustomSearchAd> snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                          child: Text("Serch Ad Load Error"),
                        );
                      }
                      if (snapshot.data == null) {
                        return Container(
                          child: Text("Serch Ad Loading..."),
                        );
                      }
                      return CustomSearchAdsWidget(ad: snapshot.data!);
                    }
                ),
              ),
            ),
          )
      ),
    );
  }
}
