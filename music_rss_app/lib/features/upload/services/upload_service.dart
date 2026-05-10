import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../core/services/supabase_service.dart';

class UploadService {
  final supabase = SupabaseService.client;

  Future<String> uploadMusic(File file) async {
    final fileName = const Uuid().v4();

    await supabase.storage.from('music-files').upload('$fileName.mp3', file);

    return supabase.storage.from('music-files').getPublicUrl('$fileName.mp3');
  }

  Future<String> uploadCover(File file) async {
    final fileName = const Uuid().v4();

    await supabase.storage.from('cover-images').upload('$fileName.jpg', file);

    return supabase.storage.from('cover-images').getPublicUrl('$fileName.jpg');
  }

  Future<void> saveSong({
    required String title,
    required String artist,
    required String coverUrl,
    required String audioUrl,
    required String lyrics,
  }) async {
    await supabase.from('songs').insert({
      'title': title,
      'artist': artist,
      'cover_url': coverUrl,
      'audio_url': audioUrl,
      'lyrics': lyrics,
    });
  }
}
