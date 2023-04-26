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
    'GET',
    r'/<id>',
    service.findById,
  );
  return router;
}
