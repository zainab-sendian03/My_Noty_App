import 'package:firebase_test/features/auth/presentation/controllers/signout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SignOutController signOutController = Get.put(SignOutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Note Application",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 235, 142, 2),
        actions: [
          IconButton(
            onPressed: () async {
              await signOutController.signOut();
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
        child: const Text("sssssss"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/add");
        },
        backgroundColor: const Color.fromARGB(255, 235, 142, 2),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
