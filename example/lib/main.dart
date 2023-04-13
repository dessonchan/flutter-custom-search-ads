import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_custom_search_ads/DataModel/Ads/CustomSearchAd.dart';
import 'package:flutter_custom_search_ads/DataModel/Ads/CustomSearchAdListener.dart';
import 'package:flutter_custom_search_ads/DataModel/Ads/CustomSearchAdRequest.dart';
import 'package:flutter_custom_search_ads/UI/CustomSearchAdsWidget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
              print("onAdLoaded");
              _completer.complete(ad);
            },
            onAdFailedToLoad: (CustomSearchAd ad) {
              print("onAdFailToLoad");
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
          body: Center(
            child: FutureBuilder<CustomSearchAd>(
                future: _loadAd(),
                builder: (BuildContext context, AsyncSnapshot<CustomSearchAd> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Search Ad Load Error");
                  }
                  if (snapshot.data == null) {
                    return const Text("Search Ad Loading...");
                  }
                  return CustomSearchAdsWidget(ad: snapshot.data!);
                }
            ),
          )
      ),
    );
  }
}
