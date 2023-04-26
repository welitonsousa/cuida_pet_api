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
import 'package:cuida_pet_api/application/logger/i_logger.dart' as _i12;
import 'package:cuida_pet_api/modules/categories/controller/categories_controller.dart'
    as _i22;
import 'package:cuida_pet_api/modules/categories/data/category_repository.dart'
    as _i19;
import 'package:cuida_pet_api/modules/categories/data/i_category_repository.dart'
    as _i18;
import 'package:cuida_pet_api/modules/categories/service/category_service.dart'
    as _i21;
import 'package:cuida_pet_api/modules/categories/service/i_category_service.dart'
    as _i20;
import 'package:cuida_pet_api/modules/supplier/controller/supplier_controller.dart'
    as _i15;
import 'package:cuida_pet_api/modules/supplier/data/i_supplier_repository.dart'
    as _i6;
import 'package:cuida_pet_api/modules/supplier/data/supplier_repository.dart'
    as _i7;
import 'package:cuida_pet_api/modules/supplier/service/i_supplier_service.dart'
    as _i8;
import 'package:cuida_pet_api/modules/supplier/service/supplier_service.dart'
    as _i9;
import 'package:cuida_pet_api/modules/user/controller/auth_controller.dart'
    as _i17;
import 'package:cuida_pet_api/modules/user/controller/user_controller.dart'
    as _i16;
import 'package:cuida_pet_api/modules/user/data/i_user_repository.dart' as _i10;
import 'package:cuida_pet_api/modules/user/data/user_repository.dart' as _i11;
import 'package:cuida_pet_api/modules/user/service/i_user_service.dart' as _i13;
import 'package:cuida_pet_api/modules/user/service/user_service.dart' as _i14;
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
    gh.lazySingleton<_i6.ISupplierRepository>(
        () => _i7.SupplierRepository(gh<_i3.IDataBaseConfig>()));
    gh.lazySingleton<_i8.ISupplierService>(
        () => _i9.SupplierService(gh<_i6.ISupplierRepository>()));
    gh.lazySingleton<_i10.IUserRepository>(() => _i11.UserRepository(
          database: gh<_i3.IDataBaseConfig>(),
          logger: gh<_i12.ILogger>(),
        ));
    gh.lazySingleton<_i13.IUserService>(
        () => _i14.UserService(repository: gh<_i10.IUserRepository>()));
    gh.factory<_i15.SupplierController>(() => _i15.SupplierController(
          gh<_i8.ISupplierService>(),
          gh<_i12.ILogger>(),
        ));
    gh.factory<_i16.UserController>(() => _i16.UserController(
          gh<_i12.ILogger>(),
          gh<_i13.IUserService>(),
        ));
    gh.factory<_i17.AuthController>(() => _i17.AuthController(
          gh<_i13.IUserService>(),
          gh<_i12.ILogger>(),
        ));
    gh.lazySingleton<_i18.ICategoryRepository>(() => _i19.CategoryRepository(
          gh<_i3.IDataBaseConfig>(),
          gh<_i12.ILogger>(),
        ));
    gh.lazySingleton<_i20.ICategoryService>(
        () => _i21.CategoryService(gh<_i18.ICategoryRepository>()));
    gh.factory<_i22.CategoriesController>(() => _i22.CategoriesController(
          gh<_i12.ILogger>(),
          gh<_i20.ICategoryService>(),
        ));
    return this;
  }
}
