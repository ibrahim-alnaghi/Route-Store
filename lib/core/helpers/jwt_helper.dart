import 'dart:convert';

class JwtHelper {
  JwtHelper._();

  static String? decodeUserId(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
      final payload =
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      final map = jsonDecode(payload) as Map<String, dynamic>;
      return map['id']?.toString();
    } catch (_) {
      return null;
    }
  }
}
