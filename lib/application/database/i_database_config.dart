import 'package:mysql_utils/mysql_utils.dart';

abstract class IDataBaseConfig {
  IDataBaseConfig();
  MysqlUtils openConnection();
}
