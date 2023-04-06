import 'package:mysql_client/mysql_client.dart';

abstract class IDataBaseConfig {
  IDataBaseConfig();
  Future<MySQLConnection> openConnection();
}
