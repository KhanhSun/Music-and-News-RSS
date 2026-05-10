class SongModel {
  final String id;
  final String title;
  final String artist;
  final String coverUrl;
  final String audioUrl;
  final String lyrics;

  SongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.coverUrl,
    required this.audioUrl,
    required this.lyrics,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      coverUrl: json['cover_url'],
      audioUrl: json['audio_url'],
      lyrics: json['lyrics'] ?? '',
    );
  }
}
