import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String email;
  String uid;
  String profileImageUrl;
  String username;
  String bio;
  List following;
  List followers;

  UserModel({
    required this.uid,
    required this.email,
    required this.bio,
    required this.username,
    required this.profileImageUrl,
    required this.following,
    required this.followers,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "bio": bio,
        "profileImageUrl": profileImageUrl,
        "following": following,
        "followers": followers,
      };

  static UserModel fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
        uid: snap["uid"],
        email: snap["email"],
        bio: snap["bio"],
        username: snap["username"],
        profileImageUrl: snap["profileImageUrl"],
        following: snap["following"],
        followers: snap["followers"]);
  }
}
