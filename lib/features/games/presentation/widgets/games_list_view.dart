import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamiez/features/games/domain/game_response.dart';
import 'package:gamiez/features/games/presentation/game_details_screen.dart';
import 'package:gamiez/features/games/providers/game_notifier_provider.dart';
import 'package:gap/gap.dart';

class GamesListView extends ConsumerStatefulWidget {
  const GamesListView(
    this.data,
    this.title, {
    super.key,
  });

  final GameResponse data;
  final String title;

  @override
  ConsumerState<GamesListView> createState() => _GamesListViewState();
}

class _GamesListViewState extends ConsumerState<GamesListView> {
  bool isLoading = false;

  final _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(scrollListner);
  }

  Future<void> scrollListner() async {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        isLoading = !isLoading;
      });
      await ref.read(gameNotifierProvider.notifier).getNextPageGamesForState(
            data: widget.data,
            currentPage: widget.data.next,
          );
      isLoading = !isLoading;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Gap(8),
        Expanded(
          child: GridView.builder(
            physics: isLoading ? const NeverScrollableScrollPhysics() : null,
            controller: _scrollController,
            itemCount: widget.data.games.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final game = widget.data.games.elementAt(index);
              return Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () async {
                    final gameDetails = await ref.watch(gameNotifierProvider.notifier).getGameDetails(game.id);
                    if (context.mounted) {
                      await Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) => GameDetailsScreen(game: gameDetails),
                          fullscreenDialog: true,
                        ),
                      );
                    }
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: game.id,
                        child: CachedNetworkImage(
                          imageUrl: game.backgroundImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.75),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Icon(Icons.favorite_outline),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ColoredBox(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.75),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Column(
                              children: [
                                Text(
                                  game.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.mode_comment,
                                          size: 15,
                                          color: Colors.yellow,
                                        ),
                                        Text(
                                          game.reviewsCount.toString(),
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star_rounded,
                                          size: 15,
                                          color: Colors.yellow,
                                        ),
                                        Text(
                                          '${game.rating.toStringAsFixed(1)}/${game.ratingTop}',
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (isLoading)
          const Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
