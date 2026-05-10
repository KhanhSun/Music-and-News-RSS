import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/widgets/mini_player.dart';

import '../music/models/song_model.dart';

import '../../shared/providers/audio_controller.dart';

import '../music/presentation/providers/realtime_song_provider.dart';

import '../music/presentation/screens/player_screen.dart';

import '../music/presentation/widgets/music_card.dart';

import '../rss/presentation/screens/rss_screen.dart';

import 'widgets/app_background.dart';

import 'widgets/home_header.dart';

import 'widgets/main_navigation.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentIndex = 0;

  bool playlistLoaded = false;

  @override
  Widget build(BuildContext context) {
    final pages = [
      buildHomePage(),
      const SizedBox(),
      const RssScreen(),
      const SizedBox(),
    ];

    return Scaffold(
      extendBody: true,

      body: pages[currentIndex],

      bottomNavigationBar: MainNavigation(
        currentIndex: currentIndex,

        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }

  Widget buildHomePage() {
    return AppBackground(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              const HomeHeader(),

              const SizedBox(height: 30),

              Expanded(
                child: Consumer(
                  builder: (context, ref, _) {
                    final songsAsync = ref.watch(realtimeSongsProvider);

                    return songsAsync.when(
                      data: (songsData) {
                        final songs = songsData
                            .map((e) => SongModel.fromJson(e))
                            .toList();

                        /// LOAD PLAYLIST 1 LẦN DUY NHẤT
                        // if (!playlistLoaded && songs.isNotEmpty) {
                        //   playlistLoaded = true;

                        //   Future.microtask(() async {
                        //     await ref
                        //         .read(audioControllerProvider.notifier)
                        //         .loadPlaylist(songs);
                        //   });
                        // }

                        return ListView(
                          children: [
                            Container(
                              height: 220,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),

                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF7B61FF),
                                    Color(0xFF00D1FF),
                                  ],
                                ),
                              ),

                              child: const Center(
                                child: Text(
                                  'Trending Music',

                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            const Text(
                              'Songs',

                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 20),

                            SizedBox(
                              height: 240,

                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,

                                itemCount: songs.length,

                                itemBuilder: (_, index) {
                                  final song = songs[index];

                                  return MusicCard(
                                    song: song,

                                    onTap: () async {
                                      await ref
                                          .read(
                                            audioControllerProvider.notifier,
                                          )
                                          .playSong(song, index);

                                      if (context.mounted) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                PlayerScreen(song: song),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },

                      loading: () =>
                          const Center(child: CircularProgressIndicator()),

                      error: (e, _) => Center(child: Text(e.toString())),
                    );
                  },
                ),
              ),

              const MiniPlayer(),
            ],
          ),
        ),
      ),
    );
  }
}
