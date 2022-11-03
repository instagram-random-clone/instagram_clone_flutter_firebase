import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter_firebase/models/user.dart';
import 'package:instagram_clone_flutter_firebase/resources/auth_methods.dart';

class UserController extends GetxController {
  UserModel user = UserModel(
      uid: "",
      email: "",
      bio: "",
      username: "",
      profileImageUrl: "",
      following: [],
      followers: []);

  Future<void> refreshCurrentUserDetails() async {
    user = await AuthMethods().getCurrentUserDetails();
    update();
  }
}
