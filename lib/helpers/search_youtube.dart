import 'dart:convert';
import 'package:http/http.dart';
import 'package:spotube_flutter/models/YoutubeSearchResult.dart';

Future<List<YtSearchResult>> searchYoutube(String query,
    {int limit = 20}) async {
  try {
    if (query.trim().isEmpty) throw Exception("query can't be blank");
    Client client = Client();
    Uri url = Uri(
      scheme: "https",
      host: "www.youtube.com",
      path: "results",
      queryParameters: {
        "search_query": query,
      },
    );
    Response page = await client.get(url.toString());
    return parseSearch(page.body, limit);
  } catch (e) {
    throw e;
  }
}

List<YtSearchResult> parseSearch(String html, int limit) {
  List<YtSearchResult> results = [];
  List<dynamic> dataInfo = [];
  bool scrapped = false;
  try {
    var initDoc = html.split("var ytInitialData = ");
    String data = initDoc[1].split(";</script><script")[0];
    html = data;
  } catch (e) {
    print("[Error extracting ytInitialData]: $e");
  }

  try {
    var decodedHtml = jsonDecode(html)["contents"]
                ["twoColumnSearchResultsRenderer"]["primaryContents"]
            ["sectionListRenderer"]["contents"]
        .first["itemSectionRenderer"]["contents"];
    dataInfo = decodedHtml;
    scrapped = true;
  } catch (e) {
    print("[Error accessing itemSectionRenderer.contents]: $e");
  }

  if (!scrapped) {
    try {
      dataInfo = jsonDecode(html
          .split("{\"itemSectionRenderer\":")
          .last
          .split("},{\"continuationItemRenderer\":{")
          .first)["contents"];
      scrapped = true;
    } catch (err) {
      print(
          "[Error in try again <accessing itemSectionRenderer.contents>]: $err");
    }
  }
  // failure
  if (!scrapped) {
    return [];
  }
  for (var data in dataInfo) {
    try {
      YtSearchResult result;
      data = data["videoRenderer"];
      if (data == null) continue;
      result = YtSearchResult(
          id: data["videoId"],
          title: data["title"]["runs"].first["text"],
          duration: "unavailable",
          thumbnail: data["thumbnail"]["thumbnails"].last["url"],
          channel: YtChannel(
            id: data["ownerText"]["runs"].first["navigationEndpoint"]
                ["browseEndpoint"]["browseId"],
            name: data["ownerText"]["runs"].first["text"],
            url: "https://www.youtube.com" +
                data["ownerText"]["runs"].first["navigationEndpoint"]
                    ["browseEndpoint"]["canonicalBaseUrl"],
          ),
          uploadDate: "unavailable",
          viewCount: "unavailable",
          type: "video");
      results.add(result);
    } catch (e) {
      print("[Error in construction of result]: $e");
    }
  }
  return results;
}
