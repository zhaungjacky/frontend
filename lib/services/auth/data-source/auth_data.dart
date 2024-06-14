import 'dart:convert';

import 'package:frontend/services/models/jwt_model.dart';
import 'package:frontend/services/singleton/singleton.dart';
import 'package:frontend/services/storage/storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

abstract interface class AuthData {
  Future<Jwt?> login({
    required String username,
    required String password,
  });
  Future<void> logout();
}

class AuthDataImpl implements AuthData {
  static String url() => "http://192.168.31.99:8000/";
  static String username() => "username";
  @override
  Future<void> logout() async {
    try {
      await singleton<SharedModel>().removeItem(SharedModel.accessKey());
      await singleton<SharedModel>().removeItem(SharedModel.refresh());
      await singleton<SharedModel>().removeItem(SharedModel.tokenDecoder());
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  @override
  Future<Jwt?> login({
    required String username,
    required String password,
  }) async {
    try {
      final body = {
        "username": username,
        "password": password,
      };
      final url = Uri.parse("${AuthDataImpl.url()}api/token/");
      final res = await http.post(
        url,
        body: body,
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(utf8.decode(res.bodyBytes));
        final jwt = Jwt.fromJson(data);
        final storageService = singleton<SharedModel>();
        //save access and fresj
        await storageService.saveJwt(
          access: jwt.access!,
          refresh: jwt.refresh!,
        );
        final tokenDecoder = JwtDecoder.decode(jwt.access!);

        //save token_decoded info
        await storageService.setItem(
          SharedModel.tokenDecoder(),
          tokenDecoder.toString(),
        );

        await storageService.setItem(
          AuthDataImpl.username(),
          username,
        );

        return jwt;
      } else {
        return null;
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
