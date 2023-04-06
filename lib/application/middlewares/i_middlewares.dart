import 'package:shelf/shelf.dart';

abstract class IMiddleware {
  late Handler innerHandler;
  Handler handle(Handler innerHandler) {
    this.innerHandler = innerHandler;
    return execute;
  }

  Future<Response> execute(Request request);
}
