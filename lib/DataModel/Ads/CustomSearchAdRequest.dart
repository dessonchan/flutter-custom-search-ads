class CustomSearchAdRequest {
  String query;
  bool testAd;
  String channel;
  String styleId;

  CustomSearchAdRequest({
    required this.channel,
    required this.styleId,
    required this.query,
    this.testAd = false
  });

  Map<String, dynamic> toPlatformArgs() {
    return {
      'query': query,
      'testAd': testAd,
      'channel': channel,
      'styleId': styleId,
    };
  }
}