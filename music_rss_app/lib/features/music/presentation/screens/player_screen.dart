import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/duration_formatter.dart';

import '../../models/song_model.dart';

import '../../../../shared/providers/audio_controller.dart';

import '../providers/player_streams.dart';

class PlayerScreen extends ConsumerWidget {
  final SongModel song;

  const PlayerScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            children: [
              const SizedBox(height: 20),

              ClipRRect(
                borderRadius: BorderRadius.circular(30),

                child: CachedNetworkImage(
                  imageUrl: song.coverUrl,

                  height: 350,
                  width: 350,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 40),

              Text(
                song.title,

                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                song.artist,

                style: const TextStyle(color: Colors.grey, fontSize: 18),
              ),

              const SizedBox(height: 40),

              Consumer(
                builder: (context, ref, _) {
                  final positionAsync = ref.watch(positionStreamProvider);

                  final durationAsync = ref.watch(durationStreamProvider);

                  return positionAsync.when(
                    data: (position) {
                      return durationAsync.when(
                        data: (duration) {
                          final total = duration?.inSeconds.toDouble() ?? 1;

                          return Column(
                            children: [
                              Slider(
                                value: position.inSeconds.toDouble().clamp(
                                  0,
                                  total,
                                ),

                                max: total,

                                onChanged: (value) async {
                                  await ref
                                      .read(audioControllerProvider.notifier)
                                      .seek(Duration(seconds: value.toInt()));
                                },
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  Text(formatDuration(position)),

                                  Text(
                                    formatDuration(duration ?? Duration.zero),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },

                        loading: () => const SizedBox(),

                        error: (_, __) => const SizedBox(),
                      );
                    },

                    loading: () => const SizedBox(),

                    error: (_, __) => const SizedBox(),
                  );
                },
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  IconButton(
                    onPressed: () async {
                      await ref
                          .read(audioControllerProvider.notifier)
                          .shuffle();
                    },

                    icon: const Icon(Icons.shuffle),
                  ),

                  IconButton(
                    onPressed: () async {
                      await ref
                          .read(audioControllerProvider.notifier)
                          .previous();
                    },

                    icon: const Icon(Icons.skip_previous, size: 40),
                  ),

                  Consumer(
                    builder: (context, ref, _) {
                      final playerState = ref.watch(playerStateStreamProvider);

                      return playerState.when(
                        data: (state) {
                          final playing = state.playing;

                          return IconButton(
                            onPressed: () async {
                              if (playing) {
                                await ref
                                    .read(audioControllerProvider.notifier)
                                    .pause();
                              } else {
                                await ref
                                    .read(audioControllerProvider.notifier)
                                    .resume();
                              }
                            },

                            icon: Icon(
                              playing ? Icons.pause_circle : Icons.play_circle,

                              size: 80,
                            ),
                          );
                        },

                        loading: () => const SizedBox(),

                        error: (_, __) => const SizedBox(),
                      );
                    },
                  ),

                  IconButton(
                    onPressed: () async {
                      await ref.read(audioControllerProvider.notifier).next();
                    },

                    icon: const Icon(Icons.skip_next, size: 40),
                  ),

                  IconButton(
                    onPressed: () async {
                      await ref.read(audioControllerProvider.notifier).repeat();
                    },

                    icon: const Icon(Icons.repeat),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Expanded(
                child: SingleChildScrollView(
                  child: Text(song.lyrics, style: const TextStyle(height: 1.8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
