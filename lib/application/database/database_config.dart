import 'package:cuida_pet_api/application/config/database_connection.dart';
import 'package:cuida_pet_api/application/database/i_database_config.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql_utils/mysql_utils.dart';

@LazySingleton(as: IDataBaseConfig)
class DataBaseConfig extends IDataBaseConfig {
  final DataBaseConnection _databaseConnection;
  DataBaseConfig(this._databaseConnection);

  @override
  MysqlUtils openConnection() {
    return MysqlUtils(settings: {
      'host': _databaseConnection.host,
      'port': _databaseConnection.port,
      'user': _databaseConnection.user,
      'password': _databaseConnection.password,
      'db': _databaseConnection.name,
      'maxConnections': 10,
      'secure': true,
      'prefix': '',
      'pool': false,
      'collation': 'utf8mb4_general_ci'
    });
  }
}
