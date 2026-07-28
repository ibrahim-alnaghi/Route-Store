import 'package:flutter_test/flutter_test.dart';
import 'package:route_store/features/authentication/data/models/update_profile_model.dart';

void main() {
  final fullJson = {
    'message': 'success',
    'user': {
      'name': 'Jane Doe',
      'email': 'jane@test.com',
    },
  };

  group('UpdateProfileModel.fromJson', () {
    test(
        'parses a full valid response into the right fields, using the passed-in currentToken for userToken',
        () {
      final model = UpdateProfileModel.fromJson(fullJson, 'current-tok-1');

      expect(model.userName, equals('Jane Doe'));
      expect(model.userEmail, equals('jane@test.com'));
      expect(model.userToken, equals('current-tok-1'));
    });

    test(
        'falls back to all-empty-string fields when "user" is null, without throwing',
        () {
      final json = {'message': 'success', 'user': null};

      final model = UpdateProfileModel.fromJson(json, 'current-tok-2');

      expect(model.userName, equals(''));
      expect(model.userEmail, equals(''));
      expect(model.userToken, equals('current-tok-2'));
    });

    test(
        'falls back to "" for an individual missing key within "user" (e.g. no email key)',
        () {
      final json = {
        'message': 'success',
        'user': {
          'name': 'Jane Doe',
        },
      };

      final model = UpdateProfileModel.fromJson(json, 'current-tok-3');

      expect(model.userName, equals('Jane Doe'));
      expect(model.userEmail, equals(''));
      expect(model.userToken, equals('current-tok-3'));
    });

    test('falls back to "" when "user" key itself is absent from the response',
        () {
      final json = {'message': 'success'};

      final model = UpdateProfileModel.fromJson(json, 'current-tok-4');

      expect(model.userName, equals(''));
      expect(model.userEmail, equals(''));
      expect(model.userToken, equals('current-tok-4'));
    });
  });
}
