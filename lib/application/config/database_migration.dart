import 'dart:io';
import 'package:cuida_pet_api/application/database/i_database_config.dart';

class DataBaseMigration {
  final IDataBaseConfig _database;

  DataBaseMigration(this._database);

  Future<void> execute() async {
    final dir = Directory('./migrations');
    final files = <File>[];
    dir.listSync().forEach((e) {
      files.add(File(e.path));
    });

    final conn = _database.openConnection();

    for (var file in files) {
      final fileName = file.path.split('/').last;
      print('start migration $fileName -- ${DateTime.now()}');
      await conn.query(file.readAsStringSync());
      print('finished migration $fileName -- ${DateTime.now()}');
      if (file.path != files.last.path) print('---------------------');
    }

    await conn.close();
  }
}
