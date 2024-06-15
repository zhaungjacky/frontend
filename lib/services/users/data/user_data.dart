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
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(UserInfo info) {
    throw UnimplementedError();
  }

  @override
  Future<UserInfo?> getUser(String id) async {
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
        final List<Map<String, dynamic>> body =
            List.from(json.decode(utf8.decode(res.bodyBytes)) as List);
        // final List<Map<String, dynamic>> body =
        //     List.from(jsonDecode(res.body) as List);

        // print(body.runtimeType);
        final lists = body.map((ele) => UserInfo.fromJson(ele)).toList();
        return lists;
      } else {
        return null;
      }
    } catch (err) {
      // print(err.toString());
      throw Exception(err.toString());
    }
  }

  @override
  Future<UserInfo?> updateUser(UserInfo info) {
    throw UnimplementedError();
  }
}
