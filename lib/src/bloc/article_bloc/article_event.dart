part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable{


  @override
  List<Object> get props =>[];
}

class ArticleStarted extends ArticleEvent{}

class ArticleNavigateToBack extends ArticleEvent{
  BuildContext context;

  ArticleNavigateToBack({required this.context});
}
