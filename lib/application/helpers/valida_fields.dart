import 'dart:convert';

import 'package:form_validator/form_validator.dart';
import 'package:shelf/shelf.dart';

class ValidaFields {
  ValidaFields._();

  static ValidationBuilder get v => ValidationBuilder(localeName: 'pt-br');

  static Future<List<String>> validate({
    required String? read,
    required Map<String, ValidationBuilder> params,
  }) async {
    final data = jsonDecode((read ?? '').isEmpty ? '{}' : read!);
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
