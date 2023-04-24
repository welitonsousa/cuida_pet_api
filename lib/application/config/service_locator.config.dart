// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cuida_pet_api/application/config/database_connection.dart'
    as _i5;
import 'package:cuida_pet_api/application/database/database_config.dart' as _i4;
import 'package:cuida_pet_api/application/database/i_database_config.dart'
    as _i3;
import 'package:cuida_pet_api/application/logger/i_logger.dart' as _i8;
import 'package:cuida_pet_api/modules/user/controller/auth_controller.dart'
    as _i12;
import 'package:cuida_pet_api/modules/user/controller/user_controller.dart'
    as _i11;
import 'package:cuida_pet_api/modules/user/data/i_user_repository.dart' as _i6;
import 'package:cuida_pet_api/modules/user/data/user_repository.dart' as _i7;
import 'package:cuida_pet_api/modules/user/service/i_user_service.dart' as _i9;
import 'package:cuida_pet_api/modules/user/service/user_service.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.IDataBaseConfig>(
        () => _i4.DataBaseConfig(gh<_i5.DataBaseConnection>()));
    gh.lazySingleton<_i6.IUserRepository>(() => _i7.UserRepository(
          database: gh<_i3.IDataBaseConfig>(),
          logger: gh<_i8.ILogger>(),
        ));
    gh.lazySingleton<_i9.IUserService>(
        () => _i10.UserService(repository: gh<_i6.IUserRepository>()));
    gh.factory<_i11.UserController>(() => _i11.UserController(
          gh<_i8.ILogger>(),
          gh<_i9.IUserService>(),
        ));
    gh.factory<_i12.AuthController>(() => _i12.AuthController(
          gh<_i9.IUserService>(),
          gh<_i8.ILogger>(),
        ));
    return this;
  }
}
