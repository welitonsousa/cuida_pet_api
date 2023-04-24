import 'package:cuida_pet_api/application/helpers/request_mapping.dart';
import 'package:zod_validation/zod_validation.dart';

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
      'email': Zod().email(),
      'password': Zod().password(
        lower: false,
        special: false,
        number: false,
        upper: false,
      ),
    };
  }
}
