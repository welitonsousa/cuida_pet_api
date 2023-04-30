import 'package:cuida_pet_api/entities/category_entity.dart';

class SupplierEntity {
  final int id;
  final String name;
  final String? logo;
  final String? address;
  final String? phone;
  final double? lat;
  final double? lng;
  final CategoryEntity category;

  SupplierEntity({
    required this.id,
    required this.name,
    required this.category,
    this.logo,
    this.address,
    this.lat,
    this.phone,
    this.lng,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'address': address,
      'lat': lat,
      'lng': lng,
      'phone': phone,
      'category': category.toMap(),
    };
  }

  factory SupplierEntity.fromMap(map) {
    return SupplierEntity(
      id: map['id']?.toInt() ?? 0,
      name: map['nome'] ?? '',
      logo: map['logo'],
      phone: map['telefone'],
      address: map['endereco'],
      lat: map['lat']?.toDouble(),
      lng: map['lng']?.toDouble(),
      category: CategoryEntity(
        id: map['categorias_fornecedor_id'] ?? 0,
        name: map['nome_categoria'] ?? '',
        type: map['tipo_categoria'] ?? '',
      ),
    );
  }

  SupplierEntity copyWith({
    int? id,
    String? name,
    String? logo,
    String? address,
    String? phone,
    double? lat,
    double? lng,
    CategoryEntity? category,
  }) {
    return SupplierEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      category: category ?? this.category,
    );
  }
}
