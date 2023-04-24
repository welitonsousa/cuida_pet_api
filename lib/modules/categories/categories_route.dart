import 'package:cuida_pet_api/application/routers/i_router.dart';
import 'package:cuida_pet_api/modules/categories/controller/categories_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/src/router.dart';

class CategoriesRoute extends IRouter {
  @override
  void configure(Router router) {
    final controller = GetIt.I.get<CategoriesController>();
    router.mount('/categories', controller.router);
  }
}
