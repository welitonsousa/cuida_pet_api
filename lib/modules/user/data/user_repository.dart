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

  @override
  Future<UserEntity> signWithEmail(UserEntity user) async {
    final conn = database.openConnection();
    try {
      final res = await conn.getOne(
        table: 'usuario',
        where: {
          'email': user.email,
          'senha': Cripto.encrypt(user.password!),
          if (user.supplierId != null) 'fornecedor_id': ['is', 'not null'],
        },
      );
      if (res.isEmpty) throw UserNotExistException();
      return UserEntity.fromMap(res);
    } catch (e, s) {
      logger.error('sign with email', e, s);
      throw UserGenericException();
    } finally {
      await conn.close();
    }
  }

  @override
  Future<UserEntity> signSocial(UserEntity user) async {
    final conn = database.openConnection();
    try {
      final userExist = await conn.getOne(
        table: 'usuario',
        where: {
          'email': user.email,
          if (user.supplierId != null) 'fornecedor_id': ['is', 'not null'],
        },
      );
      if (userExist.isEmpty) {
        final id = await conn.insert(table: 'usuario', insertData: {
          'email': user.email,
          'tipo_cadastro': user.registerType,
          'img_avatar': user.photo,
          'senha': Cripto.encrypt(user.password ?? ''),
          'fornecedor_id': user.supplierId,
          'social_id': user.socialKey,
        });
        return user.copyWith(id: id, password: '');
      } else {
        final id = await conn.update(
          table: 'usuario',
          where: {'id': userExist['id']},
          updateData: {
            'tipo_cadastro': user.registerType,
            'social_id': user.socialKey,
          },
        );
        return user.copyWith(
          id: id,
          registerType: user.registerType,
          socialKey: user.socialKey,
          password: '',
        );
      }
    } catch (e, s) {
      logger.error('sign with social', e, s);
      throw UserGenericException();
    } finally {
      await conn.close();
    }
  }

  @override
  Future<UserEntity> refreshToken(UserEntity user) async {
    final conn = database.openConnection();
    try {
      await conn.update(
        table: 'usuario',
        updateData: {'refresh_token': user.refreshToken},
        where: {'id': user.id},
      );
      final res = await conn.getOne(table: 'usuario', where: {'id': user.id});
      return UserEntity.fromMap(res);
    } finally {
      await conn.close();
    }
  }
}
