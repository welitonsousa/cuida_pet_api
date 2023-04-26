import 'package:cuida_pet_api/dtos/supplier_near_by_my_dto.dart';

abstract class ISupplierService {
  final distance = 5.0;
  Future<List<SupplierNearByMyDto>> findNearByPosition(double lat, double lng);
}
