import 'package:cuida_pet_api/entities/user_entity.dart';

abstract class IUserRepository {
  Future<UserEntity> createUser(UserEntity user);
  Future<UserEntity> signWithEmail(UserEntity user);
  Future<UserEntity> signSocial(UserEntity user);
  Future<UserEntity> refreshToken(UserEntity user);
}
