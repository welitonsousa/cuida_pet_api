import 'package:cuida_pet_api/entities/user_entity.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_find_model.dart';

abstract class IUserRepository {
  Future<UserEntity> createUser(UserEntity user);
  Future<UserEntity> signWithEmail(UserEntity user);
  Future<UserEntity> signSocial(UserEntity user);
  Future<UserEntity> refreshToken(UserEntity user);
  Future<UserEntity> findUser(UserFindModel user);
  Future<UserEntity> updateUser(UserEntity user);
}
