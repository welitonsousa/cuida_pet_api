import 'package:cuida_pet_api/dtos/supplier_near_by_my_dto.dart';
import 'package:cuida_pet_api/entities/supplier_entity.dart';
import 'package:cuida_pet_api/modules/supplier/data/i_supplier_repository.dart';
import 'package:injectable/injectable.dart';
import 'i_supplier_service.dart';

@LazySingleton(as: ISupplierService)
class SupplierService extends ISupplierService {
  final ISupplierRepository _repository;

  SupplierService(this._repository);

  @override
  Future<List<SupplierNearByMyDto>> findNearByPosition(double lat, double lng) {
    return _repository.findNearByPosition(lat, lng, distance);
  }

  @override
  Future<SupplierEntity> findById(int id) => _repository.findById(id);

  @override
  Future<bool> userExistes(String email) => _repository.userExistes(email);
}
