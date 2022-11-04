import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String uid;
  String profileImageUrl;
  String username;
  String postId;
  String comment;
  String commentId;
  DateTime datePublished;
  List likes;

  CommentModel(
      {required this.uid,
      required this.profileImageUrl,
      required this.username,
      required this.postId,
      required this.comment,
      required this.likes,
      required this.datePublished,
      required this.commentId});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "profileImageUrl": profileImageUrl,
        "postId": postId,
        "comment": comment,
        "likes": likes,
        "commentId": commentId,
        "datePublished": datePublished
      };

  static CommentModel fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return CommentModel(
        uid: snap["uid"],
        username: snap["username"],
        profileImageUrl: snap["profileImageUrl"],
        postId: snap["postId"],
        comment: snap["comment"],
        commentId: snap["commentId"],
        likes: snap["likes"],
        datePublished: (snap["datePublished"] as Timestamp).toDate());
  }
}
