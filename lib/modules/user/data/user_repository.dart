import 'package:cuida_pet_api/application/database/i_database_config.dart';
import 'package:cuida_pet_api/application/excptions/user_exception.dart';
import 'package:cuida_pet_api/application/helpers/cripto.dart';
import 'package:cuida_pet_api/application/logger/i_logger.dart';
import 'package:cuida_pet_api/entities/user_entity.dart';
import 'package:injectable/injectable.dart';
import 'i_user_repository.dart';

@LazySingleton(as: IUserRepository)
class UserRepository extends IUserRepository {
  final IDataBaseConfig database;
  final ILogger logger;

  UserRepository({required this.database, required this.logger});

  @override
  Future<UserEntity> createUser(UserEntity user) async {
    try {
      final conn = database.openConnection();
      final res = await conn.insert(table: 'usuario', insertData: {
        'email': user.email,
        'tipo_cadastro': user.registerType,
        'img_avatar': user.photo,
        'senha': Cripto.encrypt(user.password ?? ''),
        'fornecedor_id': user.supplierId,
        'social_id': user.socialKey,
      });
      await conn.close();
      return user.copyWith(id: res, password: '');
    } catch (e, s) {
      logger.error('', e, s);
      throw UserGenericException();
    }
  }
}
