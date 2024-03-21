import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamiez/env.dart';
import 'package:gamiez/features/games/domain/game_details_response.dart';
import 'package:gamiez/features/games/domain/game_response.dart';

class GameNotifier extends StateNotifier<AsyncValue<GameResponse>> {
  GameNotifier(this._dio) : super(const AsyncValue.loading()) {
    getGamesForState();
  }

  final Dio _dio;

  Future<void> getGamesForState({
    String? genre,
  }) async {
    state = const AsyncValue.loading();
    try {
      final queryParameters = genre == null
          ? {
              'key': apiKey,
            }
          : {
              'key': apiKey,
              'genres': genre,
            };
      final request = await _dio.get<Map<String, dynamic>>(
        gamesUrl,
        queryParameters: queryParameters,
      );
      final result = GameResponse.fromJson(request.data!);
      state = AsyncValue.data(result);
    } on DioException catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> getNextPageGamesForState({
    required GameResponse data,
    required int currentPage,
    String? genre,
  }) async {
    final queryParameters = genre == null
        ? {
            'key': apiKey,
            'page': currentPage,
          }
        : {
            'key': apiKey,
            'page': currentPage,
            'genres': genre,
          };
    final request = await _dio.get<Map<String, dynamic>>(
      gamesUrl,
      queryParameters: queryParameters,
    );
    final result = GameResponse.fromJson(request.data!);
    state = AsyncValue.data(
      result.copyWith(
        games: [...data.games, ...result.games],
      ),
    );
  }

  Future<GameDetailsResponse> getGameDetails(int gameId) async {
    final queryParameters = {
      'key': apiKey,
    };
    final request = await _dio.get<Map<String, dynamic>>(
      '$gamesUrl/$gameId',
      queryParameters: queryParameters,
    );
    final result = GameDetailsResponse.fromJson(request.data!);
    return result;
  }
}
