import 'package:cuida_pet_api/entities/category_entity.dart';

class SupplierEntity {
  final int id;
  final String name;
  final String? logo;
  final String address;
  final String phone;
  final double lat;
  final double lng;
  final CategoryEntity category;

  SupplierEntity({
    required this.id,
    required this.name,
    this.logo,
    required this.address,
    required this.lat,
    required this.phone,
    required this.lng,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'address': address,
      'lat': lat,
      'lng': lng,
      'category': category.toMap(),
    };
  }

  factory SupplierEntity.fromMap(map) {
    return SupplierEntity(
      id: map['id']?.toInt() ?? 0,
      name: map['nome'] ?? '',
      logo: map['logo'],
      phone: map['telefone'] ?? '',
      address: map['endereco'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      category: CategoryEntity(
        id: map['categoria_fornecedor_id'] ?? 0,
        name: map['nome_categoria'] ?? '',
        type: map['tipo_categoria'] ?? '',
      ),
    );
  }
}
