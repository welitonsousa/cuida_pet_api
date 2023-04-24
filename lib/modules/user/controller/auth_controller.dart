import 'dart:async';
import 'package:cuida_pet_api/application/excptions/user_exception.dart';
import 'package:cuida_pet_api/application/helpers/jwt.dart';
import 'package:cuida_pet_api/application/helpers/valida_fields.dart';
import 'package:cuida_pet_api/application/logger/i_logger.dart';
import 'package:cuida_pet_api/entities/user_entity.dart';
import 'package:cuida_pet_api/modules/user/service/i_user_service.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_find_model.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_refresh_token_model.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_save_input_model.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_sign_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:zod_validation/zod_validation.dart';

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
      final valid = Zod.validate(
        data: data,
        params: UserSaveInputModel.validation(data),
      );

      if (valid.isNotValid) {
        return ValidaFields.res(map: {'messages': valid.result});
      }
      final user = UserSaveInputModel.fromMap(data);
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

  @Route.put('/refresh')
  Future<Response> refresh(Request req) async {
    final id = int.parse(req.headers['user']!);

    try {
      final json = await ValidaFields.reqFromMap(req);
      json.addAll({
        'user_id': id,
        'refresh_token': req.headers['refresh_token'],
      });
      final user = UserFindModel.fromMap(json);

      final lastUserInstance = await _userService.findUser(user);
      if (lastUserInstance.refreshToken == json['refresh_token']) {
        return Response(401, body: 'Token inválido');
      }
      final userRefresh = UserRefreshTokenModel(
          userId: user.id, refreshToken: json['refresh_token']);
      final userEntity = await _userService.refreshToken(userRefresh);
      final newToken = JWT.generateToken(userEntity);
      final newRefreshToken = JWT.generateRefreshToken(newToken);

      return ValidaFields.res(map: {
        'messages': ['Token renovado com sucesso'],
        'data': {
          'token': newToken,
          'refreshToken': newRefreshToken,
        }
      });
    } catch (e) {
      return ValidaFields.res(status: 401, map: {
        'messages': ['Token inválido']
      });
    }
  }

  @Route.post('/sign')
  Future<Response> sign(Request request) async {
    final json = await ValidaFields.reqFromMap(request);

    final valid = Zod.validate(
      data: json,
      params: UserSignModel.validation(json),
    );
    if (valid.isNotValid) {
      return ValidaFields.res(map: {
        'messages': valid.result,
      });
    }

    try {
      final user = UserSignModel.fromMap(json);

      String token;
      UserEntity userEntity;
      if (user.socialType == null) {
        userEntity = await _userService.signWithEmail(user);
        token = JWT.generateToken(userEntity);
      } else {
        userEntity = await _userService.signSocial(user);
        token = JWT.generateToken(userEntity);
      }
      String refreshToken = JWT.generateRefreshToken(token);
      return ValidaFields.res(map: {
        'messages': ['Usuário logado com sucesso'],
        'data': {
          'token': token,
          'refreshToken': refreshToken,
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
