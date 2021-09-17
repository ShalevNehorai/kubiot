import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkHelper {
  Future<String> createDynamicLink(String roomId) async {
    final DynamicLinkParameters parms = DynamicLinkParameters(
      uriPrefix: "https://kubiot.page.link/?id=$roomId",
      link: Uri.parse("https://kubiot.page.link/?id=$roomId"),
      androidParameters: AndroidParameters(
        packageName: 'com.example.kubiot',
        minimumVersion: 1,
      ),
    );

    final ShortDynamicLink shortDynamicLink = await parms.buildShortLink();

    final Uri shortUrl = shortDynamicLink.shortUrl;

    print(shortUrl.toString());

    return shortUrl.toString();
  }

  Future<String?> getLinkData() async {
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      Uri deepLink = data.link;
      if (deepLink.queryParameters.containsKey('id')) {
        return deepLink.queryParameters["id"];
      }
      return "data not contain id key";
    }

    return null;
  }
}
