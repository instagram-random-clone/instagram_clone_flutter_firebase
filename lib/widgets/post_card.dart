import 'package:get/get.dart';
import 'package:instagram_clone_flutter_firebase/controllers/user_controllers.dart';
import 'package:instagram_clone_flutter_firebase/resources/firestore_methods.dart';
import 'package:instagram_clone_flutter_firebase/screens/comments_screen.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter_firebase/models/post.dart';
import 'package:instagram_clone_flutter_firebase/utils/colors.dart';

class PostCard extends StatelessWidget {
  final PostModel postData;
  const PostCard({super.key, required this.postData});

  showPostOption(BuildContext context) {
    // NOTE you can create BottomSheet both native and using GetX
    // showModalBottomSheet(
    //   context: context,
    //   builder: (BuildContext context) => Column(
    //     children: [
    //       TextButton(onPressed: () {}, child: const Text("Delete")),
    //       TextButton(onPressed: () {}, child: const Text("Block User")),
    //       TextButton(onPressed: () {}, child: const Text("Report")),
    //       TextButton(onPressed: () {}, child: const Text("Close"))
    //     ],
    //   ),
    // );
    Get.bottomSheet(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () {},
              child: const Text('Delete'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () {},
              child: const Text('Delete'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () => Get.back(),
              child: const Text('Close'),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        elevation: 1);
  }

  showCommentsScreen() {
    Get.to(() => CommentsScreen(
          postId: postData.postId,
          profileImageUrl: postData.profileImageUrl,
          uid: postData.uid,
          username: postData.username,
        ));
  }

  showShare() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // profile
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(postData.profileImageUrl),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // name
                  Text(postData.username,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              IconButton(
                  onPressed: () => showPostOption(context),
                  icon: const Icon(Icons.more_vert))
            ],
          ),
        ),
        // post
        SizedBox(
          width: double.infinity,
          child: Image.network(postData.postUrl),
        ),
        // like, commends,share buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GetBuilder<UserController>(
                    init: UserController(),
                    builder: (_) {
                      return IconButton(
                        onPressed: () => FirestoreMethods().likeDislikePost(
                            _.user.uid, postData.postId, postData.likes),
                        icon: postData.likes.contains(_.user.uid)
                            ? const Icon(Icons.favorite, color: Colors.red)
                            : const Icon(Icons.favorite_outline,
                                color: primaryColor),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: showCommentsScreen,
                    icon: const Icon(Icons.chat_bubble_outline),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: showShare,
                    icon: const Icon(Icons.share),
                  )
                ],
              ),
              IconButton(
                onPressed: () {},
                // icon: const Icon(Icons.bookmark),
                icon: const Icon(Icons.bookmark_outline),
              ),
            ],
          ),
        ),
        // likes
        postData.likes.isNotEmpty
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: Text("${postData.likes.length} likes"),
              )
            : Container(),
        // comments
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: RichText(
            text: TextSpan(
                style: const TextStyle(color: primaryColor),
                children: [
                  TextSpan(
                      text: postData.username,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: " ${postData.description}")
                ]),
          ),
        ),

        Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
            child: GestureDetector(
              onTap: () {},
              child: const Text(
                "View all 200 comments",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14, color: secondaryColor),
              ),
            )),
        // Time
        Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Text(
              DateFormat('yyyy-MM-dd').format(postData.datePublished),
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 14, color: secondaryColor),
            ))
      ],
    );
  }
}
