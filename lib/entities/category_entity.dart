class CategoryEntity {
  final int id;
  final String name;
  final String type;

  CategoryEntity({required this.id, required this.name, required this.type});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'type': type};
  }

  factory CategoryEntity.fromMap(map) {
    return CategoryEntity(
      id: map['id']?.toInt() ?? 0,
      name: map['nome_categoria'] ?? '',
      type: map['tipo_categoria'] ?? '',
    );
  }
}
