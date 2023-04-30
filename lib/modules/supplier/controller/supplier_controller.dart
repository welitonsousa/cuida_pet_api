import 'package:cuida_pet_api/application/excptions/service_exception.dart';
import 'package:cuida_pet_api/application/excptions/supplier_exception.dart';
import 'package:cuida_pet_api/application/excptions/user_exception.dart';
import 'package:cuida_pet_api/entities/supplier_service_entity.dart';
import 'package:cuida_pet_api/modules/supplier/view_model/create_supplier_input_model.dart';
import 'package:cuida_pet_api/modules/supplier/view_model/update_supplier_input_model.dart';
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

  @Route.post('/')
  Future<Response> registerSupplier(Request request) async {
    try {
      final json = await ValidaFields.reqFromMap(request);

      final required = {
        'name': Zod().type<String>().min(3),
        'phone': Zod().phone(),
        'email': Zod().type<String>().email(),
        'category_id': Zod().type<int>(),
      };

      final model = CreateSupplierInputModel.fromMap(json);
      final zod = Zod.validate(data: json, params: required);
      if (zod.isNotValid) {
        return ValidaFields.res(status: 400, map: {
          'message': 'Parâmetros de entrada inválidos',
          'data': zod.result,
        });
      }
      await _service.registerSupplier(model);
      return ValidaFields.res(map: {
        'message': 'Fornecedor cadastrado com sucesso',
      });
    } on SupplierExistesException {
      return ValidaFields.res(
        status: 403,
        map: {'message': 'Este usuário já é um fornecedor'},
      );
    } on UserNotExistException {
      return ValidaFields.res(
        status: 400,
        map: {
          'message': 'Parâmetros de entrada inválidos',
          'data': {'password': 'Senha inválida'},
        },
      );
    } catch (e, s) {
      _log.error('Erro ao cadastrar fornecedor', e, s);
      return ValidaFields.res(
        status: 500,
        map: {'message': 'Erro ao cadastrar fornecedor'},
      );
    }
  }

  @Route.put('/')
  Future<Response> updateSupplier(Request request) async {
    try {
      final json = await ValidaFields.reqFromMap(request);
      final required = {
        if (json['name'] != null) 'name': Zod().type<String>().min(3),
        if (json['phone'] != null) 'phone': Zod().phone(),
        if (json['logo'] != null) 'logo': Zod().type<String>(),
        if (json['lat'] != null) 'lat': Zod().type<double>(),
        if (json['lng'] != null) 'lng': Zod().type<double>(),
        if (json['category'] != null) 'id': Zod().type<int>(),
      };
      final zod = Zod.validate(data: json, params: required);
      if (zod.isNotValid) {
        return ValidaFields.res(status: 400, map: {
          'message': 'Parâmetros de entrada inválidos',
          'data': zod.result,
        });
      }
      json.addAll({'id': int.parse(request.headers['supplier']!)});
      final input = UpdateSupplierInputModel.fromMap(json);
      final res = await _service.updateSupplier(input);
      return ValidaFields.res(map: {
        'message': 'Fornecedor atualizado com sucesso',
        'data': res.toMap(),
      });
    } catch (e, s) {
      _log.error('Erro ao atualizar fornecedor', e, s);
      return ValidaFields.res(
          status: 500, map: {'message': 'Erro ao atualizar fornecedor'});
    }
  }

  @Route.get('/user')
  Future<Response> userExistesByEmail(Request req) async {
    try {
      final json = await ValidaFields.reqFromMap(req);
      final params = {'email': Zod().type<String>().email()};
      final zod = Zod.validate(data: json, params: params);

      if (zod.isNotValid) {
        return ValidaFields.res(status: 400, map: {
          'message': 'Parâmetros de entrada inválidos',
          'data': zod.result,
        });
      }
      final res = await _service.userExistes(json['email']!);
      if (res) return ValidaFields.res(status: 200);
      return ValidaFields.res(status: 204);
    } catch (e) {
      _log.error('Erro ao buscar fornecedor por email', e);
      return ValidaFields.res(
        status: 500,
        map: {'message': 'Erro ao buscar fornecedor'},
      );
    }
  }

  @Route.get('/<id>')
  Future<Response> findById(Request req, String id) async {
    try {
      final data = {'id': int.tryParse(id)};
      final params = {'id': Zod().type<int>()};

      final zod = Zod.validate(data: data, params: params);
      if (zod.isNotValid) {
        return ValidaFields.res(status: 400, map: {
          'message': 'Parâmetros de entrada inválidos',
          'data': zod.result,
        });
      }
      final res = await _service.findById(data['id']!);
      return ValidaFields.res(map: {'data': res.toMap()});
    } catch (e) {
      _log.error('Erro ao buscar fornecedor por id', e);
      return ValidaFields.res(
        status: 500,
        map: {'message': 'Erro ao buscar fornecedor'},
      );
    }
  }

  @Route.post('/service')
  Future<Response> registerService(Request request) async {
    try {
      final json = await ValidaFields.reqFromMap(request);
      final supplierId = int.tryParse(request.headers['supplier'] ?? '');

      final required = {
        'name': Zod().type<String>().min(3),
        'value': Zod().type<double>(),
        'supplier_id': Zod().type<int>(),
      };
      json.addAll({'supplier_id': supplierId});
      final zod = Zod.validate(data: json, params: required);
      if (zod.isNotValid) {
        return ValidaFields.res(status: 400, map: {
          'message': 'Parâmetros de entrada inválidos',
          'data': zod.result,
        });
      }

      final res = await _service.createService(
        name: json['name']!,
        value: json['value']!,
        supplierId: json['supplier_id']!,
      );

      return ValidaFields.res(map: {'data': res.toMap()});
    } catch (e) {
      _log.error('Erro ao cadastrar serviço', e);
      return ValidaFields.res(
        status: 500,
        map: {'message': 'Erro ao cadastrar serviço'},
      );
    }
  }

  @Route.put('/service/<id>')
  Future<Response> updateService(Request request) async {
    try {
      final json = await ValidaFields.reqFromMap(request);
      final supplierId = int.tryParse(request.headers['supplier'] ?? '');
      final id = int.tryParse(request.params['id'] ?? '');

      final required = {
        'name': Zod().type<String>().min(3),
        'value': Zod().type<double>(),
        'supplier_id': Zod().type<int>(),
        'id': Zod().type<int>('id inválido'),
      };
      json.addAll({'supplier_id': supplierId, 'id': id});
      final zod = Zod.validate(data: json, params: required);

      if (zod.isNotValid) {
        return ValidaFields.res(status: 400, map: {
          'message': 'Parâmetros de entrada inválidos',
          'data': zod.result,
        });
      }
      final entity = SupplierServiceEntity(
        id: id!,
        name: json['name']!,
        supplierId: supplierId!,
        value: json['value']!,
      );
      final res = await _service.updateService(entity);

      return ValidaFields.res(map: {'data': res.toMap()});
    } on ServiceNotExistesException {
      return ValidaFields.res(
        status: 404,
        map: {'message': 'Serviço não encontrado'},
      );
    } catch (e) {
      _log.error('Erro ao cadastrar serviço', e);
      return ValidaFields.res(
        status: 500,
        map: {'message': 'Erro ao cadastrar serviço'},
      );
    }
  }

  @Route.delete('/service/<id>')
  Future<Response> removeService(Request request) async {
    try {
      final supplierId = int.tryParse(request.headers['supplier'] ?? '');
      final id = int.tryParse(request.params['id'] ?? '');

      if (id == null) {
        return ValidaFields.res(status: 400, map: {
          'message': 'Serviço não encontrado',
          'data': {'id': 'id não informado na url'}
        });
      } else if (supplierId == null) {
        return ValidaFields.res(status: 403, map: {
          'message': 'Usuário não autorizado',
          'data': {'supplier_id': 'seu token não é de um fornecedor'}
        });
      }
      await _service.deleteService(supplierId, id);
      return ValidaFields.res(map: {'message': 'Serviço deletado'});
    } on ServiceNotExistesException {
      return ValidaFields.res(
        status: 404,
        map: {'message': 'Serviço não encontrado'},
      );
    } catch (e) {
      _log.error('Erro ao cadastrar serviço', e);
      return ValidaFields.res(
        status: 500,
        map: {'message': 'Erro ao cadastrar serviço'},
      );
    }
  }

  @Route.get('/service/<id>')
  Future<Response> listServices(Request request) async {
    try {
      final id = int.tryParse(request.params['id'] ?? '');
      if (id == null) {
        return ValidaFields.res(status: 400, map: {
          'message': 'Parâmetros de entrada inválidos',
          'data': {'id': 'Id inválido'},
        });
      }
      final res = await _service.getService(id);
      return ValidaFields.res(map: {
        'data': res.map((e) => e.toMap()).toList(),
      });
    } catch (e) {
      _log.error('Erro ao cadastrar serviço', e);
      return ValidaFields.res(
        status: 500,
        map: {'message': 'Erro ao cadastrar serviço'},
      );
    }
  }

  Router get router => _$SupplierControllerRouter(this);
}
