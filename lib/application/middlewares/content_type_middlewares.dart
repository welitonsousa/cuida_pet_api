import 'package:cuida_pet_api/application/middlewares/i_middlewares.dart';
import 'package:shelf/src/response.dart';
import 'package:shelf/src/request.dart';

class ContentTypeMiddleware extends IMiddleware {
  final String contentType = 'application/json;charset=utf-8';

  @override
  Future<Response> execute(Request request) async {
    final response = await innerHandler(request);
    return response.change(
      headers: {'content-type': contentType},
    );
  }
}
