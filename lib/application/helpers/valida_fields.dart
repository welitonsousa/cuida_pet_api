import 'dart:convert';

import 'package:form_validator/form_validator.dart';
import 'package:shelf/shelf.dart';

class V extends ValidationBuilder {
  V() : super(localeName: 'pt-br');

  ValidationBuilder type<T>([String? message]) {
    return add((v) {
      if (v is T) return null;
      return message ?? 'O parâmetro precisa ser do tipo ${T.toString()}';
    });
  }
}

class ValidaFields {
  ValidaFields._();

  static V get v => V();

  static Future<Map<String, dynamic>> reqFromMap(Request req) async {
    String read = await req.readAsString();
    if (read.isEmpty) read = '{}';
    return jsonDecode(read);
  }

  static List<String> validate({
    required Map<String, dynamic> data,
    required Map<String, ValidationBuilder> params,
  }) {
    final errors = <String>[];
    params.forEach((key, value) {
      final valid = value.build()(data[key] ?? '');
      if (valid != null) errors.add('$key: $valid');
    });
    return errors;
  }

  static Response res({int status = 200, Map<String, dynamic>? map}) {
    return Response(status, body: map != null ? jsonEncode(map) : null);
  }
}
