import 'package:firebase_test/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signInWithEmailAndPassword(String email, String password);
  Future<UserEntity?> signInWithGoogle();
  Future<UserEntity?> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<UserEntity?> getCurrentUser();
}
