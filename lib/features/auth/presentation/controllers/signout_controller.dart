import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:firebase_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_test/features/auth/domain/usecases/sign_out.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignOutController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late final AuthRepository _authRepository;
  late final SignOut _signOut;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _authRepository = AuthRepositoryImpl(_auth, _googleSignIn);
    _signOut = SignOut(_authRepository);
  }

  Future<void> signOut() async {
    try {
      isLoading.value = true;
      await _signOut();
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
