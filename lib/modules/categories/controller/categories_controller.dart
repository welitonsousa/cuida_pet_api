import 'dart:async';
import 'package:cuida_pet_api/application/helpers/valida_fields.dart';
import 'package:cuida_pet_api/application/logger/i_logger.dart';
import 'package:cuida_pet_api/modules/categories/service/i_category_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'categories_controller.g.dart';

@Injectable()
class CategoriesController {
  final ILogger _log;
  final ICategoryService _service;

  CategoriesController(this._log, this._service);

  @Route.get('/')
  Future<Response> find(Request request) async {
    try {
      final categories = await _service.getCategories();
      return ValidaFields.res(map: {
        'data': categories.map((e) => e.toMap()).toList(),
      });
    } catch (e) {
      _log.error('Erro ao buscar categorias', e);
      return ValidaFields.res(status: 500, map: {
        'message': 'Erro ao buscar categorias',
      });
    }
  }

  Router get router => _$CategoriesControllerRouter(this);
}
