import 'package:http/http.dart' as http;
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/webfeed.dart';

class RssService {
  Future<RssFeed> loadFeed(String url) async {
    final response = await http.get(Uri.parse(url));

    // DEBUG
    print(response.statusCode);

    if (response.statusCode == 200) {
      return RssFeed.parse(response.body);
    } else {
      throw Exception('Failed to fetch RSS: ${response.statusCode}');
    }
  }
}
