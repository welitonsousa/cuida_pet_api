import 'package:cuida_pet_api/application/helpers/request_mapping.dart';

class UserSaveInputModel extends RequestMapping<UserSaveInputModel> {
  String? email;
  String? password;
  int? supplierId;

  UserSaveInputModel(super.data);

  @override
  UserSaveInputModel fromMap() {
    email = data['email'];
    password = data['password'];
    supplierId = data['supplierId'];
    return this;
  }
}
