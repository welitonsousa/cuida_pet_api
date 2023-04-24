import 'package:cuida_pet_api/application/routers/i_router.dart';
import 'package:cuida_pet_api/modules/categories/categories_route.dart';
import 'package:cuida_pet_api/modules/user/user_router.dart';
import 'package:shelf_router/shelf_router.dart';

class RouterConfig {
  final List<IRouter> routers = [
    UserRouter(),
    CategoriesRoute(),
  ];

  void loadRouters(Router router) {
    routers.forEach((r) => r.configure(router));
  }
}
