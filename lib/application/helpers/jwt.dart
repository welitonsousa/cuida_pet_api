import 'package:cuida_pet_api/entities/user_entity.dart';
import 'package:dartenv/dartenv.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class JWT {
  JWT._();

  static Map<String, dynamic> validate({
    required String token,
    String issuer = 'cuida-pet',
    bool validate = true,
  }) {
    token = token.replaceAll('Bearer ', '');
    issuer = issuer.replaceAll('Bearer ', '');
    final data = verifyJwtHS256Signature(token, env('SECRET'));
    if (validate) data.validate(issuer: issuer);
    return data.toJson();
  }

  static String generateRefreshToken(String token) {
    token = token.replaceAll('Bearer ', '');
    final payload = JwtClaim(
      issuer: token,
      expiry: DateTime.now().add(const Duration(days: 20)),
      subject: 'token-refresh',
    );

    return issueJwtHS256(
      payload,
      env('SECRET'),
    );
  }

  static String generateToken(UserEntity user) {
    final payload = JwtClaim(
      issuer: 'cuida-pet',
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
