import 'dart:async';
import 'package:cuida_pet_api/application/excptions/user_exception.dart';
import 'package:cuida_pet_api/application/helpers/jwt.dart';
import 'package:cuida_pet_api/application/helpers/valida_fields.dart';
import 'package:cuida_pet_api/application/logger/i_logger.dart';
import 'package:cuida_pet_api/modules/user/service/i_user_service.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_save_input_model.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_sign_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'auth_controller.g.dart';

@Injectable()
class AuthController {
  final IUserService _userService;
  final ILogger _log;

  AuthController(this._userService, this._log);

  @Route.post('/register')
  Future<Response> find(Request request) async {
    try {
      final data = await ValidaFields.reqFromMap(request);
      final valid = ValidaFields.validate(
        data: data,
        params: UserSaveInputModel.validation(data),
      );
      if (valid.isNotEmpty) return ValidaFields.res(map: {'messages': valid});
      final user = UserSaveInputModel(data);
      final res = await _userService.createUser(user);
      return ValidaFields.res(
        map: {
          'messages': ['Usuário cadastrado com sucesso'],
          'data': res.toMap()
        },
      );
    } on UserExistException {
      return ValidaFields.res(
        status: 400,
        map: {
          'messages': ['Usuário já cadastrado']
        },
      );
    } on UserGenericException {
      return ValidaFields.res(
        status: 400,
        map: {
          'messages': ['Erro ao cadastrar usuário']
        },
      );
    } catch (e) {
      return ValidaFields.res(
        status: 500,
        map: {
          'messages': ['Erro interno do servidor']
        },
      );
    }
  }

  @Route.post('/sign')
  Future<Response> sign(Request request) async {
    final json = await ValidaFields.reqFromMap(request);
    final fields = ValidaFields.validate(
      data: json,
      params: UserSignModel.validation(json),
    );
    if (fields.isNotEmpty) return ValidaFields.res(map: {'messages': fields});

    try {
      final user = UserSignModel(json);
      final userEntity = await _userService.signWithEmail(user);

      final token = JWT.generateToken(userEntity);
      return ValidaFields.res(map: {
        'messages': ['Usuário logado com sucesso'],
        'data': {
          'token': token,
          'user': userEntity.toMap(),
        }
      });
    } on UserNotExistException {
      return ValidaFields.res(
        status: 400,
        map: {
          'messages': ['Usuário ou senha inválidos']
        },
      );
    } on UserGenericException {
      return ValidaFields.res(
        status: 400,
        map: {
          'messages': ['Erro ao logar usuário']
        },
      );
    } catch (e, s) {
      _log.error('social sign error', e, s);
      return ValidaFields.res(
        status: 500,
        map: {
          'messages': ['Erro interno']
        },
      );
    }
  }

  Router get router => _$AuthControllerRouter(this);
}
