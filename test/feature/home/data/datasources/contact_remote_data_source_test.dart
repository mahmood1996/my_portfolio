import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:portfolio/features/home/src/data/datasources/contact_remote_data_source.dart';
import 'package:portfolio/features/home/src/domain/entities/contact_inquiry.dart';

void main() {
  const tInquiry = ContactInquiry(
    fullName: 'Mahmoud Test',
    corporateEmail: 'mahmoud@example.com',
    projectSummary: 'Need a Flutter enterprise consultation.',
  );

  group('ContactRemoteDataSourceImpl', () {
    test(
      'should return true when Web3Forms responds with 200 OK and success: true',
      () async {
        final mockClient = MockClient((request) async {
          expect(request.url.toString(), equals('https://api.web3forms.com/submit'));
          expect(request.method, equals('POST'));
          expect(
            request.headers['Content-Type'],
            contains('application/json'),
          );

          final body = jsonDecode(request.body) as Map<String, dynamic>;
          expect(body['access_key'], equals('test-access-key'));
          expect(body['name'], equals(tInquiry.fullName));
          expect(body['email'], equals(tInquiry.corporateEmail));
          expect(body['message'], equals(tInquiry.projectSummary));

          return http.Response(
            jsonEncode({'success': true, 'message': 'Email sent successfully'}),
            200,
          );
        });

        final dataSource = ContactRemoteDataSourceImpl(client: mockClient);
        final result = await dataSource.sendContactInquiry(
          tInquiry,
          accessKey: 'test-access-key',
        );

        expect(result, isTrue);
      },
    );

    test(
      'should return false when Web3Forms responds with 400 Bad Request or success: false',
      () async {
        final mockClient = MockClient((request) async {
          return http.Response(
            jsonEncode({'success': false, 'message': 'Invalid access key'}),
            400,
          );
        });

        final dataSource = ContactRemoteDataSourceImpl(client: mockClient);
        final result = await dataSource.sendContactInquiry(
          tInquiry,
          accessKey: 'invalid-key',
        );

        expect(result, isFalse);
      },
    );

    test(
      'should throw StateError when access key is empty',
      () async {
        final dataSource = ContactRemoteDataSourceImpl();

        expect(
          () => dataSource.sendContactInquiry(tInquiry, accessKey: ''),
          throwsA(isA<StateError>()),
        );
      },
    );
  });
}
