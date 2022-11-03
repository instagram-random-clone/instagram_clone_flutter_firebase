import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String description;
  String uid;
  String profileImageUrl;
  String username;
  String postIs;
  DateTime datePublished;
  String postUrl;
  List likes;

  PostModel({
    required this.description,
    required this.uid,
    required this.datePublished,
    required this.likes,
    required this.profileImageUrl,
    required this.postIs,
    required this.postUrl,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "description": description,
        "postUrl": postUrl,
        "profileImageUrl": profileImageUrl,
        "likes": likes,
        "datePublished": datePublished,
        "postIs": postIs,
      };

  static PostModel fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return PostModel(
        username: snap["username"],
        uid: snap["uid"],
        description: snap["description"],
        postUrl: snap["postUrl"],
        profileImageUrl: snap["profileImageUrl"],
        likes: snap["likes"],
        postIs: snap["postIs"],
        datePublished: (snap["datePublished"] as Timestamp).toDate());
  }
}
