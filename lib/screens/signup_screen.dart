import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter_firebase/resources/auth_methods.dart';
import 'package:instagram_clone_flutter_firebase/screens/login_screen.dart';
import 'package:instagram_clone_flutter_firebase/utils/colors.dart';
import 'package:instagram_clone_flutter_firebase/utils/utils.dart';
import 'package:instagram_clone_flutter_firebase/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _profileImage;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void selectImage() async {
    Uint8List _image = await pickImage(ImageSource.gallery);
    setState(() {
      _profileImage = _image;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _profileImage);
    setState(() {
      _isLoading = false;
    });
    if (res == "success") {
      Get.to(() => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout()));
    } else {
      Get.snackbar("error", res);
    }
  }

  void navigateToLogin() {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: ((context) => const LoginScreen())));
    Get.to(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // instagram logo
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 32),
              // profile image
              Stack(
                children: [
                  _profileImage != null
                      ? CircleAvatar(
                          radius: 48,
                          backgroundImage: MemoryImage(_profileImage!),
                        )
                      : const CircleAvatar(
                          radius: 48,
                          backgroundImage:
                              AssetImage("assets/default-profile-picture.jpg"),
                        ),
                  Positioned(
                      bottom: -5,
                      left: 55,
                      child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo)))
                ],
              ),
              const SizedBox(height: 20),
              // username
              TextFieldInput(
                  hintText: "Enter your Username",
                  textEditingController: _usernameController,
                  textInputType: TextInputType.text),
              const SizedBox(height: 10),
              // full name
              TextFieldInput(
                  hintText: "Enter your Bio",
                  textEditingController: _bioController,
                  textInputType: TextInputType.text),
              const SizedBox(height: 10),
              // email
              TextFieldInput(
                  hintText: "Enter your email",
                  textEditingController: _emailController,
                  textInputType: TextInputType.emailAddress),
              const SizedBox(height: 10),
              // password
              TextFieldInput(
                  hintText: "Enter your password",
                  textEditingController: _passwordController,
                  isPassword: true,
                  textInputType: TextInputType.visiblePassword),
              const SizedBox(height: 10),
              // signup button
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)))),
                  child: _isLoading
                      ? const Center(
                          child: SizedBox(
                          height: 14,
                          width: 14,
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ))
                      : const Text("Create Account"),
                ),
              ),
              const SizedBox(height: 20),
              // login redirect
              GestureDetector(
                onTap: navigateToLogin,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text("Already have an account?",
                            style: TextStyle(fontSize: 16)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          " Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // transitioning to sign up button
            ],
          ),
        ),
      )),
    );
  }
}
