import 'package:cuida_pet_api/entities/category_entity.dart';
import 'package:cuida_pet_api/entities/supplier_entity.dart';

class UpdateSupplierInputModel {
  final int id;
  final String? name;
  final String? phone;
  final String? address;
  final String? logo;
  final int? categoryId;
  final double? lat;
  final double? lng;

  UpdateSupplierInputModel({
    required this.id,
    this.name,
    this.phone,
    this.address,
    this.logo,
    this.categoryId,
    this.lat,
    this.lng,
  });

  factory UpdateSupplierInputModel.fromMap(map) {
    return UpdateSupplierInputModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'],
      phone: map['phone'],
      categoryId: map['category_id']?.toInt(),
      address: map['address'],
      lat: map['lat'],
      lng: map['lng'],
      logo: map['logo'],
    );
  }

  SupplierEntity toEntity() {
    return SupplierEntity(
      id: id,
      name: name ?? '',
      phone: phone,
      address: address,
      logo: logo,
      lat: lat,
      lng: lng,
      category: CategoryEntity(id: categoryId ?? 0, name: '', type: ''),
    );
  }
}
