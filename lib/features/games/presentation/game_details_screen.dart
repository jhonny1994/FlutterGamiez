import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gamiez/features/games/domain/game_details_response.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:readmore/readmore.dart';

class GameDetailsScreen extends StatelessWidget {
  const GameDetailsScreen({
    required this.game,
    super.key,
  });
  final GameDetailsResponse game;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CircleAvatar(
          backgroundImage: AssetImage('assets/gamiez.png'),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 8,
              right: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 3,
                  ),
                  child: Hero(
                    tag: game.id,
                    child: Container(
                      color: Theme.of(context).colorScheme.secondary,
                      padding: const EdgeInsets.all(4),
                      child: CachedNetworkImage(
                        imageUrl: game.backgroundImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      game.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const Gap(8),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Gap(8),
                ReadMoreText(
                  game.description,
                  trimMode: TrimMode.Line,
                  trimLines: 4,
                  trimCollapsedText: '\nShow more',
                  trimExpandedText: '\nShow less',
                  lessStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const Gap(8),
                Divider(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.125),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Ratings',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          itemCount: game.ratingTop,
                          itemSize: 15,
                          initialRating: game.rating,
                          allowHalfRating: true,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        Text(
                          ' / ${game.ratingsCount} reviews',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(8),
                Row(
                  children: game.ratings
                      .map(
                        (e) => Expanded(
                          child: CircularPercentIndicator(
                            animation: true,
                            footer: Text(
                              e.title,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            radius: 30,
                            percent: e.percent / 100,
                            center: Text(
                              '${e.percent.round()}%',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const Gap(8),
                Divider(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.125),
                ),
                Text(
                  'Publisher',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Gap(8),
                Wrap(
                  children: game.publishers
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(
                            right: 4,
                            bottom: 4,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Text(e),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const Gap(8),
                Divider(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.125),
                ),
                Text(
                  'Platforms',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Gap(8),
                Wrap(
                  children: game.parentPlatforms
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(
                            right: 4,
                            bottom: 4,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Text(e),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const Gap(8),
                Divider(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.125),
                ),
                Text(
                  'Stores',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Gap(8),
                Wrap(
                  children: game.stores
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(
                            right: 4,
                            bottom: 4,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Text(e),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const Gap(8),
                Divider(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.125),
                ),
                Text(
                  'Tags',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Gap(8),
                Wrap(
                  children: game.tags
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(
                            right: 4,
                            bottom: 4,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Text(e),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
