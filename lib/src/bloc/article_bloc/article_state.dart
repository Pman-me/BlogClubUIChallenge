part of 'article_bloc.dart';

abstract class ArticleState extends Equatable{


  @override
  List<Object> get props =>[];
}

class ArticleLoading extends ArticleState {}

class ArticleSuccess extends ArticleState {
  final ArticleModel article;

  ArticleSuccess({required this.article});
}

