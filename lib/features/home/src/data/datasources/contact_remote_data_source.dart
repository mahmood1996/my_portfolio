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
    if (effectiveAccessKey.isEmpty) {
      // In development or when key is not configured, throw exception or fail gracefully
      throw StateError('Web3Forms Access Key is not configured.');
    }

    final payload = {
      'access_key': effectiveAccessKey,
      'name': inquiry.fullName,
      'email': inquiry.corporateEmail,
      'message': inquiry.projectSummary,
      'subject': 'Portfolio Strategic Inquiry from ${inquiry.fullName}',
      'from_name': 'Portfolio Inquiry Form',
    };

    final uri = Uri.parse(endpointUrl);
    final response = await _client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['success'] == true;
    } else {
      return false;
    }
  }
}
