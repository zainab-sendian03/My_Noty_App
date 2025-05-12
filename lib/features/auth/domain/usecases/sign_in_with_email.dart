import 'package:firebase_test/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_test/features/auth/domain/repositories/auth_repository.dart';

class SignInWithEmail {
  final AuthRepository repository;

  SignInWithEmail(this.repository);

  Future<UserEntity?> call(String email, String password) async {
    return await repository.signInWithEmailAndPassword(email, password);
  }
}
