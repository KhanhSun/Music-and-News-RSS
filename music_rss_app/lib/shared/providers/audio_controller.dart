import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../features/music/models/song_model.dart';

final audioControllerProvider =
    StateNotifierProvider<AudioController, AudioPlayer>(
      (ref) => AudioController(),
    );

class AudioController extends StateNotifier<AudioPlayer> {
  AudioController() : super(AudioPlayer());

  final List<SongModel> _queue = [];

  int _currentIndex = 0;

  SongModel? currentSong;

  Future<void> loadPlaylist(List<SongModel> songs) async {
    try {
      _queue.clear();
      _queue.addAll(songs);

      final playlist = ConcatenatingAudioSource(
        children: songs.map((song) {
          return AudioSource.uri(Uri.parse(song.audioUrl));
        }).toList(),
      );

      await state.setAudioSource(playlist, preload: false);
    } catch (e) {
      print("LOAD PLAYLIST ERROR: $e");
    }
  }

  Future<void> playSong(SongModel song, int index) async {
    try {
      // Nếu playlist chưa load
      if (_queue.isEmpty) {
        await loadPlaylist([song]);

        index = 0;
      }

      // Nếu index vượt giới hạn
      if (index >= _queue.length) {
        index = 0;
      }

      _currentIndex = index;

      currentSong = _queue[index];

      await state.seek(Duration.zero, index: index);

      await state.play();
    } catch (e) {
      print("PLAY SONG ERROR: $e");
    }
  }

  Future<void> pause() async {
    await state.pause();
  }

  Future<void> resume() async {
    await state.play();
  }

  Future<void> next() async {
    await state.seekToNext();

    if (_currentIndex < _queue.length - 1) {
      _currentIndex++;

      currentSong = _queue[_currentIndex];
    }
  }

  Future<void> previous() async {
    await state.seekToPrevious();

    if (_currentIndex > 0) {
      _currentIndex--;

      currentSong = _queue[_currentIndex];
    }
  }

  Future<void> seek(Duration duration) async {
    await state.seek(duration);
  }

  Future<void> shuffle() async {
    await state.shuffle();

    await state.setShuffleModeEnabled(true);
  }

  Future<void> repeat() async {
    await state.setLoopMode(LoopMode.all);
  }
}
