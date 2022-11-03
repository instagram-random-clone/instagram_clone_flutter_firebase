import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter_firebase/screens/add_post_screen.dart';

import '../screens/home_screen.dart';

// 0 Home
// 0 Search
// 0 Add Post
// 0 Notification
// 0 Account

var tabNavigationList = [
  const HomeScreen(),
  const Center(
    child: Text("This is Search"),
  ),
  const AddPostScreen(),
  const Center(
    child: Text("This is Notification"),
  ),
  const Center(
    child: Text("This is Account"),
  ),
];
