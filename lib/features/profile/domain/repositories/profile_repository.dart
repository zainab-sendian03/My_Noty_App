import 'package:firebase_test/features/auth/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<UserEntity?> getCurrentUser();
  Future<void> updateProfile(String name, String photoUrl);
}
