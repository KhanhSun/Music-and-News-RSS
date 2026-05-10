import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/rss_constants.dart';
import '../../models/news_model.dart';
import '../providers/rss_provider.dart';
import '../widgets/news_card.dart';
import 'news_detail_screen.dart';

class RssScreen extends ConsumerStatefulWidget {
  const RssScreen({super.key});

  @override
  ConsumerState<RssScreen> createState() => _RssScreenState();
}

class _RssScreenState extends ConsumerState<RssScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final categories = {
    'Technology': RssConstants.technology,
    'Sport': RssConstants.sport,
    'Business': RssConstants.business,
    'Entertainment': RssConstants.entertainment,
  };

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BBC News'),

        bottom: TabBar(
          controller: tabController,
          isScrollable: true,

          tabs: categories.keys.map((e) => Tab(text: e)).toList(),
        ),
      ),

      body: TabBarView(
        controller: tabController,

        children: categories.entries.map((entry) {
          return Consumer(
            builder: (context, ref, _) {
              final newsAsync = ref.watch(rssProvider(entry.value));

              return newsAsync.when(
                data: (newsList) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.refresh(rssProvider(entry.value));
                    },

                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),

                      itemCount: newsList.length,

                      itemBuilder: (_, index) {
                        final news = newsList[index];

                        return NewsCard(
                          news: news,

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    NewsDetailScreen(url: news.link),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },

                loading: () => const Center(child: CircularProgressIndicator()),

                error: (e, _) => Center(child: Text(e.toString())),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
