import 'dart:math';
import 'package:firebase_test/core/constants/customTextForm.dart';
import 'package:firebase_test/core/constants/screen_extension.dart';
import 'package:firebase_test/features/auth/presentation/controllers/signup_controller.dart';
import 'package:firebase_test/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final conpassword = TextEditingController();

  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  key: signUpController.formKey,
                  child: Column(
                    children: [
                      Image.asset(
                        "asset/images/icon.png",
                        width: context.screenWidth * 0.7,
                        height: context.screenHeight * 0.3,
                      ),
                      CustomTextFormField(
                          hintText: "User name",
                          controller: username,
                          min: 3,
                          max: 100),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          hintText: "E-mail",
                          controller: email,
                          min: 8,
                          max: 100),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          hintText: "Password",
                          controller: password,
                          visPassword: true,
                          showVisPasswordToggle: true,
                          min: 8,
                          max: 50),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          hintText: "Confirm Password",
                          controller: conpassword,
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
                            await signUpController.signUpWithEmailAndPassword(
                                email.text, password.text);
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
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginPage()));
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
            if (signUpController.isLoading.value)
              Center(
                child: LoadingAnimationWidget.waveDots(
                  color: Colors.orange,
                  size: 40,
                ),
              ),
          ],
        );
      }),
    );
  }
}
