import 'package:zod_validation/zod_validation.dart';

class UserSignModel {
  String? email;
  String? password;

  String? avatar;
  String? socialKey;
  String? socialType;
  bool supplier = false;

  UserSignModel({
    this.email,
    this.password,
    this.avatar,
    this.socialKey,
    this.socialType,
    this.supplier = false,
  });

  static Map<String, dynamic> validation(Map<String, dynamic> data) {
    return {
      'email': Zod().email(),
      if (data['social_type'] != null) 'social_key': Zod().type<String>(),
      if (data['social_key'] != null) 'social_type': Zod().type<String>(),
      if (data['social_type'] == null && data['social_key'] == null)
        'password': Zod().password(
          lower: false,
          special: false,
          number: false,
          upper: false,
        ),
    };
  }

  factory UserSignModel.fromMap(Map<String, dynamic> map) {
    return UserSignModel(
      email: map['email'],
      password: map['password'],
      avatar: map['avatar'],
      socialKey: map['social_key'],
      socialType: map['social_type'],
      supplier: map['supplier'] ?? false,
    );
  }
}
