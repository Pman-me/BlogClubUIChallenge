class ArticleModel{

  final String author;
  final String caption;
  final String title;
  final String description;
  final String likes;
  final String time;
  final bool isBookmarked;
  final String postImageFileName;
  final String authorImageFileName;

  ArticleModel({
    required this.author,
    required this.caption,
    required this.title,
    required this.description,
    required this.likes,
    required this.time,
    required this.isBookmarked,
    required this.postImageFileName,
    required this.authorImageFileName,
  });
}