import 'package:cuida_pet_api/application/helpers/request_mapping.dart';
import 'package:zod_validation/zod_validation.dart';

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
}
