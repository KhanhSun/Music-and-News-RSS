import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/providers/audio_controller.dart';

import '../../features/music/presentation/providers/player_streams.dart';

class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(audioControllerProvider.notifier);

    final song = controller.currentSong;

    if (song == null) {
      return const SizedBox();
    }

    final playerState = ref.watch(playerStateStreamProvider);

    return Container(
      margin: const EdgeInsets.all(16),

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.black87,

        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),

            child: Image.network(
              song.coverUrl,

              width: 55,
              height: 55,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(song.title, maxLines: 1, overflow: TextOverflow.ellipsis),

                Text(song.artist, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          IconButton(
            onPressed: () async {
              await controller.previous();
            },

            icon: const Icon(Icons.skip_previous),
          ),

          playerState.when(
            data: (state) {
              return IconButton(
                onPressed: () async {
                  if (state.playing) {
                    await controller.pause();
                  } else {
                    await controller.resume();
                  }
                },

                icon: Icon(
                  state.playing ? Icons.pause_circle : Icons.play_circle,
                ),
              );
            },

            loading: () => const SizedBox(),

            error: (_, __) => const SizedBox(),
          ),

          IconButton(
            onPressed: () async {
              await controller.next();
            },

            icon: const Icon(Icons.skip_next),
          ),
        ],
      ),
    );
  }
}
