import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/song_repository.dart';
import '../../models/song_model.dart';

final songRepositoryProvider = Provider((ref) => SongRepository());

final songsProvider = FutureProvider<List<SongModel>>((ref) async {
  return ref.read(songRepositoryProvider).getSongs();
});
