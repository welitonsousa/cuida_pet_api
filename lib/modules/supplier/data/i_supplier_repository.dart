import 'package:cuida_pet_api/dtos/supplier_near_by_my_dto.dart';
import 'package:cuida_pet_api/entities/supplier_entity.dart';

abstract class ISupplierRepository {
  Future<List<SupplierNearByMyDto>> findNearByPosition(
      double lat, double lng, double distance);

  Future<SupplierEntity> findById(int id);
  Future<bool> userExistes(String email);
}
