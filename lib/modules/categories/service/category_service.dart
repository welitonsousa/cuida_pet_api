import 'package:cuida_pet_api/entities/category_entity.dart';
import 'package:cuida_pet_api/modules/categories/data/i_category_repository.dart';
import 'package:cuida_pet_api/modules/categories/service/i_category_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICategoryService)
class CategoryService extends ICategoryService {
  final ICategoryRepository _repository;

  CategoryService(this._repository);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    return await _repository.getCategories();
  }
}
