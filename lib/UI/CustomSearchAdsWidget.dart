import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_search_ads/DataModel/AdInstanceManager.dart';
import 'package:flutter_custom_search_ads/DataModel/Ads/CustomSearchAd.dart';

class CustomSearchAdsWidget extends StatefulWidget {
  final CustomSearchAd ad;

  const CustomSearchAdsWidget({Key? key,
    required this.ad,
  }) : super(key: key);

  @override
  State<CustomSearchAdsWidget> createState() => _CustomSearchAdsWidgetState();
}

class _CustomSearchAdsWidgetState extends State<CustomSearchAdsWidget> {

  @override
  Widget build(BuildContext context) {
    const String viewType = "customSearchAds";
    return ValueListenableBuilder<double>(
      valueListenable: widget.ad.adHeight,
      builder: (BuildContext context, double height, Widget? widget) {
        return Stack(
          children: [
            SizedBox(
              height: height,
              child: Container(
                // decoration: BoxDecoration(
                //     border: Border.all(color: Colors.red)
                // ),
                child: widget,
              ),
            ),
          ],
        );
      },
      child: Builder(
        builder: (BuildContext context) {
          switch (defaultTargetPlatform) {
            case TargetPlatform.android:
              return AndroidView(
                viewType: viewType,
                creationParams: {
                  "adId": instanceManager.adIdFor(widget.ad),
                },
                creationParamsCodec: StandardMessageCodec(),
              );
            case TargetPlatform.iOS:
              return UiKitView(
                viewType: viewType,
                creationParams: {
                  "adId": instanceManager.adIdFor(widget.ad),
                },
                creationParamsCodec: const StandardMessageCodec(),
              );
            default:
              throw UnsupportedError('Unsupported platform view');
          }
        },
      ),
    );
  }
}
