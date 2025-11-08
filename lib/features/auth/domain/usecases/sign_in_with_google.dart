import 'package:dartz/dartz.dart';
import 'package:firebase_test/core/errors/failure.dart';
import 'package:firebase_test/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_test/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  Future<Either<Failure, UserEntity?>> call() async {
    return await repository.signInWithGoogle();
  }
}
