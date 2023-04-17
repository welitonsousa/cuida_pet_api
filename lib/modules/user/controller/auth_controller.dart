import 'dart:async';
import 'package:cuida_pet_api/application/excptions/user_exception.dart';
import 'package:cuida_pet_api/application/helpers/valida_fields.dart';
import 'package:cuida_pet_api/modules/user/service/i_user_service.dart';
import 'package:cuida_pet_api/modules/user/view_models/user_save_input_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'auth_controller.g.dart';

@Injectable()
class AuthController {
  final IUserService _userService;

  AuthController(this._userService);

  @Route.post('/register')
  Future<Response> find(Request request) async {
    try {
      final read = await request.readAsString();
      final valid = await ValidaFields.validate(
        read: read,
        params: {
          'password': ValidaFields.v.minLength(8),
          'email': ValidaFields.v.email(),
        },
      );
      if (valid.isNotEmpty) return ValidaFields.res(map: {'messages': valid});
      final user = UserSaveInputModel(read);
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
      print(e);
      return ValidaFields.res(
        status: 500,
        map: {
          'messages': ['Erro interno do servidor']
        },
      );
    }
  }

  Router get router => _$AuthControllerRouter(this);
}
