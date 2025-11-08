import 'package:firebase_test/config/routes/app_pages.dart';
import 'package:firebase_test/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:get/get.dart';
import 'package:firebase_test/core/di/service_locator.dart';

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

  // Initialize Firebase App Check (optional but recommended)
  // This removes the App Check warning
  try {
    await FirebaseAppCheck.instance.activate(
      // For debug builds, use debug provider
      // For production, configure with deviceCheckProvider (iOS) or playIntegrityProvider (Android)
      androidProvider: AndroidProvider.debug,
    );
  } catch (e) {
    // App Check initialization is optional, so we continue even if it fails
    print('App Check initialization failed (this is okay): $e');
  }

  // Initialize dependencies
  ServiceLocator.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Test',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: AppPages.login,
      getPages: AppRoutes.routes,
    ),
  );
}
