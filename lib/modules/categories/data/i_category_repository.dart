import 'package:cuida_pet_api/entities/category_entity.dart';

abstract class ICategoryRepository {
  Future<List<CategoryEntity>> getCategories();
}
