import 'package:flutter/material.dart';

import '../models/rss_article.dart';
import '../services/rss_service.dart';

class NewsProvider extends ChangeNotifier {
  final RssService _rssService = RssService();

  List<RssArticle> articles = [];

  bool isLoading = false;

  Future<void> loadNews() async {
    isLoading = true;

    notifyListeners();

    articles = await _rssService.getNews();

    isLoading = false;

    notifyListeners();
  }
}
