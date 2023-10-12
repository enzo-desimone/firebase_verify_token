import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jose/jose.dart';

import 'firebase_token.dart';

class FirebaseVerifyToken {

  static late String projectId;

  static Future<bool> verify(String token) async {
    try {
      final keys = await _fetchPublicKeys();
      final jwt = JsonWebToken.unverified(token);
      final kid = FirebaseJWT.parseJwtHeader(token)['kid'] as String?;

      if (kid == null) {
        return false;
      }

      final publicKey = JsonWebKey.fromPem(keys[kid]!, keyId: kid);

      final keyStore = JsonWebKeyStore()
        ..addKey(JsonWebKey.fromJson(publicKey.toJson()));

      final isSignatureValid = await jwt.verify(keyStore);

      if (!isSignatureValid) {
        return false;
      }

      final now = DateTime.now();

      if (jwt.claims['aud'] != projectId) {
        return false;
      }
      if (jwt.claims['exp'] == null ||
          DateTime.fromMillisecondsSinceEpoch((jwt.claims['exp'] as int) * 1000)
              .isBefore(now)) {
        return false;
      }
      if (jwt.claims['iat'] == null ||
          DateTime.fromMillisecondsSinceEpoch((jwt.claims['iat'] as int) * 1000)
              .isAfter(now)) {
        return false;
      }

      if (jwt.claims['iss'] != 'https://securetoken.google.com/$projectId') {
        return false;
      }
      if (jwt.claims['sub'] == null || (jwt.claims['sub'] as String).isEmpty) {
        return false;
      }
      if (jwt.claims['auth_time'] == null ||
          DateTime.fromMillisecondsSinceEpoch(
            (jwt.claims['auth_time'] as int) * 1000,
          ).isAfter(now)) {
        return false;
      }

      return true;
    } catch (e) {
      debugPrint('Error verify token: ($e)');
      return false;
    }
  }

  static Future<Map<String, String>> _fetchPublicKeys() async {
    final response = await http.get(
      Uri.parse(
        'https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com',
      ),
    );
    if (response.statusCode == 200) {
      return Map<String, String>.from(json.decode(response.body) as Map);
    } else {
      throw Exception('Failed to load public keys');
    }
  }
}


