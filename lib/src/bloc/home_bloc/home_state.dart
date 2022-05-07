import 'package:blog_club/src/data/model/category_model.dart';
import 'package:blog_club/src/data/model/post_model.dart';
import 'package:blog_club/src/data/model/story_model.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus { loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;

  late final List<PostModel> posts;

  late final List<StoryModel> stories;

  late final List<CategoryModel> categories;

  int currentIndex;

  HomeState(
      {this.stories = const <StoryModel>[],
      this.posts = const <PostModel>[],
      this.categories = const <CategoryModel>[],
      this.status = HomeStatus.loading,
      this.currentIndex = 0});

  HomeState copyWith({
    HomeStatus? status,
    List<PostModel>? posts,
    List<StoryModel>? stories,
    List<CategoryModel>? categories,
    int currentIndex = 0,
  }) {
    return HomeState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      stories: stories ?? this.stories,
      categories: categories ?? this.categories,
      currentIndex: currentIndex != 0 ? currentIndex : this.currentIndex,
    );
  }

  @override
  List<Object> get props => [status, stories, categories, posts, currentIndex];
}
