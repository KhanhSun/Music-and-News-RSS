// lib/features/rss/data/repositories/rss_repository.dart

import '../../models/news_model.dart';
import '../services/rss_service.dart';

class RssRepository {
  final service = RssService();

  Future<List<NewsModel>> getNews(String url) async {
    final feed = await service.loadFeed(url);

    return feed.items?.map((item) {
          return NewsModel(
            title: item.title ?? '',
            description: item.description ?? '',
            link: item.link ?? '',
            imageUrl: item.enclosure?.url ?? '',
            // SỬA TẠI ĐÂY: Thêm .toString()
            pubDate: item.pubDate?.toString() ?? '',
          );
        }).toList() ??
        [];
  }
}
