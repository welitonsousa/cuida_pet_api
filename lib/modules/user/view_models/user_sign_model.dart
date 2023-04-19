import 'package:cuida_pet_api/application/helpers/request_mapping.dart';

class UserSignModel extends RequestMapping {
  String? email;
  String? password;

  String? avatar;
  String? socialKey;
  String? socialType;
  bool supplier = false;

  UserSignModel(super.data);

  @override
  void fromMap() {
    email = data['email'];
    avatar = data['avatar'];
    password = data['password'];
    socialKey = data['social_key'];
    socialType = data['social_type'];
    supplier = data['supplier'] ?? false;
  }

  static ValidMap validation(ValidData data) {
    return {
      'email': ValidaFields.v.email().required(),
      if (data['social_type'] != null) 'social_key': ValidaFields.v.required(),
      if (data['social_key'] != null) 'social_type': ValidaFields.v,
      if (data['social_type'] == null && data['social_key'] == null)
        'password': ValidaFields.v.minLength(6).required(),
    };
  }
}
