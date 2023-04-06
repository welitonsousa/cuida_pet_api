import 'package:cuida_pet_api/application/config/database_connection.dart';
import 'package:cuida_pet_api/application/database/i_database_config.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql_client/mysql_client.dart';

@LazySingleton(as: IDataBaseConfig)
class DataBaseConfig extends IDataBaseConfig {
  final DataBaseConnection _databaseConnection;
  DataBaseConfig(this._databaseConnection);

  @override
  Future<MySQLConnection> openConnection() async {
    return await MySQLConnection.createConnection(
      host: _databaseConnection.host,
      port: _databaseConnection.port,
      userName: _databaseConnection.name,
      password: _databaseConnection.password,
    );
  }
}
