import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter_firebase/resources/auth_methods.dart';
import 'package:instagram_clone_flutter_firebase/screens/signup_screen.dart';
import 'package:instagram_clone_flutter_firebase/utils/colors.dart';
import 'package:instagram_clone_flutter_firebase/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

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

  void navigateToSignup() {
    // NOTE This is Default Navigate way to flutter
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: ((context) => const SignupScreen())));
    // NOTE this is the GetX way to navigate between pages
    Get.to(() => const SignupScreen());
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
              const SizedBox(height: 100),
              // instagram logo
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              // email
              TextFieldInput(
                  hintText: "Enter your email",
                  textEditingController: _emailController,
                  textInputType: TextInputType.emailAddress),
              const SizedBox(height: 20),
              // password
              TextFieldInput(
                  hintText: "Enter your password",
                  textEditingController: _passwordController,
                  isPassword: true,
                  textInputType: TextInputType.visiblePassword),
              const SizedBox(height: 20),
              // login button
              InkWell(
                onTap: loginUser,
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
                      : const Text("Login"),
                ),
              ),
              const SizedBox(height: 40),
              // signup redirect
              GestureDetector(
                onTap: navigateToSignup,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text("Don't have an account?",
                            style: TextStyle(fontSize: 16)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          " Sign up",
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
