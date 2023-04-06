import 'package:cuida_pet_api/modules/hello_router.dart';
import 'package:cuida_pet_api/application/routers/i_router.dart';
import 'package:shelf_router/shelf_router.dart';

class RouterConfig {
  final List<IRouter> routers = [
    HelloRouter(),
  ];

  void loadRouters(Router router) {
    routers.forEach((r) => r.configure(router));
  }
}
