import 'dart:convert';

import 'package:frontend/services/auth/data-source/auth_data.dart';
import 'package:frontend/services/models/user_info.dart';
import 'package:frontend/services/singleton/singleton.dart';
import 'package:frontend/services/storage/storage.dart';
import "package:http/http.dart" as http;

abstract interface class UserData {
  Future<List<UserInfo>?> getUserLists();
  Future<UserInfo?> getUser(String id);
  Future<UserInfo?> addUser(UserInfo info);
  Future<UserInfo?> updateUser(UserInfo info);
  Future<void> deleteUser(UserInfo info);
}

class UserDataImpl implements UserData {
  @override
  Future<UserInfo?> addUser(Object info) {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(UserInfo info) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<UserInfo?> getUser(String id) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<List<UserInfo>?> getUserLists() async {
    final url = "${AuthDataImpl.url()}api/test/";

    try {
      final Map<String, String> headers = {};
      final access =
          await singleton<SharedModel>().getItem(SharedModel.accessKey());
      if (access != null) {
        headers["Content-Type"] = "application/json";
        headers["Authorization"] = "Bearer $access";
      }

      final res = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      // print(res.statusCode);
      if (res.statusCode == 200) {
        final body = res.body;
        print("res_body $body");
        final listsDecode = jsonDecode(body) as List<Map<String, dynamic>>;
        final lists = listsDecode.map((ele) => UserInfo.fromJson(ele)).toList();
        // print(listsDecode);
        return lists;
      } else {
        return null;
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  @override
  Future<UserInfo?> updateUser(UserInfo info) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
