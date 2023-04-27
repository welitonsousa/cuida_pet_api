import 'dart:convert';

import 'package:cuida_pet_api/application/helpers/jwt.dart';
import 'package:cuida_pet_api/application/helpers/skip_model.dart';
import 'package:shelf/src/request.dart';
import 'package:shelf/src/response.dart';

import 'package:cuida_pet_api/application/middlewares/i_middlewares.dart';

class SecurityMiddleware extends IMiddleware {
  final skipRoutes = <SkipModel>[
    SkipModel(path: 'auth/register', methods: [Method.POST]),
    SkipModel(path: 'auth/sign', methods: [Method.POST]),
    SkipModel(path: 'supplier/user', methods: [Method.GET]),
  ];

  @override
  Future<Response> execute(Request request) async {
    final route = SkipModel(
      path: request.url.path,
      methods: [Method.fromMethod(request.method)],
    );
    if (skipRoutes.contains(route)) return await innerHandler(request);

    try {
      final refresh = request.headers['refresh_token'] ?? '';
      final token = request.headers['Authorization'] ?? '';

      if (request.url.path == 'auth/refresh') {
        JWT.validate(token: refresh, issuer: token);
      }

      final user = JWT.validate(
        token: token,
        validate: request.url.path != 'auth/refresh',
      );

      return await innerHandler(request.change(headers: {
        'user': user['sub'],
        'supplier': user['supplierId'],
      }));
    } catch (e) {
      return Response(403, body: jsonEncode({'message': 'Acesso negado'}));
    }
  }
}
