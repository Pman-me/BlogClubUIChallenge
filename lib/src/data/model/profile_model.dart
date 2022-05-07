import 'package:blog_club/src/data/model/post_model.dart';

class ProfileModel{

  final String id;
  final String fullname;
  final String field;
  final String aboutMe;
  final List<PostModel> posts;
  final String following;
  final String followers;
  final String profileImageFileName;

  ProfileModel({
    required this.id,
    required this.fullname,
    required this.field,
    required this.aboutMe,
    required this.posts,
    required this.following,
    required this.followers,
    required this.profileImageFileName,
  });
}