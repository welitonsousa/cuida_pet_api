import 'package:cuida_pet_api/application/helpers/request_mapping.dart';

class UserSaveInputModel extends RequestMapping {
  String? email;
  String? password;
  int? supplierId;

  UserSaveInputModel(super.data);

  @override
  void fromMap() {
    email = data['email'];
    password = data['password'];
    supplierId = data['supplierId'];
  }

  static ValidMap validation(Map<String, dynamic> data) {
    return {
      'password': ValidaFields.v.minLength(8),
      'email': ValidaFields.v.type<bool>(),
    };
  }
}
