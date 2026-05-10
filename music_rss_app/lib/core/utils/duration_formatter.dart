String formatDuration(Duration duration) {
  final minutes = duration.inMinutes.remainder(60).toString();

  final seconds = duration.inSeconds.remainder(60).toString();

  return '$minutes:${seconds.padLeft(2, '0')}';
}
