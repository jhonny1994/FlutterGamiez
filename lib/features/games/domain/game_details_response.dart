// ignore_for_file: invalid_annotation_target, avoid_dynamic_calls

import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_details_response.freezed.dart';
part 'game_details_response.g.dart';

List<String> platformFromJson(List<dynamic> value) {
  return value.map((e) => e['platform']['name'] as String).toList();
}

List<String> genresFromJson(List<dynamic> value) {
  return value.map((e) => e['name'] as String).toList();
}

List<String> storesFromJson(List<dynamic> value) {
  return value.map((e) => e['store']['name'] as String).toList();
}

List<String> tagsFromJson(List<dynamic> value) {
  return value.map((e) => e['name'] as String).toList();
}

List<String> publishsFromJson(List<dynamic> value) {
  return value.map((e) => e['name'] as String).toList();
}

@freezed
class GameDetailsResponse with _$GameDetailsResponse {
  const factory GameDetailsResponse({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'metacritic') required int metacritic,
    @JsonKey(name: 'released') required DateTime released,
    @JsonKey(name: 'background_image') required String backgroundImage,
    @JsonKey(name: 'website') required String website,
    @JsonKey(name: 'rating') required double rating,
    @JsonKey(name: 'rating_top') required int ratingTop,
    @JsonKey(name: 'reddit_url') required String redditUrl,
    @JsonKey(name: 'ratings_count') required int ratingsCount,
    @JsonKey(name: 'metacritic_url') required String metacriticUrl,
    @JsonKey(name: 'reviews_count') required int reviewsCount,
    @JsonKey(name: 'ratings') required List<Rating> ratings,
    @JsonKey(name: 'parent_platforms', fromJson: platformFromJson) required List<String> parentPlatforms,
    @JsonKey(name: 'stores', fromJson: storesFromJson) required List<String> stores,
    @JsonKey(name: 'genres', fromJson: genresFromJson) required List<String> genres,
    @JsonKey(name: 'tags', fromJson: tagsFromJson) required List<String> tags,
    @JsonKey(name: 'publishers', fromJson: publishsFromJson) required List<String> publishers,
    @JsonKey(name: 'description_raw') required String description,
  }) = _GameDetailsResponse;

  factory GameDetailsResponse.fromJson(Map<String, dynamic> json) => _$GameDetailsResponseFromJson(json);
}

@freezed
class Rating with _$Rating {
  const factory Rating({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'count') required int count,
    @JsonKey(name: 'percent') required double percent,
  }) = _Rating;

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
}
