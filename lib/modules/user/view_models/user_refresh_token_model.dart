import 'package:zod_validation/zod_validation.dart';

class UserRefreshTokenModel {
  String refreshToken;
  int userId;
  UserRefreshTokenModel({
    required this.refreshToken,
    required this.userId,
  });

  static Map<String, dynamic> validate(Map<String, dynamic> data) {
    return {
      'refresh_token': Zod().type<String>().min(20),
    };
  }

  factory UserRefreshTokenModel.fromMap(Map<String, dynamic> map) {
    return UserRefreshTokenModel(
      refreshToken: map['refresh_token'] ?? '',
      userId: map['user_id']?.toInt() ?? 0,
    );
  }
}
