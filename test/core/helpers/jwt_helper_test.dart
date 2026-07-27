import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:route_store/core/helpers/jwt_helper.dart';

void main() {
  String encodeSegment(Object value) {
    final jsonString = value is String ? value : jsonEncode(value);
    return base64Url.encode(utf8.encode(jsonString));
  }

  String buildToken(Map<String, dynamic> payload) {
    final header = encodeSegment({'alg': 'HS256', 'typ': 'JWT'});
    final body = encodeSegment(payload);
    const signature = 'dummy-signature';
    return '$header.$body.$signature';
  }

  group('JwtHelper.decodeUserId', () {
    test('should return the id claim when the token is a valid 3-segment JWT',
        () {
      // arrange
      final token =
          buildToken({'id': 'abc123', 'name': 'test', 'role': 'user'});

      // act
      final result = JwtHelper.decodeUserId(token);

      // assert
      expect(result, equals('abc123'));
    });

    test('should return null when the token has fewer than 3 segments', () {
      // arrange
      final token = [
        encodeSegment({'alg': 'HS256'}),
        encodeSegment({'id': 'abc123'}),
      ].join('.');

      // act
      final result = JwtHelper.decodeUserId(token);

      // assert
      expect(result, isNull);
    });

    test('should return null when the token has more than 3 segments', () {
      // arrange
      final validToken = buildToken({'id': 'abc123'});
      final token = '$validToken.extra-segment';

      // act
      final result = JwtHelper.decodeUserId(token);

      // assert
      expect(result, isNull);
    });

    test(
        'should return null when the middle segment is not valid base64 data',
        () {
      // arrange
      const token = 'header.not!!valid==base64.signature';

      // act
      final result = JwtHelper.decodeUserId(token);

      // assert
      expect(result, isNull);
    });

    test('should return null when the decoded payload is not valid JSON', () {
      // arrange
      final header = encodeSegment({'alg': 'HS256'});
      final body = encodeSegment('this is not json');
      final token = '$header.$body.signature';

      // act
      final result = JwtHelper.decodeUserId(token);

      // assert
      expect(result, isNull);
    });

    test(
        'should return null when the valid JSON payload does not contain an id key',
        () {
      // arrange
      final token = buildToken({'name': 'test', 'role': 'user'});

      // act
      final result = JwtHelper.decodeUserId(token);

      // assert
      expect(result, isNull);
    });
  });
}
