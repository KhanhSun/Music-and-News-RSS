import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/rss_repository.dart';
import '../../models/news_model.dart';

final rssRepositoryProvider = Provider((ref) => RssRepository());

final rssProvider = FutureProvider.family<List<NewsModel>, String>((
  ref,
  url,
) async {
  return ref.read(rssRepositoryProvider).getNews(url);
});
