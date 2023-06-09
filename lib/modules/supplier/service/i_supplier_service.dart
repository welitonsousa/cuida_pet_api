import 'package:cuida_pet_api/dtos/supplier_near_by_my_dto.dart';
import 'package:cuida_pet_api/entities/supplier_entity.dart';
import 'package:cuida_pet_api/entities/supplier_service_entity.dart';
import 'package:cuida_pet_api/modules/supplier/view_model/create_supplier_input_model.dart';
import 'package:cuida_pet_api/modules/supplier/view_model/update_supplier_input_model.dart';

abstract class ISupplierService {
  final distance = 5.0;
  Future<List<SupplierNearByMyDto>> findNearByPosition(double lat, double lng);
  Future<SupplierEntity> findById(int id);
  Future<bool> userExistes(String email);
  Future<void> registerSupplier(CreateSupplierInputModel model);
  Future<SupplierEntity> updateSupplier(UpdateSupplierInputModel entity);

  Future<SupplierServiceEntity> createService({
    required String name,
    required double value,
    required int supplierId,
  });

  Future<SupplierServiceEntity> updateService(SupplierServiceEntity entity);
  Future<void> deleteService(int supplierId, int serviceId);
  Future<List<SupplierServiceEntity>> getService(int supplierId);
}
