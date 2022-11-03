import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter_firebase/utils/dimension.dart';

import '../controllers/user_controllers.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout(
      {super.key,
      required this.mobileScreenLayout,
      required this.webScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    // NOTE get user details if user authenticated and has Data.
    getUser();
  }

  getUser() async {
    await Get.put(UserController()).refreshCurrentUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        // web screen
        return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;
      // mobile screen
    });
  }
}
