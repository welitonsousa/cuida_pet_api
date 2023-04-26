import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:zod_validation/zod_validation.dart';

import 'package:cuida_pet_api/application/helpers/valida_fields.dart';
import 'package:cuida_pet_api/application/logger/i_logger.dart';
import 'package:cuida_pet_api/modules/supplier/service/i_supplier_service.dart';

part 'supplier_controller.g.dart';

@Injectable()
class SupplierController {
  final ISupplierService _service;
  final ILogger _log;
  SupplierController(this._service, this._log);

  @Route.get('/')
  Future<Response> find(Request request) async {
    try {
      final data = {
        'lat': double.tryParse(request.url.queryParameters['lat'] ?? ''),
        'lng': double.tryParse(request.url.queryParameters['lng'] ?? ''),
      };
      final params = {'lat': Zod().type<double>(), 'lng': Zod().type<double>()};
      final zod = Zod.validate(data: data, params: params);
      if (zod.isNotValid) {
        return ValidaFields.res(status: 400, map: {
          'message': 'Parâmetros de entrada inválidos',
          'data': zod.result,
        });
      }
      final res = await _service.findNearByPosition(data['lat']!, data['lng']!);
      return ValidaFields.res(
          map: {'data': res.map((e) => e.toMap()).toList()});
    } catch (e) {
      _log.error('Erro ao buscar fornecedores', e);
      return ValidaFields.res(
        status: 500,
        map: {'message': 'Erro ao buscar fornecedores'},
      );
    }
  }

  Router get router => _$SupplierControllerRouter(this);
}
