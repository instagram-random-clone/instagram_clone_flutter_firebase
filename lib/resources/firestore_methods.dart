import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
      String postIs = const Uuid().v4();
      PostModel post = PostModel(
          description: description,
          uid: uid,
          datePublished: DateTime.now(),
          likes: [],
          profileImageUrl: profileImageUrl,
          postIs: postIs,
          postUrl: postUrl,
          username: username);

      await _firestore.collection("posts").doc(postIs).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
