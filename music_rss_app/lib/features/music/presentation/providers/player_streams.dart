import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/audio_controller.dart';

final positionStreamProvider = StreamProvider<Duration>((ref) {
  final player = ref.watch(audioControllerProvider);

  return player.positionStream;
});

final durationStreamProvider = StreamProvider<Duration?>((ref) {
  final player = ref.watch(audioControllerProvider);

  return player.durationStream;
});

final playerStateStreamProvider = StreamProvider((ref) {
  final player = ref.watch(audioControllerProvider);

  return player.playerStateStream;
});
