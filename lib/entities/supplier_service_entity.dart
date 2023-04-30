class SupplierServiceEntity {
  final int id;
  final String name;
  final double value;
  final int supplierId;

  SupplierServiceEntity({
    required this.id,
    required this.name,
    required this.value,
    required this.supplierId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'supplier_id': supplierId,
    };
  }

  factory SupplierServiceEntity.fromMap(map) {
    return SupplierServiceEntity(
      id: map['id']?.toInt() ?? 0,
      name: map['nome_servico'] ?? '',
      value: double.tryParse(map['valor_servico']) ?? 0.0,
      supplierId: map['fornecedor_id']?.toInt() ?? 0,
    );
  }
}
