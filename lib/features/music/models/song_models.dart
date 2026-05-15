class SongModel {
  final String encodeId;
  final String title;
  final String artist;
  final String thumbnail;
  final String? streamUrl;

  SongModel({
    required this.encodeId,
    required this.title,
    required this.artist,
    required this.thumbnail,
    this.streamUrl,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      encodeId: json['encodeId'] ?? '',
      title: json['title'] ?? '',
      artist: json['artistsNames'] ?? '',
      thumbnail: json['thumbnailM'] ?? '',
    );
  }

  SongModel copyWith({String? streamUrl}) {
    return SongModel(
      encodeId: encodeId,
      title: title,
      artist: artist,
      thumbnail: thumbnail,
      streamUrl: streamUrl ?? this.streamUrl,
    );
  }
}
