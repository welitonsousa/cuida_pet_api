import 'dart:io';
import 'package:shelf/src/response.dart';
import 'package:shelf/src/request.dart';
import 'i_middlewares.dart';

class CorsMiddleware extends IMiddleware {
  final Map<String, String> headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, PATCH, DELETE, OPTIONS',
    'Access-Control-Allow-Headers':
        '${HttpHeaders.contentTypeHeader}, ${HttpHeaders.authorizationHeader}'
  };

  @override
  Future<Response> execute(Request request) async {
    if (request.method == 'OPTIONS') {
      return Response(HttpStatus.ok, headers: headers);
    }
    final response = await innerHandler(request);
    return response.change(headers: headers);
  }
}
