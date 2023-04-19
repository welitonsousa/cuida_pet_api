import 'package:cuida_pet_api/entities/user_entity.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_refresh_token_model.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_save_input_model.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_sign_model.dart';

abstract class IUserService {
  Future<UserEntity> createUser(UserSaveInputModel user);
  Future<UserEntity> signWithEmail(UserSignModel user);
  Future<UserEntity> signSocial(UserSignModel user);
  Future<UserEntity> refreshToken(UserRefreshTokenModel user);
}
