import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:5050';
  static const String callbackUrlScheme = 'yatraguardian';
  static const _secureStorage = FlutterSecureStorage();
  
  static Future<Map<String, dynamic>?> authenticateWithGoogle() async {
    try {
      final callbackUrl = '$callbackUrlScheme://auth/google/callback';
      final encodedCallback = Uri.encodeComponent(callbackUrl);
      final authUrl = '$baseUrl/api/auth/google?redirect_uri=$encodedCallback';
      
      if (kDebugMode) {
        print('Starting Google OAuth with URL: $authUrl');
        print('Callback URL: $callbackUrl');
      }
      
      final result = await FlutterWebAuth2.authenticate(
        url: authUrl,
        callbackUrlScheme: callbackUrlScheme,
      );
      
      if (kDebugMode) {
        print('OAuth callback received: $result');
      }
      
      final uri = Uri.parse(result);
      final token = uri.queryParameters['token'];
      final error = uri.queryParameters['error'];
      
      if (error != null) {
        throw 'Authentication failed: $error';
      }
      
      if (token != null) {
        await storeToken(token);
        return await getUserProfile(token);
      } else {
        throw 'No token received from authentication';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in Google authentication: $e');
      }
      rethrow;
    }
  }
  
  static Future<Map<String, dynamic>?> authenticateWithMicrosoft() async {
    try {
      final callbackUrl = '$callbackUrlScheme://auth/microsoft/callback';
      final encodedCallback = Uri.encodeComponent(callbackUrl);
      final authUrl = '$baseUrl/api/auth/microsoft?redirect_uri=$encodedCallback';
      
      if (kDebugMode) {
        print('Starting Microsoft OAuth with URL: $authUrl');
        print('Callback URL: $callbackUrl');
      }
      
      final result = await FlutterWebAuth2.authenticate(
        url: authUrl,
        callbackUrlScheme: callbackUrlScheme,
      );
      
      if (kDebugMode) {
        print('OAuth callback received: $result');
      }
      
      final uri = Uri.parse(result);
      final token = uri.queryParameters['token'];
      final error = uri.queryParameters['error'];
      
      if (error != null) {
        throw 'Authentication failed: $error';
      }
      
      if (token != null) {
        await storeToken(token);
        return await getUserProfile(token);
      } else {
        throw 'No token received from authentication';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in Microsoft authentication: $e');
      }
      rethrow;
    }
  }
  
  static Future<Map<String, dynamic>?> getUserProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/user/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw 'Failed to get user profile: ${response.statusCode}';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting user profile: $e');
      }
      return null;
    }
  }
  
  static Future<void> storeToken(String token) async {
    try {
      await _secureStorage.write(key: 'auth_token', value: token);
      if (kDebugMode) {
        print('Token stored securely: ${token.substring(0, 10)}...');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error storing token: $e');
      }
      rethrow;
    }
  }
  
  static Future<String?> getStoredToken() async {
    try {
      return await _secureStorage.read(key: 'auth_token');
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving token: $e');
      }
      return null;
    }
  }
  
  static Future<void> clearStoredToken() async {
    try {
      await _secureStorage.delete(key: 'auth_token');
      if (kDebugMode) {
        print('Token cleared');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing token: $e');
      }
    }
  }
  
  static Future<bool> isAuthenticated() async {
    final token = await getStoredToken();
    if (token == null) return false;
    
    final profile = await getUserProfile(token);
    return profile != null;
  }
  
  static Future<void> logout() async {
    await clearStoredToken();
  }
}
