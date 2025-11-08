import 'package:firebase_test/config/routes/app_pages.dart';
import 'package:firebase_test/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NOTY APP",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 235, 142, 2),
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  title: const Text("Logout",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel",
                            style: TextStyle(color: Colors.black))),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor:
                              const Color.fromARGB(255, 235, 142, 2),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          await authController.signOut();
                          authController.confirmPasswordController.clear();
                          authController.usernameController.clear();
                          authController.signupEmailController.clear();
                          authController.signupPasswordController.clear();
                          authController.loginEmailController.clear();
                          authController.loginPasswordController.clear();
                        },
                        child: const Text("Logout",
                            style: TextStyle(color: Colors.white))),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 253, 246, 236),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.offAllNamed(AppPages.addNote);
        },
        backgroundColor: const Color.fromARGB(255, 235, 142, 2),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
