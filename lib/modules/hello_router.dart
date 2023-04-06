import 'package:cuida_pet_api/application/routers/i_router.dart';
import 'package:shelf_router/src/router.dart';

import 'hello.dart';

class HelloRouter extends IRouter {
  @override
  void configure(Router router) {
    router.mount('/hello/', Hello().router);
  }
}
