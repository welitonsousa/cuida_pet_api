import 'dart:convert';
import 'package:crypto/crypto.dart';

class Cripto {
  Cripto._();

  static String encrypt(String text) {
    final encoded = utf8.encode(text);
    return sha256.convert(encoded).toString();
  }
}
