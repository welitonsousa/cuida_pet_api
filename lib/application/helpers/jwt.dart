import 'package:cuida_pet_api/entities/user_entity.dart';
import 'package:dartenv/dartenv.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class JWT {
  JWT._();

  static Map<String, dynamic> validate(String token) {
    token = token.replaceAll('bearer ', '');
    final data = verifyJwtHS256Signature(token, env('SECRET'));
    data.validate();
    return data.payload;
  }

  static String generateToken(UserEntity user) {
    final payload = JwtClaim(
      expiry: DateTime.now().add(const Duration(days: 1)),
      subject: user.id.toString(),
      otherClaims: {'supplierId': user.supplierId},
    );

    return issueJwtHS256(
      payload,
      env('SECRET'),
    );
  }
}
