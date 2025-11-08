import 'package:dartz/dartz.dart';
import 'package:firebase_test/core/errors/failure.dart';
import 'package:firebase_test/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity?>> signInWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, UserEntity?>> signInWithGoogle();
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserEntity?>> getCurrentUser();
  Future<Either<Failure, UserEntity?>> signUpWithEmailAndPassword(
      String email, String password,
      {String? displayName});
}
