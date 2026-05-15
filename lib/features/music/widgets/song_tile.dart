import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/song_models.dart';

class SongTile extends StatelessWidget {
  final SongModel song;
  final VoidCallback onTap;

  const SongTile({super.key, required this.song, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CachedNetworkImage(
        imageUrl: song.thumbnail,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
      title: Text(song.title),
      subtitle: Text(song.artist),
    );
  }
}
