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
      'supplierId': supplierId,
    };
  }

  factory SupplierServiceEntity.fromMap(Map<String, dynamic> map) {
    return SupplierServiceEntity(
      id: map['id']?.toInt() ?? 0,
      name: map['nome_servico'] ?? '',
      value: map['valor_servico']?.toDouble() ?? 0.0,
      supplierId: map['fornecedor_id']?.toInt() ?? 0,
    );
  }
}
