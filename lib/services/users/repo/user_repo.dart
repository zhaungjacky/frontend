import 'package:frontend/services/models/user_info.dart';
import 'package:frontend/services/users/data/user_data.dart';

abstract interface class UserRepo {
  Future<List<UserInfo>?> getUserLists();
}

class UserRepoImpl extends UserRepo {
  final UserData _userData;

  UserRepoImpl({required UserData userData}) : _userData = userData;
  @override
  Future<List<UserInfo>?> getUserLists() async {
    final res = await _userData.getUserLists();
    return res;
  }
}
