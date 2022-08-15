import 'package:jwt_decoder/jwt_decoder.dart';

class TokenModel {
  final String? token;
  final String? tokenType;
  final DateTime? exp;
  final String? jti;
  final String? userId;
  final String? okuroId;
  final String? role;

  TokenModel({
    this.token,
    this.tokenType,
    this.exp,
    this.jti,
    this.userId,
    this.okuroId,
    this.role,
  });

  factory TokenModel.fromString(String token) {
    final payload = JwtDecoder.decode(token);
    return TokenModel(
      token: token,
      tokenType: payload['token_type'],
      exp: DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000).toLocal(),
      jti: payload['jti'],
      userId: payload['user_id'],
      okuroId: payload['okuro_id'],
      role: payload['role'],
    );
  }

  isExpired() {
    return DateTime.now().isAfter(this.exp!);
  }
}
