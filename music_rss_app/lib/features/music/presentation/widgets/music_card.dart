import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import '../../models/song_model.dart';

class MusicCard extends StatelessWidget {
  final SongModel song;

  final VoidCallback onTap;

  const MusicCard({super.key, required this.song, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: 160,

        margin: const EdgeInsets.only(right: 16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),

              child: CachedNetworkImage(
                imageUrl: song.coverUrl,

                height: 160,
                width: 160,

                fit: BoxFit.cover,

                placeholder: (context, url) => Container(
                  color: Colors.white10,

                  child: const Center(child: CircularProgressIndicator()),
                ),

                errorWidget: (context, url, error) => Container(
                  color: Colors.white10,

                  child: const Icon(Icons.music_note),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              song.title,

              maxLines: 1,

              overflow: TextOverflow.ellipsis,

              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            Text(song.artist, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
