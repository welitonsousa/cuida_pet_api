import 'package:cuida_pet_api/entities/user_entity.dart';
import 'package:cuida_pet_api/modules/user/data/i_user_repository.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_find_model.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_refresh_token_model.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_save_input_model.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_sign_model.dart';
import 'package:injectable/injectable.dart';
import 'i_user_service.dart';

@LazySingleton(as: IUserService)
class UserService extends IUserService {
  final IUserRepository repository;

  UserService({required this.repository});

  @override
  Future<UserEntity> createUser(UserSaveInputModel user) async {
    final userEntity = UserEntity(
      email: user.email,
      password: user.password,
      supplierId: user.supplierId,
    );
    return await repository.createUser(userEntity);
  }

  @override
  Future<UserEntity> signWithEmail(UserSignModel user) async {
    final userEntity = UserEntity(
      email: user.email!,
      password: user.password,
      supplierId: user.supplier ? 1 : null,
    );
    return await repository.signWithEmail(userEntity);
  }

  @override
  Future<UserEntity> signSocial(UserSignModel user) async {
    final userEntity = UserEntity(
      email: user.email!,
      password: user.password,
      supplierId: user.supplier ? 1 : null,
    );
    return await repository.signSocial(userEntity);
  }

  @override
  Future<UserEntity> refreshToken(UserRefreshTokenModel user) async {
    final userEntity = UserEntity(
      id: user.userId,
      email: '',
      refreshToken: user.refreshToken,
    );
    return await repository.refreshToken(userEntity);
  }

  @override
  Future<UserEntity> findUser(UserFindModel user) async {
    return await repository.findUser(user);
  }

  @override
  Future<UserEntity> updateUser(UserEntity user) {
    return repository.updateUser(user);
  }
}
