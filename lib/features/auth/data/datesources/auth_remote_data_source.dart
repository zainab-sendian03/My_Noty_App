import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/core/errors/failure.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_test/features/auth/domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, UserEntity?>> signInWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, UserEntity?>> signInWithGoogle();
  Future<Either<Failure, UserEntity?>> signUpWithEmailAndPassword(
      String email, String password,
      {String? displayName});
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserEntity?>> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl({
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _googleSignIn = googleSignIn;

  @override
  Future<Either<Failure, UserEntity?>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(_mapFirebaseUserToEntity(userCredential.user));
    } on FirebaseAuthException catch (e) {
      // Map Firebase Auth error codes to HTTP status codes
      final statusCode = _mapFirebaseErrorToStatusCode(e.code);
      print('🔍 Firebase Auth Error Code: ${e.code}');
      print('🔍 Mapped Status Code: $statusCode');
      return Left(Failure(
        errMessage: e.message ?? e.code,
        statusCode: statusCode,
      ));
    } catch (e) {
      return Left(Failure(
        errMessage: e.toString(),
        statusCode: 500,
      ));
    }
  }

  /// Maps Firebase Auth error codes to HTTP status codes
  int _mapFirebaseErrorToStatusCode(String firebaseErrorCode) {
    switch (firebaseErrorCode) {
      // Authentication errors (401 Unauthorized)
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-email':
      case 'invalid-credential':
        return 401;

      // Bad request errors (400)
      case 'email-already-in-use':
      case 'weak-password':
      case 'operation-not-allowed':
        return 400;

      // Too many requests (429)
      case 'too-many-requests':
        return 429;

      // Server errors (500)
      case 'network-request-failed':
      case 'internal-error':
      default:
        return 500;
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return Left(Failure(
          errMessage: 'Google sign in failed',
          statusCode: 500,
        ));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return Right(_mapFirebaseUserToEntity(userCredential.user));
    } on FirebaseAuthException catch (e) {
      final statusCode = _mapFirebaseErrorToStatusCode(e.code);
      print('🔍 Firebase Auth Error Code: ${e.code}');
      print('🔍 Mapped Status Code: $statusCode');
      return Left(Failure(
        errMessage: e.message ?? e.code,
        statusCode: statusCode,
      ));
    } catch (e) {
      return Left(Failure(
        errMessage: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> signUpWithEmailAndPassword(
      String email, String password,
      {String? displayName}) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user profile with display name if provided
      // Using updateProfile with UserProfileChangeRequest to avoid type casting issues
      if (displayName != null &&
          displayName.isNotEmpty &&
          userCredential.user != null) {
        try {
          // Add a small delay to ensure Firebase Auth is fully initialized
          await Future.delayed(const Duration(milliseconds: 100));

          // Use updateProfile method which is more reliable
          await userCredential.user!.updateProfile(
            displayName: displayName,
          );

          // Reload to get updated user data
          await userCredential.user!.reload();

          // Get the refreshed user
          final refreshedUser = _auth.currentUser;
          return Right(_mapFirebaseUserToEntity(refreshedUser));
        } catch (updateError) {
          // If profile update fails, still return success with the created user
          // The signup was successful even if display name update failed
          print('Warning: Failed to update display name: $updateError');
          // Continue with the created user - signup was successful
        }
      }

      return Right(_mapFirebaseUserToEntity(userCredential.user));
    } on FirebaseAuthException catch (e) {
      final statusCode = _mapFirebaseErrorToStatusCode(e.code);
      print('🔍 Firebase Auth Error Code: ${e.code}');
      print('🔍 Mapped Status Code: $statusCode');
      return Left(Failure(
        errMessage: e.message ?? e.code,
        statusCode: statusCode,
      ));
    } catch (e) {
      return Left(Failure(
        errMessage: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
      return Right(null);
    } catch (e) {
      return Left(Failure(
        errMessage: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      return user != null
          ? Right(_mapFirebaseUserToEntity(user))
          : Left(Failure(
              errMessage: 'Failed to get current user',
              statusCode: 500,
            ));
    } catch (e) {
      return Left(Failure(
        errMessage: e.toString(),
        statusCode: 500,
      ));
    }
  }

  UserEntity _mapFirebaseUserToEntity(User? user) {
    if (user == null) return UserEntity();

    return UserEntity(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
    );
  }
}
