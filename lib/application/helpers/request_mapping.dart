import 'dart:convert';

abstract class RequestMapping<T> {
  final Map<String, dynamic> data;

  RequestMapping(String data) : data = jsonDecode(data) {
    fromMap();
  }
  RequestMapping.empty() : data = {};

  T fromMap();
}
