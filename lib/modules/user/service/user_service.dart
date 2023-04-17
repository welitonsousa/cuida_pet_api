import 'package:cuida_pet_api/entities/user_entity.dart';
import 'package:cuida_pet_api/modules/user/data/i_user_repository.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_save_input_model.dart';
import 'package:injectable/injectable.dart';
import 'i_user_service.dart';

@LazySingleton(as: IUserService)
class UserService extends IUserService {
  final IUserRepository repository;

  UserService({required this.repository});

  @override
  Future<UserEntity> createUser(UserSaveInputModel user) async {
    final userEntity = UserEntity(
      email: user.email!,
      password: user.password,
      supplierId: user.supplierId,
    );
    return await repository.createUser(userEntity);
  }
}
