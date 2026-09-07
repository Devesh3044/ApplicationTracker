import 'package:new_app/services/auth_service.dart';

class AuthRepository {
  final AuthService _service ;
  AuthRepository(this._service);

  Future<void> register (String email, String password)async{
    await _service.register(email,password);
  }

  Future<void> login (String email, String password) async{
    await _service.login(email, password);
  }

}