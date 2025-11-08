import 'package:firebase_test/config/routes/app_pages.dart';
import 'package:firebase_test/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_test/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:firebase_test/features/auth/domain/usecases/sign_up_with_email_and_password.dart';
import 'package:firebase_test/features/auth/domain/usecases/sign_out.dart';
import 'package:firebase_test/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository;

  // Use cases
  late final SignInWithEmail _signInWithEmail;
  late final SignUpWithEmailAndPassword _signUpWithEmailAndPassword;
  late final SignOut _signOut;
  late final SignInWithGoogle _signInWithGoogle;
  final RxString errorMassege = "".obs;

  RxBool isLoading = false.obs;
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController signupEmailController = TextEditingController();
  final TextEditingController signupPasswordController =
      TextEditingController();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  Rx<UserEntity?> currentUser = Rx<UserEntity?>(null);
  final formKey_login = GlobalKey<FormState>();
  final formKey_signUp = GlobalKey<FormState>();

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  void onInit() {
    super.onInit();
    _initializeUseCases();
    ever(currentUser, _handleAuthStateChange);
  }

  void _initializeUseCases() {
    _signInWithEmail = SignInWithEmail(_authRepository);
    _signUpWithEmailAndPassword = SignUpWithEmailAndPassword(_authRepository);
    _signOut = SignOut(_authRepository);
    _signInWithGoogle = SignInWithGoogle(_authRepository);
  }

  void _handleAuthStateChange(UserEntity? user) {
    if (user != null && user.uid != null) {
      Get.offAllNamed(AppPages.home);
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    if (!formKey_login.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      errorMassege.value = '';

      final result = await _signInWithEmail(email, password);
      result.fold((failure) {
        // Debug: Log the statusCode to see what it is
        print('🔍 Failure statusCode: ${failure.statusCode}');
        print('🔍 Failure message: ${failure.errMessage}');

        // Handle different status codes
        if (failure.statusCode == 401 || failure.statusCode == 400) {
          errorMassege.value = "Email or password is incorrect";
        } else if (failure.statusCode == 500) {
          errorMassege.value = "Server error. Please try again later";
        } else {
          errorMassege.value = failure.errMessage.isNotEmpty
              ? failure.errMessage
              : "An error occurred";
        }

        Get.snackbar(
          "Error",
          errorMassege.value,
          snackPosition: SnackPosition.BOTTOM,
        );
      }, (user) {
        currentUser.value = user;
        Get.snackbar(
          "Success",
          "Login successful",
          snackPosition: SnackPosition.BOTTOM,
        );
      });
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

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      errorMassege.value = '';
      final result = await _signInWithGoogle();
      result.fold(
        (failure) {
          if (failure.statusCode == 400) {
            errorMassege.value = "Email or password is incorrect";
          } else if (failure.statusCode == 500) {
            errorMassege.value = "Server error. Please try again later";
          } else {
            errorMassege.value = failure.errMessage.isNotEmpty
                ? failure.errMessage
                : "An error occurred";
          }
          Get.snackbar(
            "Error",
            errorMassege.value,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        (user) {
          currentUser.value = user;
          Get.snackbar(
            "Success",
            "Login successful",
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      );
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

  Future<void> signOut() async {
    try {
      isLoading.value = true;
      final result = await _signOut();
      result.fold(
        (failure) => Get.snackbar(
          "Error",
          failure.errMessage,
          snackPosition: SnackPosition.BOTTOM,
        ),
        (_) {
          currentUser.value = null;
          Get.offAllNamed(AppPages.login);
        },
      );
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

  Future<void> signUpWithEmailAndPassword(
      String email, String password, String confirmPassword) async {
    if (!formKey_signUp.currentState!.validate()) {
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;
      errorMassege.value = '';
      final username = usernameController.text.trim();
      final result = await _signUpWithEmailAndPassword(
        email,
        password,
        displayName: username.isNotEmpty ? username : null,
      );
      result.fold(
        (failure) {
          if (failure.statusCode == 400) {
            errorMassege.value = "Email already in use";
          } else if (failure.statusCode == 500) {
            errorMassege.value = "Server error. Please try again later";
          } else {
            errorMassege.value = failure.errMessage.isNotEmpty
                ? failure.errMessage
                : "An error occurred";
          }
          Get.snackbar(
            "Error",
            errorMassege.value,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        (user) {
          currentUser.value = user;
          Get.snackbar(
            "Success",
            "Account created successfully!",
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      );
    } catch (e, stackTrace) {
      print('Sign up error: $e');
      print('Stack trace: $stackTrace');
      Get.snackbar(
        "Sign Up Error",
        "An unexpected error occurred: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    usernameController.dispose();
    confirmPasswordController.dispose();
  }
}
