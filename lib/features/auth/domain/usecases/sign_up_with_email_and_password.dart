import 'package:firebase_test/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_test/features/auth/domain/repositories/auth_repository.dart';

class SignUpWithEmailAndPassword {
  final AuthRepository repository;

  SignUpWithEmailAndPassword(this.repository);
  Future<UserEntity?> call(String email, String password) async {
    return await repository.signUpWithEmailAndPassword(email, password);
  }
}
