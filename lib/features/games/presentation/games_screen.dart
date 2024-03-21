import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamiez/features/core/presentation/widgets/error_screen.dart';
import 'package:gamiez/features/core/presentation/widgets/loading_screen.dart';
import 'package:gamiez/features/games/presentation/widgets/games_list_view.dart';
import 'package:gamiez/features/games/providers/game_notifier_provider.dart';

class GamesScreen extends ConsumerStatefulWidget {
  const GamesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GamesScreenState();
}

class _GamesScreenState extends ConsumerState<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    final games = ref.watch(gameNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CircleAvatar(
          backgroundImage: AssetImage('assets/gamiez.png'),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: games.when(
                  data: (data) => GamesListView(
                    data,
                    'Recommended games',
                  ),
                  error: (error, stackTrace) => ErrorScreen(error: error.toString()),
                  loading: () => const LoadingScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
