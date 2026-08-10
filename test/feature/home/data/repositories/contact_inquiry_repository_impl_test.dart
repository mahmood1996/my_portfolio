import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/home/src/data/datasources/contact_access_key_data_source.dart';
import 'package:portfolio/features/home/src/data/datasources/contact_remote_data_source.dart';
import 'package:portfolio/features/home/src/data/repositories/contact_inquiry_repository_impl.dart';
import 'package:portfolio/features/home/src/domain/entities/contact_inquiry.dart';

class FakeAccessKeyDataSource implements ContactAccessKeyDataSource {
  final String accessKey;

  FakeAccessKeyDataSource({this.accessKey = ''});

  @override
  Future<String> getAccessKey() async => accessKey;
}

class FakeRemoteDataSource implements ContactRemoteDataSource {
  final bool shouldSucceed;
  final bool shouldThrow;

  FakeRemoteDataSource({this.shouldSucceed = true, this.shouldThrow = false});

  @override
  Future<bool> sendContactInquiry(
    ContactInquiry inquiry, {
    String? accessKey,
  }) async {
    if (shouldThrow) throw Exception('Network error');
    return shouldSucceed;
  }
}

void main() {
  const tInquiry = ContactInquiry(
    fullName: 'Mahmoud',
    corporateEmail: 'mahmoud@test.com',
    projectSummary: 'Test summary',
  );

  group('ContactInquiryRepositoryImpl sendContactInquiry', () {
    test('returns false if fullName or corporateEmail is empty', () async {
      final repo = ContactInquiryRepositoryImpl(
        accessKeyDataSource: FakeAccessKeyDataSource(accessKey: 'some-key'),
        remoteDataSource: FakeRemoteDataSource(),
      );

      final result1 = await repo.sendContactInquiry(
        const ContactInquiry(
          fullName: '',
          corporateEmail: 'test@mail.com',
          projectSummary: 'Hi',
        ),
      );
      final result2 = await repo.sendContactInquiry(
        const ContactInquiry(
          fullName: 'Test',
          corporateEmail: '',
          projectSummary: 'Hi',
        ),
      );

      expect(result1, isFalse);
      expect(result2, isFalse);
    });

    test('returns true in placeholder/dev mode when access key is empty', () async {
      final repo = ContactInquiryRepositoryImpl(
        accessKeyDataSource: FakeAccessKeyDataSource(accessKey: ''),
        remoteDataSource: FakeRemoteDataSource(shouldSucceed: false),
      );

      final result = await repo.sendContactInquiry(tInquiry);
      expect(result, isTrue);
    });

    test(
      'delegates to remoteDataSource when valid key is present and returns success',
      () async {
        final repo = ContactInquiryRepositoryImpl(
          accessKeyDataSource:
              FakeAccessKeyDataSource(accessKey: 'valid-api-key-123'),
          remoteDataSource: FakeRemoteDataSource(shouldSucceed: true),
        );

        final result = await repo.sendContactInquiry(tInquiry);
        expect(result, isTrue);
      },
    );

    test('returns false when remoteDataSource throws exception', () async {
      final repo = ContactInquiryRepositoryImpl(
        accessKeyDataSource:
            FakeAccessKeyDataSource(accessKey: 'valid-api-key-123'),
        remoteDataSource: FakeRemoteDataSource(shouldThrow: true),
      );

      final result = await repo.sendContactInquiry(tInquiry);
      expect(result, isFalse);
    });
  });
}
