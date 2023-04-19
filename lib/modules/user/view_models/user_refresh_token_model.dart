import 'package:cuida_pet_api/application/helpers/request_mapping.dart';

class UserRefreshTokenModel extends RequestMapping {
  String? refreshToken;
  int? userId;
  UserRefreshTokenModel(
    super.data, {
    required this.userId,
    required this.refreshToken,
  });

  @override
  void fromMap() {}

  static ValidMap validate(ValidData data) {
    return {
      'refresh_token': ValidaFields.v,
    };
  }
}
