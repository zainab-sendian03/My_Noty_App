import 'dart:math';
import 'package:firebase_test/features/auth/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_test/core/constants/customTextForm.dart';
import 'package:firebase_test/core/constants/screen_extension.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const Color.fromARGB(255, 235, 142, 2),
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
                    key: loginController.formKey,
                    child: Column(
                      children: [
                        Image.asset(
                          "asset/images/icon.png",
                          width: context.screenWidth * 0.7,
                          height: context.screenHeight * 0.3,
                        ),
                        CustomTextFormField(
                          hintText: "email",
                          controller: emailController,
                          min: 10,
                          max: 100,
                          validationType: 'email',
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          hintText: "Password",
                          controller: passwordController,
                          min: 8,
                          max: 20,
                          visPassword: true,
                          showVisPasswordToggle: true,
                          validationType: 'password',
                        ),
                        Transform.translate(
                          offset: const Offset(100, -10),
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed('/forgot-password');
                            },
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
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
                              await loginController.signInWithEmailAndPassword(
                                emailController.text.trim(),
                                passwordController.text.trim(),
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
                              await loginController.signInWithGoogle();
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
                                  "asset/images/R.png",
                                  width: context.screenHeight * 0.05,
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
                                  Get.toNamed('/signup');
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
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
              if (loginController.isLoading.value)
                Center(
                  child: LoadingAnimationWidget.waveDots(
                    color: Colors.orange,
                    size: 40,
                  ),
                ),
            ],
          )),
    );
  }
}
