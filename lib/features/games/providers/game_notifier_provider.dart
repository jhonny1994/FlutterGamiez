import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamiez/features/games/application/game_notifier.dart';
import 'package:gamiez/features/games/domain/game_response.dart';
import 'package:gamiez/features/games/providers/dio_provider.dart';

final gameNotifierProvider = StateNotifierProvider<GameNotifier, AsyncValue<GameResponse>>((ref) {
  return GameNotifier(ref.read(dioProvider));
});
