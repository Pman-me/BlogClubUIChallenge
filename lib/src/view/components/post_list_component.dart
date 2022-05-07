import 'package:blog_club/gen/colors.gen.dart';
import 'package:blog_club/src/configs/app_theme.dart';
import 'package:blog_club/src/data/model/post_model.dart';
import 'package:blog_club/src/view/components/image_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostListComponent<T> extends StatelessWidget{


  late List<PostModel> _posts;
  late double _itemExtent;
  ScrollPhysics? _physics;

  PostListComponent({required List<PostModel> posts,required double itemExtent,ScrollPhysics? physics}){
    _posts =posts;
    _itemExtent=itemExtent;
    _physics = physics;
  }

  @override
  Widget build(BuildContext context) {


    return SizedBox(
      width: double.maxFinite,
      height: _itemExtent * _posts.length,
      child: ListView.builder(
          itemCount: _posts.length,
          itemExtent: _itemExtent,
          physics: _physics ?? const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            var post = _posts[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 8, color: ColorName.postItemBoxShadowColor)
                  ]),
              child: Row(
                children: [
                  ImageComponent(
                    assetName: post.imageFileName,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            post.caption,
                            style: lightTheme.textTheme.caption!
                                .apply(color: ColorName.primaryColor),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            post.title,
                            style: lightTheme.textTheme.subtitle2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    CupertinoIcons.hand_thumbsup,
                                    size: 20,
                                    color:
                                    lightTheme.textTheme.bodyText2!.color,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    post.likes,
                                    style: lightTheme.textTheme.bodyText2,
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    CupertinoIcons.clock,
                                    size: 20,
                                    color:
                                    lightTheme.textTheme.bodyText2!.color,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    post.time,
                                    style: lightTheme.textTheme.bodyText2,
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  post.isBookmarked
                                      ? CupertinoIcons.bookmark_fill
                                      : CupertinoIcons.bookmark,
                                  size: 16,
                                  color: lightTheme.textTheme.bodyText2!.color,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }


}