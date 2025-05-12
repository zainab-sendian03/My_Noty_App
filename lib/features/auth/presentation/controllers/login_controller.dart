import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:firebase_test/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_test/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  RxBool isLoading = false.obs;
  late final AuthRepository _authRepository;
  late final SignInWithGoogle _signInWithGoogle;
  Rx<UserEntity?> currentUser = Rx<UserEntity?>(null);
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    _authRepository = AuthRepositoryImpl(_auth, _googleSignIn);
    _signInWithGoogle = SignInWithGoogle(_authRepository);
    ever(currentUser, _handleAuthStateChange);
  }

  void _handleAuthStateChange(UserEntity? user) {
    if (user != null && user.uid != null) {
      Get.offAllNamed("/home");
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      final user =
          await _authRepository.signInWithEmailAndPassword(email, password);
      if (user != null && user.uid != null) {
        currentUser.value = user;
      } else {
        throw Exception('Failed to sign in with email and password');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      await _signInWithGoogle();
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      isLoading.value = true;
      await _authRepository.signOut();
      currentUser.value = null;
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
