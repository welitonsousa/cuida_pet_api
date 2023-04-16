import 'dart:io';
import 'package:cuida_pet_api/application/config/application_config.dart';
import 'package:cuida_pet_api/application/middlewares/content_type_middlewares.dart';
import 'package:cuida_pet_api/application/middlewares/cors_middlewares.dart';
import 'package:cuida_pet_api/application/middlewares/securit_middleware.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

void main(List<String> args) async {
  final router = Router();

  final app = ApplicationConfig();
  app.loadConfigApplication(router);

  final ip = InternetAddress.anyIPv4;
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(ContentTypeMiddleware().handle)
      .addMiddleware(CorsMiddleware().handle)
      .addMiddleware(SecurityMiddleware().handle)
      .addHandler(router);
  final port = int.parse(Platform.environment['PORT'] ?? '3000');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
