import 'dart:convert';

Jwt jwtFromJson(String str) => Jwt.fromJson(json.decode(str));

String jwtToJson(Jwt data) => json.encode(data.toJson());

class Jwt {
  final String? refresh;
  final String? access;

  Jwt({
    this.refresh,
    this.access,
  });

  factory Jwt.fromJson(Map<String, dynamic> json) => Jwt(
        refresh: json["refresh"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
      };
}
