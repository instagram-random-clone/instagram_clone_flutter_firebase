import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone_flutter_firebase/models/comment.dart';
import 'package:instagram_clone_flutter_firebase/models/post.dart';
import 'package:uuid/uuid.dart';

import 'storage_methods.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(Uint8List file, String description, String uid,
      String profileImageUrl, String username) async {
    String res = "Some error occurred";
    try {
      String postUrl =
          await StorageMethods().uploadImageToStorage("posts", file, true);
      String postId = const Uuid().v4();
      PostModel post = PostModel(
          description: description,
          uid: uid,
          datePublished: DateTime.now(),
          likes: [],
          profileImageUrl: profileImageUrl,
          postId: postId,
          postUrl: postUrl,
          username: username);

      await _firestore.collection("posts").doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likeDislikePost(String uid, String postId, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([uid])
        });
      }
    } catch (err) {
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }

  Future<void> commentPost(String uid, String postId, String profileImageUrl,
      String username, String comment) async {
    try {
      String commentId = const Uuid().v4();
      CommentModel cm = CommentModel(
          uid: uid,
          profileImageUrl: profileImageUrl,
          username: username,
          postId: postId,
          comment: comment,
          likes: [],
          datePublished: DateTime.now(),
          commentId: commentId);

      await _firestore
          .collection("posts")
          .doc(postId)
          .collection("comments")
          .doc(commentId)
          .set(cm.toJson());
    } catch (err) {
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }
}
