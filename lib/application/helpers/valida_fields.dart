import 'dart:convert';
import 'package:shelf/shelf.dart';

class ValidaFields {
  ValidaFields._();

  static Future<Map<String, dynamic>> reqFromMap(Request req) async {
    String read = await req.readAsString();
    if (read.isEmpty) read = '{}';
    return jsonDecode(read);
  }

  static Response res({int status = 200, Map<String, dynamic>? map}) {
    return Response(status, body: map != null ? jsonEncode(map) : null);
  }
}
