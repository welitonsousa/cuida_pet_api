import 'package:cuida_pet_api/entities/category_entity.dart';

abstract class ICategoryService {
  Future<List<CategoryEntity>> getCategories();
}
