import 'package:cuida_pet_api/application/database/i_database_config.dart';
import 'package:cuida_pet_api/application/excptions/category_exception.dart';
import 'package:cuida_pet_api/application/logger/i_logger.dart';
import 'package:cuida_pet_api/entities/category_entity.dart';
import 'package:cuida_pet_api/modules/categories/data/i_category_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICategoryRepository)
class CategoryRepository extends ICategoryRepository {
  final IDataBaseConfig dataBase;
  final ILogger log;

  CategoryRepository(this.dataBase, this.log);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final conn = dataBase.openConnection();
    try {
      final res = await conn.getAll(table: 'categorias_fornecedor');
      return res.map(CategoryEntity.fromMap).toList();
    } catch (e) {
      log.error(e);
      throw CategoryGenericException();
    } finally {
      await conn.close();
    }
  }
}
