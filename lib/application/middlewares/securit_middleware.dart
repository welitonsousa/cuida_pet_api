import 'package:cuida_pet_api/application/helpers/jwt.dart';
import 'package:cuida_pet_api/application/helpers/skip_model.dart';
import 'package:shelf/src/request.dart';
import 'package:shelf/src/response.dart';

import 'package:cuida_pet_api/application/middlewares/i_middlewares.dart';

class SecurityMiddleware extends IMiddleware {
  final skipRoutes = <SkipModel>[
    // SkipModel(path: 'hello/', methods: Method.values)
  ];

  @override
  Future<Response> execute(Request request) async {
    final route = SkipModel(
      path: request.url.path,
      methods: [Method.fromMethod(request.method)],
    );
    if (skipRoutes.contains(route)) return await innerHandler(request);

    try {
      final user = JWT.validate(request.headers['Authorization']!);
      final res = await innerHandler(request);
      return res.change(headers: {'user': user});
    } catch (e) {
      return Response(403, body: 'Não autorizado');
    }
  }
}
