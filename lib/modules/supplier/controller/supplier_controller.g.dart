// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$SupplierControllerRouter(SupplierController service) {
  final router = Router();
  router.add(
    'GET',
    r'/',
    service.find,
  );
  router.add(
    'POST',
    r'/',
    service.registerSupplier,
  );
  router.add(
    'PUT',
    r'/',
    service.updateSupplier,
  );
  router.add(
    'GET',
    r'/user',
    service.userExistesByEmail,
  );
  router.add(
    'GET',
    r'/<id>',
    service.findById,
  );
  router.add(
    'POST',
    r'/service',
    service.registerService,
  );
  router.add(
    'PUT',
    r'/service/<id>',
    service.updateService,
  );
  router.add(
    'DELETE',
    r'/service/<id>',
    service.removeService,
  );
  router.add(
    'GET',
    r'/service/<id>',
    service.listServices,
  );
  return router;
}
