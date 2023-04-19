// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$AuthControllerRouter(AuthController service) {
  final router = Router();
  router.add(
    'POST',
    r'/register',
    service.find,
  );
  router.add(
    'POST',
    r'/protegida',
    service.protegida,
  );
  router.add(
    'PUT',
    r'/refresh',
    service.refresh,
  );
  router.add(
    'POST',
    r'/sign',
    service.sign,
  );
  return router;
}
