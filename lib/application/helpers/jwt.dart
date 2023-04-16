import 'package:dartenv/dartenv.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class JWT {
  static Map<String, dynamic> validate(String token) {
    token = token.replaceAll('bearer ', '');
    final data = verifyJwtHS256Signature(token, env('SECRET'));
    data.validate();
    return data.payload;
  }
}
