import 'dart:convert';
import 'package:flutter/services.dart';

abstract interface class ContactAccessKeyDataSource {
  Future<String> getAccessKey();
}

final class ContactAccessKeyDataSourceImpl
    implements ContactAccessKeyDataSource {
  final AssetBundle _assetBundle;
  final String _jsonPath;

  ContactAccessKeyDataSourceImpl({
    AssetBundle? assetBundle,
    this._jsonPath = 'assets/data/portfolio_data_v2.json',
  }) : _assetBundle = assetBundle ?? rootBundle;

  @override
  Future<String> getAccessKey() async {
    try {
      return await _accessKey();
    } catch (e) {
      return '';
    }
  }

  Future<String> _accessKey() async {
    final jsonString = await _assetBundle.loadString(_jsonPath);

    return switch (json.decode(jsonString)) {
      Map<String, dynamic> data =>
        data['contact']?['web3FormsAccessKey']?.toString().trim() ?? '',

      _ => String.fromEnvironment(
        'WEB3FORMS_ACCESS_KEY',
        defaultValue: '',
      ).trim(),
    };
  }
}
