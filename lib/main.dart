import 'package:device_preview/device_preview.dart';
import 'package:firebase_test/core/constants/screen_size_inherited_widget.dart';
import 'package:firebase_test/features/auth/presentation/pages/home.dart';
import 'package:firebase_test/features/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:firebase_test/features/auth/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD4bh-nJGqNVbyOpiv_e9Njo6FLm1betMM",
      appId: "1:175951408235:android:707659b579f7f51f63952e",
      messagingSenderId: "175951408235",
      projectId: "test-noteapp-9e978",
      storageBucket: "test-noteapp-9e978.firebasestorage.app",
    ),
  );
  runApp(
    DevicePreview(
        enabled: true,
        builder: (context) {
          var screenWidth = MediaQuery.of(context).size.width;
          var screenHight = MediaQuery.of(context).size.height;
          return ScreenSizeInheritedWidget(
              screenWidth: screenWidth,
              screenHight: screenHight,
              child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Firebase Test',
                theme: ThemeData(
                  primarySwatch: Colors.orange,
                ),
                initialRoute: '/login',
                getPages: [
                  GetPage(name: '/login', page: () => LoginPage()),
                  GetPage(name: '/signup', page: () => SignUpPage()),
                  GetPage(name: '/home', page: () => Home()),
                ],
              ));
        }),
  );
}
