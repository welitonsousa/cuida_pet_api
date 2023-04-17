import 'package:cuida_pet_api/entities/user_entity.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_save_input_model.dart';

abstract class IUserService {
  Future<UserEntity> createUser(UserSaveInputModel user);
}
