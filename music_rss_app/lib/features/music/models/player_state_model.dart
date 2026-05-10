class PlayerStateModel {
  final bool isPlaying;
  final Duration position;
  final Duration duration;

  PlayerStateModel({
    required this.isPlaying,
    required this.position,
    required this.duration,
  });

  PlayerStateModel copyWith({
    bool? isPlaying,
    Duration? position,
    Duration? duration,
  }) {
    return PlayerStateModel(
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
    );
  }
}
