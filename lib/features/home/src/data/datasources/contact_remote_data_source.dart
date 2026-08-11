import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/contact_inquiry.dart';

abstract interface class ContactRemoteDataSource {
  Future<bool> sendContactInquiry(ContactInquiry inquiry, {String? accessKey});
}

final class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  static const String endpointUrl = 'https://api.web3forms.com/submit';
  final http.Client _client;

  ContactRemoteDataSourceImpl({http.Client? client})
    : _client = client ?? http.Client();

  @override
  Future<bool> sendContactInquiry(
    ContactInquiry inquiry, {
    String? accessKey,
  }) async {
    final effectiveAccessKey = accessKey?.trim() ?? '';

    if (effectiveAccessKey.isEmpty) _reportAccessKeyNotConfigured();

    return await _sendContactInquiry(inquiry, effectiveAccessKey);
  }

  void _reportAccessKeyNotConfigured() {
    throw StateError('Web3Forms Access Key is not configured.');
  }

  Future<bool> _sendContactInquiry(
    ContactInquiry inquiry,
    String accessKey,
  ) async {
    final response = await _client.post(
      Uri.parse(endpointUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'access_key': accessKey,
        'name': inquiry.fullName,
        'email': inquiry.corporateEmail,
        'message': inquiry.projectSummary,
        'subject': 'Portfolio Strategic Inquiry from ${inquiry.fullName}',
        'from_name': 'Portfolio Inquiry Form',
      }),
    );

    return response.statusCode >= 200 && response.statusCode < 300
        ? (jsonDecode(response.body) ?? {})['success'] == true
        : false;
  }
}
