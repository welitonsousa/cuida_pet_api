import 'package:cuida_pet_api/application/excptions/supplier_exception.dart';
import 'package:cuida_pet_api/application/excptions/user_exception.dart';
import 'package:cuida_pet_api/dtos/supplier_near_by_my_dto.dart';
import 'package:cuida_pet_api/entities/supplier_entity.dart';
import 'package:cuida_pet_api/entities/supplier_service_entity.dart';
import 'package:cuida_pet_api/entities/user_entity.dart';
import 'package:cuida_pet_api/modules/supplier/data/i_supplier_repository.dart';
import 'package:cuida_pet_api/modules/supplier/view_model/create_supplier_input_model.dart';
import 'package:cuida_pet_api/modules/supplier/view_model/update_supplier_input_model.dart';
import 'package:cuida_pet_api/modules/user/data/i_user_repository.dart';
import 'package:injectable/injectable.dart';
import 'i_supplier_service.dart';

@LazySingleton(as: ISupplierService)
class SupplierService extends ISupplierService {
  final ISupplierRepository _repository;
  final IUserRepository _userRepository;
  SupplierService(this._repository, this._userRepository);

  @override
  Future<List<SupplierNearByMyDto>> findNearByPosition(double lat, double lng) {
    return _repository.findNearByPosition(lat, lng, distance);
  }

  @override
  Future<SupplierEntity> findById(int id) => _repository.findById(id);

  @override
  Future<bool> userExistes(String email) => _repository.userExistes(email);

  @override
  Future<void> registerSupplier(CreateSupplierInputModel model) async {
    final user = await _userRepository.findUserByEmail(model.email);

    if (user?.supplierId != null) throw SupplierExistesException();
    if (user == null && (model.password?.trim().length ?? 0) < 8) {
      throw UserNotExistException();
    }

    final id = await _repository.registerSupplier(
        name: model.name, phone: model.phone, categoryId: model.categoryId);

    final userEntity = UserEntity(
        id: user?.id,
        supplierId: id,
        email: model.email,
        password: model.password);

    if (user != null) await _userRepository.updateUser(userEntity);
    if (user == null) await _userRepository.createUser(userEntity);
  }

  @override
  Future<SupplierServiceEntity> createService(
      {required String name, required double value, required int supplierId}) {
    return _repository.createService(
        name: name, value: value, supplierId: supplierId);
  }

  @override
  Future<void> deleteService(int supplierId, int serviceId) {
    return _repository.deleteService(supplierId, serviceId);
  }

  @override
  Future<List<SupplierServiceEntity>> getService(int supplierId) {
    return _repository.getService(supplierId);
  }

  @override
  Future<SupplierServiceEntity> updateService(SupplierServiceEntity entity) {
    return _repository.updateService(entity);
  }

  @override
  Future<SupplierEntity> updateSupplier(UpdateSupplierInputModel entity) {
    return _repository.updateSupplier(entity.toEntity());
  }
}
