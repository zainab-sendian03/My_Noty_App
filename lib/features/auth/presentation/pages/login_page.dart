import 'dart:math';
import 'package:firebase_test/config/routes/app_pages.dart';
import 'package:firebase_test/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_test/core/constants/customTextForm.dart';
import 'package:firebase_test/core/constants/screen_extension.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../config/themes/assets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const Color.fromARGB(255, 235, 142, 2),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() => Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Form(
                    key: authController.formKey_login,
                    child: Column(
                      children: [
                        Image.asset(
                          Assets.assetsImagesIcon,
                          width: context.screenWidth * 0.7,
                          height: context.screenHeight * 0.3,
                        ),
                        CustomTextFormField(
                          hintText: "email",
                          controller: authController.loginEmailController,
                          min: 10,
                          max: 100,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          hintText: "Password",
                          controller: authController.loginPasswordController,
                          min: 8,
                          max: 20,
                          visPassword: true,
                          showVisPasswordToggle: true,
                        ),
                        Transform.translate(
                          offset: const Offset(100, -10),
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(AppPages.forgetPassword);
                            },
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(EdgeInsets.zero),
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.transparent),
                            ),
                            child: const Text(
                              "Forget Password?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () async {
                              await authController.signInWithEmail(
                                authController.loginEmailController.text.trim(),
                                authController.loginPasswordController.text
                                    .trim(),
                              );
                            },
                            height: max(context.screenHeight * 0.06, 50),
                            color: const Color.fromARGB(255, 235, 142, 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 26),
                        SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () async {
                              await authController.signInWithGoogle();
                            },
                            height: max(context.screenHeight * 0.06, 50),
                            color: Colors.red[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Login with google ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                Image.asset(
                                  Assets.assetsImagesGoogle,
                                  width: context.screenHeight * 0.03,
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't you have an account?"),
                            Transform.translate(
                              offset: const Offset(-10, 0),
                              child: TextButton(
                                onPressed: () {
                                  Get.toNamed(AppPages.signUp);
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 235, 142, 2),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (authController.isLoading.value)
                Stack(
                  children: [
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Center(
                      child: LoadingAnimationWidget.waveDots(
                        color: Colors.orange,
                        size: 40,
                      ),
                    ),
                  ],
                ),
            ],
          )),
    );
  }
}
