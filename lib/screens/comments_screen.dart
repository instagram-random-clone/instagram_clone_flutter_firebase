import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter_firebase/models/comment.dart';
import 'package:instagram_clone_flutter_firebase/resources/firestore_methods.dart';
import 'package:instagram_clone_flutter_firebase/widgets/comment_card.dart';

import '../utils/colors.dart';
import '../widgets/text_field_input.dart';

class CommentsScreen extends StatefulWidget {
  final String postId;
  final String username;
  final String profileImageUrl;
  final String uid;
  const CommentsScreen(
      {super.key,
      required this.postId,
      required this.profileImageUrl,
      required this.uid,
      required this.username});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentInputController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentInputController.dispose();
  }

  addComment() async {
    _commentInputController.clear();
    await FirestoreMethods().commentPost(widget.uid, widget.postId,
        widget.profileImageUrl, widget.username, _commentInputController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          elevation: 0,
          title: const Text("Comments"),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back),
          )),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          // NOTE for jump up when keyboard open margin:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(right: 8.0, left: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage("https://picsum.photos/600"),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 16.0),
                  child: TextField(
                    controller: _commentInputController,
                    decoration: const InputDecoration(
                        hintText: "Comment as username",
                        border: InputBorder.none),
                  ),
                ),
              ),
              InkWell(
                onTap: addComment,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Post"),
                ),
              )
            ],
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("posts")
              .doc(widget.postId)
              .collection("comments")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => CommentCard(
                      commentModel:
                          CommentModel.fromSnapshot(snapshot.data!.docs[index]),
                    ));
          }),
    );
  }
}
