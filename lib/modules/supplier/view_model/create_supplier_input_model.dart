class CreateSupplierInputModel {
  final String name;
  final String phone;
  final String email;
  final String? password;
  final int categoryId;

  CreateSupplierInputModel({
    required this.name,
    required this.phone,
    required this.email,
    this.password,
    required this.categoryId,
  });

  factory CreateSupplierInputModel.fromMap(map) {
    return CreateSupplierInputModel(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      password: map['password'],
      categoryId: map['category_id']?.toInt() ?? 0,
    );
  }
}
