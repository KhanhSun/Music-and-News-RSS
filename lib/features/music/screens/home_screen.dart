import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import '../providers/music_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<MusicProvider>().loadSongs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Consumer<MusicProvider>(
          builder: (context, provider, child) {
            return ListView.builder(
              itemCount: provider.queue.length,
              itemBuilder: (context, index) {
                final song = provider.queue[index];

                return ListTile(
                  leading: Image.network(
                    song.thumbnail,
                    width: 50,
                    fit: BoxFit.cover,
                  ),

                  title: Text(song.title),

                  subtitle: Text(song.artist),

                  onTap: () {
                    Navigator.pop(context);

                    provider.playSong(song);
                  },
                );
              },
            );
          },
        ),
      ),

      appBar: AppBar(title: const Text('Music Online')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search music...',
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) {
                context.read<MusicProvider>().search(value);
              },
            ),
          ),

          Expanded(
            child: Consumer<MusicProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: provider.songs.length,
                  itemBuilder: (context, index) {
                    final song = provider.songs[index];

                    return ListTile(
                      leading: Image.network(
                        song.thumbnail,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                      title: Text(song.title),
                      subtitle: Text(song.artist),
                      onTap: () {
                        provider.playSong(song);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Consumer<MusicProvider>(
        builder: (context, provider, child) {
          final currentSong = provider.currentSong;

          if (currentSong == null) {
            return const SizedBox();
          }

          return Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StreamBuilder<Duration>(
                  stream: provider.positionStream,
                  builder: (context, snapshot) {
                    final position = snapshot.data ?? Duration.zero;

                    return StreamBuilder<Duration?>(
                      stream: provider.durationStream,
                      builder: (context, durationSnapshot) {
                        final duration = durationSnapshot.data ?? Duration.zero;

                        return ProgressBar(
                          progress: position,
                          total: duration,
                          onSeek: (value) {
                            provider.seek(value);
                          },
                        );
                      },
                    );
                  },
                ),
                if (provider.lyricUrl != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 10),

                    child: Text(
                      provider.lyricUrl!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                Row(
                  children: [
                    Expanded(child: Text(currentSong.title)),

                    IconButton(
                      onPressed: () {
                        provider.previousSong();
                      },
                      icon: const Icon(Icons.skip_previous),
                    ),

                    IconButton(
                      onPressed: () {
                        if (provider.isPlaying) {
                          provider.pauseSong();
                        } else {
                          provider.resumeSong();
                        }
                      },
                      icon: Icon(
                        provider.isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        provider.nextSong();
                      },
                      icon: const Icon(Icons.skip_next),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
