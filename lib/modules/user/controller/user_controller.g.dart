// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$UserControllerRouter(UserController service) {
  final router = Router();
  router.add(
    'GET',
    r'/me',
    service.find,
  );
  router.add(
    'PUT',
    r'/me',
    service.updateUser,
  );
  return router;
}
