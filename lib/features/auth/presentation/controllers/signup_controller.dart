import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:firebase_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_test/features/auth/domain/usecases/sign_up_with_email_and_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_test/features/auth/domain/entities/user_entity.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpController extends GetxController {
  final Rx<UserEntity?> currentUser = Rx<UserEntity?>(null);
  final RxBool isLoading = false.obs;
  late final AuthRepository _authRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final formKey = GlobalKey<FormState>();
  late final SignUpWithEmailAndPassword _signUpWithEmailAndPassword;

  @override
  void onInit() {
    super.onInit();
    _authRepository = AuthRepositoryImpl(_auth, _googleSignIn);
    _signUpWithEmailAndPassword = SignUpWithEmailAndPassword(_authRepository);
    ever(currentUser, _handleAuthStateChange);
  }

  void _handleAuthStateChange(UserEntity? user) {
    if (user != null) {
      Get.offAllNamed('/home');
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      isLoading.value = true;
      final user = await _signUpWithEmailAndPassword(email, password);
      currentUser.value = user;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
