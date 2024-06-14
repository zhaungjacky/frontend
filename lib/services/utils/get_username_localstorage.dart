import 'package:frontend/services/auth/data-source/auth_data.dart';
import 'package:frontend/services/singleton/singleton.dart';
import 'package:frontend/services/storage/storage.dart';

Future<String?> getUsernameFromLocalstorage() async {
  try {
    final res = await singleton<SharedModel>().getItem(AuthDataImpl.username());
    if (res != null) {
      return res;
    }
    return null;
  } catch (err) {
    throw Exception(err.toString());
  }
}
