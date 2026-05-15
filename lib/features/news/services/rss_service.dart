import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';

import '../models/rss_article.dart';

class RssService {
  final List<String> feeds = [
    'https://vnexpress.net/rss/tin-moi-nhat.rss',
    'https://thanhnien.vn/rss/home.rss',
  ];

  Future<List<RssArticle>> getNews() async {
    List<RssArticle> articles = [];

    for (String url in feeds) {
      final response = await http.get(Uri.parse(url));

      final feed = RssFeed.parse(utf8.decode(response.bodyBytes));

      final items = feed.items ?? [];

      articles.addAll(items.map((item) => _mapItem(item)).toList());
    }

    articles.sort((a, b) => b.pubDate.compareTo(a.pubDate));

    return articles;
  }

  RssArticle _mapItem(RssItem item) {
    final description = item.description ?? '';

    final imageRegex = RegExp(r'<img[^>]+src="([^"]+)"');

    final match = imageRegex.firstMatch(description);

    final imageUrl = match?.group(1) ?? '';

    return RssArticle(
      title: item.title ?? '',
      link: item.link ?? '',
      pubDate: item.pubDate?.toString() ?? '',
      thumbnail: imageUrl,
      description: description,
    );
  }
}
