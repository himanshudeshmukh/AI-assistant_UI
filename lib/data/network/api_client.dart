/// [ApiClient] - HTTP client for communicating with backend
///
/// Handles all HTTP requests to the backend API with:
/// - Request/response interceptors
/// - Error handling and mapping
/// - Automatic token attachment to requests
/// - Request timeout management
/// - JSON serialization/deserialization
///
/// Uses http package. Add to pubspec.yaml:
/// dependencies:
///   http: ^1.1.0
library;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/models/authentication_models.dart';

/// Exception thrown when API requests fail
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? responseBody;

  ApiException({
    required this.message,
    this.statusCode,
    this.responseBody,
  });

  @override
  String toString() => message;
}

/// HTTP API Client for backend communication
///
/// Singleton pattern ensures only one instance of the client throughout the app
///
/// Usage:
/// ```
/// final apiClient = ApiClient.instance;
/// final response = await apiClient.login(loginRequest);
/// ```
class ApiClient {
  // ==================== Singleton Pattern ====================
  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal();

  static ApiClient get instance => _instance;

  // ==================== Configuration ====================

  /// Base URL for the backend API
  /// Update this with your actual backend URL
  ///
  /// Examples:
  /// - Local development: http://192.168.1.100:8080/api
  /// - Staging: https://staging-api.example.com/api
  /// - Production: https://api.example.com/api
  static const String baseUrl = 'http://192.168.1.100:8080/api';

  /// Request timeout duration
  static const Duration requestTimeout = Duration(seconds: 30);

  /// Authentication token (updated after successful login)
  ///
  /// This token is automatically added to all subsequent requests
  /// in the Authorization header as: "Bearer {token}"
  String? _authToken;

  // ==================== Getter & Setter ====================

  /// Get current authentication token
  String? getAuthToken() => _authToken;

  /// Set authentication token (called after successful login)
  void setAuthToken(String token) {
    _authToken = token;
  }

  /// Clear authentication token (called on logout)
  void clearAuthToken() {
    _authToken = null;
  }

  // ==================== Headers ====================

  /// Build common headers for all requests
  ///
  /// Returns:
  /// - Content-Type: application/json
  /// - Authorization: Bearer {token} (if logged in)
  /// - Accept: application/json
  Map<String, String> _buildHeaders() {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add authentication token if available
    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    return headers;
  }

  // ==================== Request Methods ====================

  /// Make a GET request
  ///
  /// Parameters:
  ///   - endpoint: API endpoint path (e.g., '/users/profile')
  ///
  /// Returns:
  /// - Decoded JSON response as Map<String, dynamic>
  ///
  /// Throws:
  /// - ApiException on network or HTTP errors
  ///
  /// Example:
  /// ```
  /// final userData = await apiClient.get('/users/profile');
  /// ```
  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');

      final response = await http
          .get(
        url,
        headers: _buildHeaders(),
      )
          .timeout(requestTimeout);

