import 'package:firebase_test/config/routes/app_pages.dart';
import 'package:firebase_test/features/auth/presentation/pages/login_page.dart';
import 'package:firebase_test/features/auth/presentation/pages/sign_up_page.dart';
import 'package:firebase_test/features/note/presentation/pages/add_note_page.dart';
import 'package:firebase_test/view/home.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final List<GetPage> routes = [
    GetPage(
      name: AppPages.home,
      page: () => const Home(),
      transition: Transition.fadeIn,
    ),
    // GetPage(
    //   name: AppPages.forgetPassword,
    //   page: () => const ForgetPassword(),
    //   transition: Transition.fadeIn,
    // ),
    GetPage(
      name: AppPages.signUp,
      page: () => const SignUpPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppPages.login,
      page: () => const LoginPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppPages.addNote,
      page: () => const AddNotePage(),
      transition: Transition.fadeIn,
    ),
  ];
}
