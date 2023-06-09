import 'package:cuida_pet_api/dtos/supplier_near_by_my_dto.dart';
import 'package:cuida_pet_api/entities/supplier_entity.dart';
import 'package:cuida_pet_api/entities/supplier_service_entity.dart';

abstract class ISupplierRepository {
  Future<List<SupplierNearByMyDto>> findNearByPosition(
      double lat, double lng, double distance);

  Future<SupplierEntity> findById(int id);
  Future<bool> userExistes(String email);

  Future<int> registerSupplier({
    required String name,
    required String phone,
    required int categoryId,
  });
  Future<SupplierEntity> updateSupplier(SupplierEntity entity);

  Future<SupplierServiceEntity> createService({
    required String name,
    required double value,
    required int supplierId,
  });

  Future<SupplierServiceEntity> updateService(SupplierServiceEntity entity);
  Future<void> deleteService(int supplierId, int serviceId);
  Future<List<SupplierServiceEntity>> getService(int supplierId);
}
