import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
part 'hello.g.dart';

class Hello {
  @Route.get('/')
  Future<Response> asd(Request req) async {
    return Response.ok('asd');
  }

  Router get router => _$HelloRouter(this);
}