      return _handleResponse(response);
    } on TimeoutException {
      throw ApiException(
        message: 'Request timeout. Please check your connection.',
        statusCode: null,
      );
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// Make a POST request
  ///
  /// Parameters:
  ///   - endpoint: API endpoint path (e.g., '/auth/login')
  ///   - body: Request body as Map (will be JSON encoded)
  ///
  /// Returns:
  /// - Decoded JSON response as Map<String, dynamic>
  ///
  /// Throws:
  /// - ApiException on network or HTTP errors
  ///
  /// Example:
  /// ```
  /// final response = await apiClient.post(
  ///   '/auth/login',
  ///   body: {'email': 'user@example.com', 'password': 'pass123'},
  /// );
  /// ```
  Future<Map<String, dynamic>> post(
      String endpoint, {
        required Map<String, dynamic> body,
      }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');

      final response = await http
          .post(
        url,
        headers: _buildHeaders(),
        body: jsonEncode(body),
      )
          .timeout(requestTimeout);

      return _handleResponse(response);
    } on TimeoutException {
      throw ApiException(
        message: 'Request timeout. Please check your connection.',
        statusCode: null,
      );
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// Make a PUT request
  ///
  /// Parameters:
  ///   - endpoint: API endpoint path
  ///   - body: Request body as Map
  ///
  /// Returns:
  /// - Decoded JSON response
  ///
  /// Throws:
  /// - ApiException on errors
  Future<Map<String, dynamic>> put(
      String endpoint, {
        required Map<String, dynamic> body,
      }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');

      final response = await http
          .put(
        url,
        headers: _buildHeaders(),
        body: jsonEncode(body),
      )
          .timeout(requestTimeout);

      return _handleResponse(response);
    } on TimeoutException {
      throw ApiException(
        message: 'Request timeout. Please check your connection.',
        statusCode: null,
      );
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// Make a DELETE request
  ///
  /// Parameters:
  ///   - endpoint: API endpoint path
  ///
  /// Returns:
  /// - Decoded JSON response
  ///
  /// Throws:
  /// - ApiException on errors
  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');

      final response = await http
          .delete(
        url,
        headers: _buildHeaders(),
      )
          .timeout(requestTimeout);

      return _handleResponse(response);
    } on TimeoutException {
      throw ApiException(
        message: 'Request timeout. Please check your connection.',
        statusCode: null,
      );
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // ==================== Response Handling ====================

  /// Handle HTTP response
  ///
  /// - 2xx: Return decoded JSON
  /// - 4xx/5xx: Throw ApiException with error details
  ///
  /// Parameters:
  ///   - response: HTTP response object
  ///
  /// Returns:
  /// - Decoded JSON as Map<String, dynamic>
  ///
  /// Throws:
  /// - ApiException on error status codes
  Map<String, dynamic> _handleResponse(http.Response response) {
    try {
      final decodedResponse = jsonDecode(response.body);

      // Success response (2xx)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decodedResponse;
      }

      // Error response (4xx, 5xx)
      throw ApiException(
        message: decodedResponse['message'] ??
            'Request failed with status code ${response.statusCode}',
        statusCode: response.statusCode,
        responseBody: decodedResponse,
      );
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }

      throw ApiException(
        message: 'Failed to decode response',
        statusCode: response.statusCode,
      );
    }
  }

  /// Handle errors from HTTP requests
  ///
  /// Logs errors and throws ApiException
  ///
  /// Parameters:
  ///   - error: The error that occurred
  ///
  /// Throws:
  /// - ApiException always
  void _handleError(Object error) {
    print('🔴 API Error: $error');

    if (error is ApiException) {
      // rethrow;
    }

    throw ApiException(
      message: 'Network error: ${error.toString()}',
    );
  }

  // ==================== Authentication Endpoints ====================

  /// Login with email and password
  ///
  /// Parameters:
  ///   - email: User's email address
  ///   - password: User's password
  ///
  /// Returns:
  /// - LoginResponse with user data and auth token
  ///
  /// Throws:
  /// - ApiException on login failure
  ///
  /// Usage:
  /// ```
  /// final response = await apiClient.login(
  ///   email: 'user@example.com',
  ///   password: 'password123',
  /// );
  /// if (response.success) {
  ///   apiClient.setAuthToken(response.data!.token);
  /// }
  /// ```
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await post(
        '/auth/login',
        body: {
          'email': email,
          'password': password,
        },
      );

      return LoginResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Register a new user account
  ///
  /// Parameters:
  ///   - username: Desired username
  ///   - email: User's email address
  ///   - password: User's password
  ///
  /// Returns:
  /// - SignupResponse with created user data and auth token
  ///
  /// Throws:
  /// - ApiException on registration failure
  ///
  /// Usage:
  /// ```
  /// final response = await apiClient.signup(
  ///   username: 'frank',
  ///   email: 'frank@example.com',
  ///   password: 'password123',
  /// );
  /// ```
  Future<SignupResponse> signup({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await post(
        '/auth/signup',
        body: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      return SignupResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Logout user (clear local token and notify backend)
  ///
  /// This clears the stored authentication token locally.
  /// Backend should handle token invalidation if needed.
  ///
  /// Usage:
  /// ```
  /// await apiClient.logout();
  /// ```
  void logout() {
    clearAuthToken();
  }
}
