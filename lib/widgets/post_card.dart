import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter_firebase/models/post.dart';
import 'package:instagram_clone_flutter_firebase/utils/colors.dart';

class PostCard extends StatelessWidget {
  final PostModel postData;
  const PostCard({super.key, required this.postData});

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
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
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
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite, color: Colors.red),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.chat_bubble_outline),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {},
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
            ? Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: Row(
                  children: [
                    const Text("Liked by "),
                    Text(
                      postData.likes[0],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(" and "),
                    Text(
                      "${postData.likes.length}others",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
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
