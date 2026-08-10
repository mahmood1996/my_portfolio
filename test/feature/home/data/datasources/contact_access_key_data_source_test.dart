import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/home/src/data/datasources/contact_access_key_data_source.dart';

class FakeAssetBundle extends Fake implements AssetBundle {
  final String jsonContent;

  FakeAssetBundle(this.jsonContent);

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    return jsonContent;
  }
}

class ThrowingAssetBundle extends Fake implements AssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    throw Exception('File not found');
  }
}

void main() {
  group('ContactAccessKeyDataSourceImpl', () {
    test('returns access key from JSON when valid key is present', () async {
      const jsonContent = '''
      {
        "contact": {
          "email": "test@mail.com",
          "web3FormsAccessKey": "test-key-12345"
        }
      }
      ''';

      final dataSource = ContactAccessKeyDataSourceImpl(
        assetBundle: FakeAssetBundle(jsonContent),
      );

      final key = await dataSource.getAccessKey();
      expect(key, 'test-key-12345');
    });

    test('returns empty string when contact map has no key', () async {
      const jsonContent = '''
      {
        "contact": {
          "email": "test@mail.com"
        }
      }
      ''';

      final dataSource = ContactAccessKeyDataSourceImpl(
        assetBundle: FakeAssetBundle(jsonContent),
      );

      final key = await dataSource.getAccessKey();
      expect(key, '');
    });

    test('returns empty string when asset loading throws exception', () async {
      final dataSource = ContactAccessKeyDataSourceImpl(
        assetBundle: ThrowingAssetBundle(),
      );

      final key = await dataSource.getAccessKey();
      expect(key, '');
    });
  });
}
