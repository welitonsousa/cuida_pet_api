import 'package:cuida_pet_api/application/config/database_connection.dart';
import 'package:cuida_pet_api/application/config/router_config.dart';
import 'package:cuida_pet_api/application/config/service_locator.dart';
import 'package:cuida_pet_api/application/logger/i_logger.dart';
import 'package:cuida_pet_api/application/logger/logger.dart';
import 'package:dotenv/dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

class ApplicationConfig {
  Future<void> loadConfigApplication(Router router) async {
    configureDependencies();
    _loadDataBaseConfig();
    _configLogger();
    _loadRouter(router);
  }

  void _loadDataBaseConfig() {
    final env = DotEnv()..load();
    final config = DataBaseConnection(
      host: env['HOST'] ?? '',
      name: env['DATA_BASE_NAME'] ?? '',
      password: env['PASSWORD'] ?? '',
      port: int.parse(env['PORT'] ?? '0'),
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
