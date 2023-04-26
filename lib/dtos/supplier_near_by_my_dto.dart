class SupplierNearByMyDto {
  final int id;
  final String name;
  final String? logo;
  final double distance;
  final int categoryId;

  SupplierNearByMyDto({
    required this.id,
    required this.name,
    required this.distance,
    required this.categoryId,
    this.logo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'logo': logo,
      'distance': distance,
      'name': name,
      'categoryId': categoryId
    };
  }

  factory SupplierNearByMyDto.fromMap(map) {
    return SupplierNearByMyDto(
      id: map['id']?.toInt() ?? 0,
      name: map['nome'] ?? '',
      logo: map['logo'],
      distance: map['distance']?.toDouble() ?? 0.0,
      categoryId: map['categorias_fornecedor_id']?.toInt() ?? 0,
    );
  }
}
