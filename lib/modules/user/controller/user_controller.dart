import 'package:cuida_pet_api/application/helpers/valida_fields.dart';
import 'package:cuida_pet_api/application/logger/i_logger.dart';
import 'package:cuida_pet_api/entities/user_entity.dart';
import 'package:cuida_pet_api/modules/user/service/i_user_service.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_find_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
part 'user_controller.g.dart';

@Injectable()
class UserController {
  final ILogger _log;
  final IUserService _userService;

  UserController(this._log, this._userService);

  @Route.get('/me')
  Future<Response> find(Request req) async {
    try {
      final id = int.parse(req.headers['user']!);
      final userReq = UserFindModel(id: id);
      final user = await _userService.findUser(userReq);
      return ValidaFields.res(map: {'data': user.toMap()});
    } catch (e) {
      _log.error('Erro ao buscar usuário', e);
      return ValidaFields.res(status: 500, map: {
        'messages': ['Erro interno no servidor']
      });
    }
  }

  @Route.put('/me')
  Future<Response> updateUser(Request req) async {
    try {
      final json = await ValidaFields.reqFromMap(req);
      final id = int.parse(req.headers['user']!);
      json.addAll({'id': id});
      final user = UserEntity.fromMap(json);
      final res = await _userService.updateUser(user);
      return ValidaFields.res(map: {'data': res.toMap()});
    } catch (e) {
      _log.error('Erro ao atualizar usuário', e);
      return ValidaFields.res(status: 500, map: {
        'messages': ['Erro interno no servidor']
      });
    }
  }

  Router get router => _$UserControllerRouter(this);
}
