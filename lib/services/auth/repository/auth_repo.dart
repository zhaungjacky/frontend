import 'package:frontend/services/auth/data-source/auth_data.dart';
import 'package:frontend/services/models/jwt_model.dart';

abstract interface class AuthRepo {
  Future<Jwt?> login({
    required String username,
    required String password,
  });

  Future<void> logout();
}

class AuthRepoImpl implements AuthRepo {
  final AuthData _authData;

  AuthRepoImpl({
    required AuthData authData,
  }) : _authData = authData;

  @override
  Future<Jwt?> login({
    required String username,
    required String password,
  }) async {
    final res = await _authData.login(
      username: username,
      password: password,
    );
    if (res != null) return res;
    return null;
  }

  @override
  Future<void> logout() async {
    await _authData.logout();
  }
}
