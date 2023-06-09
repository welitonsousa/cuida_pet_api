import 'package:cuida_pet_api/application/config/router_config.dart';
import 'package:cuida_pet_api/application/config/service_locator.dart';
import 'package:cuida_pet_api/application/logger/i_logger.dart';
import 'package:cuida_pet_api/application/logger/logger.dart';
import 'package:dartenv/dartenv.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import 'database_connection.dart';
import 'database_migration.dart';

class ApplicationConfig {
  Future<void> loadConfigApplication(Router router) async {
    configureDependencies();
    _loadDataBaseConfig();
    _runMigrations();
    _configLogger();
    _loadRouter(router);
  }

  Future<void> _runMigrations() async {
    final migration = DataBaseMigration(GetIt.I.get());
    await migration.execute();
  }

  void _loadDataBaseConfig() {
    final config = DataBaseConnection(
      host: env('HOST') ?? '',
      user: env('USER') ?? '',
      name: env('DATA_BASE_NAME') ?? '',
      password: env('PASSWORD') ?? '',
      port: int.parse(env('PORT') ?? '0'),
    );
    GetIt.I.registerSingleton(config);
  }

  void _configLogger() {
    GetIt.I.registerLazySingleton<ILogger>(() => Logger());
  }

  void _loadRouter(Router router) {
    RouterConfig().loadRouters(router);
  }
}
