export 'package:cuida_pet_api/application/helpers/valida_fields.dart';

typedef ValidMap = Map<String, dynamic>;
typedef ValidData = Map<String, dynamic>;

abstract class RequestMapping {
  final Map<String, dynamic> data;

  RequestMapping(this.data) {
    fromMap();
  }
  RequestMapping.empty() : data = {};

  void fromMap();
}
