import 'dart:math';
import 'package:firebase_test/config/routes/app_pages.dart';
import 'package:firebase_test/config/themes/assets.dart';
import 'package:firebase_test/core/constants/customTextForm.dart';
import 'package:firebase_test/core/constants/screen_extension.dart';
import 'package:firebase_test/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const Color.fromARGB(255, 235, 142, 2),
        titleSpacing: 0,
      ),
      body: Obx(() {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: SingleChildScrollView(
                child: Form(
                  key: authController.formKey_signUp,
                  child: Column(
                    children: [
                      Image.asset(
                        Assets.assetsImagesIcon,
                        width: context.screenWidth * 0.7,
                        height: context.screenHeight * 0.3,
                      ),
                      CustomTextFormField(
                          hintText: "User name",
                          controller: authController.usernameController,
                          min: 3,
                          max: 100),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          validationType: "email",
                          hintText: "E-mail",
                          controller: authController.signupEmailController,
                          min: 8,
                          max: 100),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          validationType: "password",
                          hintText: "Password",
                          controller: authController.signupPasswordController,
                          visPassword: true,
                          showVisPasswordToggle: true,
                          min: 8,
                          max: 50),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          validationType: "password",
                          hintText: "Confirm Password",
                          controller: authController.confirmPasswordController,
                          visPassword: true,
                          showVisPasswordToggle: true,
                          min: 8,
                          max: 50),
                      const SizedBox(
                        height: 23,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: max(context.screenHeight * 0.06, 50),
                        child: MaterialButton(
                          onPressed: () async {
                            await authController.signUpWithEmailAndPassword(
                                authController.signupEmailController.text,
                                authController.signupPasswordController.text,
                                authController.confirmPasswordController.text);
                          },
                          color: const Color.fromARGB(255, 235, 142, 2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Do you have an account?"),
                          Transform.translate(
                            offset: const Offset(-10, 0),
                            child: TextButton(
                              onPressed: () {
                                Get.toNamed(AppPages.login);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 235, 142, 2),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )
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
        );
      }),
    );
  }
}
