import 'dart:async';
import '../../domain/entities/contact_inquiry.dart';
import '../../domain/repositories/contact_inquiry_repository.dart';
import '../datasources/contact_access_key_data_source.dart';
import '../datasources/contact_remote_data_source.dart';

final class ContactInquiryRepositoryImpl implements ContactInquiryRepository {
  final ContactAccessKeyDataSource accessKeyDataSource;
  final ContactRemoteDataSource remoteDataSource;

  ContactInquiryRepositoryImpl({
    ContactAccessKeyDataSource? accessKeyDataSource,
    ContactRemoteDataSource? remoteDataSource,
  })  : accessKeyDataSource =
            accessKeyDataSource ?? ContactAccessKeyDataSourceImpl(),
        remoteDataSource =
            remoteDataSource ?? ContactRemoteDataSourceImpl();

  @override
  Future<bool> sendContactInquiry(ContactInquiry inquiry) async {
    try {
      return inquiry.isValid ? await _trySendingInquiry(inquiry) : false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> _trySendingInquiry(ContactInquiry inquiry) async {
    final accessKey = await accessKeyDataSource.getAccessKey();

    return accessKey.trim().isEmpty
        ? Future.delayed(const Duration(milliseconds: 500), () => true)
        : await remoteDataSource.sendContactInquiry(
            inquiry,
            accessKey: accessKey.trim(),
          );
  }
}
