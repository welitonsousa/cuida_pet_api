import 'package:zod_validation/zod_validation.dart';

class UserSaveInputModel {
  String email;
  String password;
  int? supplierId;
  UserSaveInputModel({
    required this.email,
    required this.password,
    this.supplierId,
  });

  static Map<String, dynamic> validation(Map<String, dynamic> data) {
    return {
      'email': Zod().email(),
      'password': Zod().password(
        lower: false,
        special: false,
        number: false,
        upper: false,
      ),
    };
  }

  factory UserSaveInputModel.fromMap(Map<String, dynamic> map) {
    return UserSaveInputModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      supplierId: map['supplier_id']?.toInt(),
    );
  }
}
