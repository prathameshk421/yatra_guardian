import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  // Using port 5050 as that's where your backend actually runs
  static const String baseUrl = 'http://localhost:5050';
  static const String callbackUrlScheme = 'yatraguardian';
  
  // Secure storage instance
  static const _secureStorage = FlutterSecureStorage();
  
  /// Launch Google OAuth authentication with proper callback handling
  static Future<Map<String, dynamic>?> authenticateWithGoogle() async {
    try {
      // The callback URL that your backend should redirect to after successful auth
      final callbackUrl = '$callbackUrlScheme://auth/google/callback';
      
      // URL encode the callback URL
      final encodedCallback = Uri.encodeComponent(callbackUrl);
      
      // Construct the auth URL with callback
      final authUrl = '$baseUrl/api/auth/google?redirect_uri=$encodedCallback';
      
      if (kDebugMode) {
        print('Starting Google OAuth with URL: $authUrl');
        print('Callback URL: $callbackUrl');
      }
      
      // Launch web auth and wait for callback
      final result = await FlutterWebAuth2.authenticate(
        url: authUrl,
        callbackUrlScheme: callbackUrlScheme,
      );
      
      if (kDebugMode) {
        print('OAuth callback received: $result');
      }
      
      // Parse the callback URL to extract token or code
      final uri = Uri.parse(result);
      final token = uri.queryParameters['token'];
      final error = uri.queryParameters['error'];
      
      if (error != null) {
        throw 'Authentication failed: $error';
      }
      
      if (token != null) {
        // Store token and get user profile
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
  
  /// Launch Microsoft OAuth authentication with proper callback handling
  static Future<Map<String, dynamic>?> authenticateWithMicrosoft() async {
    try {
      // The callback URL that your backend should redirect to after successful auth
      final callbackUrl = '$callbackUrlScheme://auth/microsoft/callback';
      
      // URL encode the callback URL
      final encodedCallback = Uri.encodeComponent(callbackUrl);
      
      // Construct the auth URL with callback
      final authUrl = '$baseUrl/api/auth/microsoft?redirect_uri=$encodedCallback';
      
      if (kDebugMode) {
        print('Starting Microsoft OAuth with URL: $authUrl');
        print('Callback URL: $callbackUrl');
      }
      
      // Launch web auth and wait for callback
      final result = await FlutterWebAuth2.authenticate(
        url: authUrl,
        callbackUrlScheme: callbackUrlScheme,
      );
      
      if (kDebugMode) {
        print('OAuth callback received: $result');
      }
      
      // Parse the callback URL to extract token or code
      final uri = Uri.parse(result);
      final token = uri.queryParameters['token'];
      final error = uri.queryParameters['error'];
      
      if (error != null) {
        throw 'Authentication failed: $error';
      }
      
      if (token != null) {
        // Store token and get user profile
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
  
  /// Get user profile using token
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
  
  /// Store authentication token securely
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
  
  /// Get stored authentication token
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
  
  /// Clear stored authentication token
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
  
  /// Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    final token = await getStoredToken();
    if (token == null) return false;
    
    // Validate token by checking user profile
    final profile = await getUserProfile(token);
    return profile != null;
  }
  
  /// Logout user
  static Future<void> logout() async {
    await clearStoredToken();
  }
}
