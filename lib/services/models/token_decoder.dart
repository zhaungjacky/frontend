// To parse this JSON data, do
//
//     final tokenDecoder = tokenDecoderFromJson(jsonString);

import 'dart:convert';

TokenDecoder tokenDecoderFromJson(String str) =>
    TokenDecoder.fromJson(json.decode(str));

String tokenDecoderToJson(TokenDecoder data) => json.encode(data.toJson());

class TokenDecoder {
  final String? tokenType;
  final int? exp;
  final int? iat;
  final String? jti;
  final int? userId;

  TokenDecoder({
    this.tokenType,
    this.exp,
    this.iat,
    this.jti,
    this.userId,
  });

  factory TokenDecoder.fromJson(Map<String, dynamic> json) => TokenDecoder(
        tokenType: json["token_type"],
        exp: json["exp"],
        iat: json["iat"],
        jti: json["jti"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        "exp": exp,
        "iat": iat,
        "jti": jti,
        "user_id": userId,
      };
}
