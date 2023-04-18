import 'package:cuida_pet_api/application/routers/i_router.dart';
import 'package:cuida_pet_api/modules/user/controller/auth_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/src/router.dart';

class UserRouter extends IRouter {
  @override
  void configure(Router router) {
    router.mount('/auth/', AuthController(GetIt.I.get(), GetIt.I.get()).router);
  }
}
