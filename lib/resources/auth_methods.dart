import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter_firebase/models/user.dart';
import 'package:instagram_clone_flutter_firebase/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getCurrentUserDetails() async {
    // NOTE get data from firebase firestore where collection name is 'users' and doc name is [uid]
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return UserModel.fromSnapshot(snapshot);
  }

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List? file}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl = await StorageMethods()
            .uploadImageToStorage("profile_images", file!, false);

        UserModel user = UserModel(
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            username: username,
            profileImageUrl: downloadUrl,
            following: [],
            followers: []);

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}
