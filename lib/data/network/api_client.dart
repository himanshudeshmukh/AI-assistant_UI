/// [ApiClient] - HTTP client for communicating with backend
///
/// Handles all HTTP requests to the backend API with:
/// - Request/response interceptors
/// - Error handling and mapping
/// - Automatic token attachment to requests
/// - Request timeout management
/// - JSON serialization/deserialization
///
/// Spring Boot JSON routes use `ApiResponse<T>`; see [ApiConfig.apiPrefix].
///
/// Uses http package. Add to pubspec.yaml:
/// dependencies:
///   http: ^1.1.0
library;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/constants/api_config.dart';
import '../../data/models/api_envelope.dart';
import '../../data/models/authentication_models.dart';
import '../../data/models/user_api_models.dart';
import '../../data/models/wallet_api_models.dart';

/// Exception thrown when API requests fail
///
/// For Spring `400` validation responses, [fieldErrors] may hold field → message.
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? responseBody;
  final Map<String, String>? fieldErrors;

  ApiException({
    required this.message,
    this.statusCode,
    this.responseBody,
    this.fieldErrors,
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

  /// Base URL prefix for JSON APIs (Spring `/api/v1`).
  ///
  /// Set at build/run time, for example:
  /// `flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080`
  ///
  /// Examples:
  /// - Android emulator → host: `http://10.0.2.2:8080`
  /// - iOS simulator → host: `http://127.0.0.1:8080`
  /// - Staging: `https://staging-api.example.com`
  /// - Production: `https://api.example.com`
  static String get baseUrl => ApiConfig.apiPrefix;

  /// Request timeout duration
  static const Duration requestTimeout = Duration(seconds: 30);

  /// Authentication token (updated after successful login)
  ///
  /// This token is automatically added to all subsequent requests
  /// in the Authorization header as: "Bearer {token}"
  String? _authToken;

  /// Cached user from register / verify-otp / profile calls (Spring API).
  User? _currentUser;

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

  /// Last user from [register] / [verifyOtp] / [updateProfile] / [deleteProfile].
  User? get currentUser => _currentUser;

  String? get currentUserId => _currentUser?.id;

  // ==================== Headers ====================

  /// Build common headers for all requests
  ///
  /// Returns:
  /// - Content-Type: application/json
  /// - Authorization: Bearer {token} (if logged in)
  /// - Accept: application/json
  Map<String, String> _buildHeaders() {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add authentication token if available
    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    return headers;
  }

  Uri _uri(String path, [Map<String, String>? query]) {
    final p = path.startsWith('/') ? path : '/$path';
    final base = Uri.parse(baseUrl);
    return base.replace(path: '${base.path}$p', queryParameters: query);
  }

  // ==================== Request Methods ====================

  /// Make a GET request
  ///
  /// Parameters:
  ///   - endpoint: API endpoint path (e.g., '/users/profile')
  ///
  /// Returns:
  /// - Decoded JSON response as Map<String, dynamic> (legacy: full body on 2xx)
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
      final response = await http
          .get(_uri(endpoint), headers: _buildHeaders())
          .timeout(requestTimeout);

      return _handleLegacyResponse(response);
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
      final response = await http
          .post(
            _uri(endpoint),
            headers: _buildHeaders(),
            body: jsonEncode(body),
          )
          .timeout(requestTimeout);

      return _handleLegacyResponse(response);
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
      final response = await http
          .put(
            _uri(endpoint),
            headers: _buildHeaders(),
            body: jsonEncode(body),
          )
          .timeout(requestTimeout);

      return _handleLegacyResponse(response);
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
      final response = await http
          .delete(_uri(endpoint), headers: _buildHeaders())
          .timeout(requestTimeout);

      return _handleLegacyResponse(response);
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

  /// Handle HTTP response (legacy paths: full JSON map on 2xx).
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
  Map<String, dynamic> _handleLegacyResponse(http.Response response) {
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        throw ApiException(
          message: 'Unexpected response',
          statusCode: response.statusCode,
        );
      }

      // Success response (2xx)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded;
      }

      // Error response (4xx, 5xx)
      final fieldErrors = validationFieldErrorsFromData(
        decoded['data'],
        response.statusCode,
      );
      throw ApiException(
        message: decoded['message']?.toString() ??
            'Request failed with status code ${response.statusCode}',
        statusCode: response.statusCode,
        responseBody: decoded,
        fieldErrors: fieldErrors,
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

  /// Unwrap Spring `ApiResponse<T>` and return [data], or throw [ApiException].
  dynamic _unwrapSpringEnvelope(http.Response response) {
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        throw ApiException(
          message: 'Unexpected response',
          statusCode: response.statusCode,
        );
      }
      final success = decoded['success'] as bool?;
      final okHttp = response.statusCode >= 200 && response.statusCode < 300;

      if (!okHttp || success == false) {
        final msg = decoded['message']?.toString() ?? 'Request failed';
        final err = decoded['error']?.toString();
        final combined = err != null && err.isNotEmpty ? '$msg ($err)' : msg;
        final fieldErrors = validationFieldErrorsFromData(
          decoded['data'],
          response.statusCode,
        );
        throw ApiException(
          message: combined,
          statusCode: response.statusCode,
          responseBody: decoded,
          fieldErrors: fieldErrors,
        );
      }
      return decoded['data'];
    } catch (e) {
      if (e is ApiException) rethrow;
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
  /// - ApiException always (unless [error] is already [ApiException])
  void _handleError(Object error) {
    print('🔴 API Error: $error');

    if (error is ApiException) {
      // rethrow;
      return;
    }

    throw ApiException(
      message: 'Network error: ${error.toString()}',
    );
  }

  // ==================== Spring Boot: users ====================

  Future<String> usersHealth() async {
    try {
      final res = await http
          .get(_uri('/users/health'), headers: _buildHeaders())
          .timeout(requestTimeout);
      final data = _unwrapSpringEnvelope(res);
      return data is String ? data : '$data';
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

  Future<User> register(RegisterRequest request) async {
    try {
      final res = await http
          .post(
            _uri('/users/register'),
            headers: _buildHeaders(),
            body: jsonEncode(request.toJson()),
          )
          .timeout(requestTimeout);
      final data = _unwrapSpringEnvelope(res);
      if (data is! Map<String, dynamic>) {
        throw ApiException(message: 'Invalid user payload', statusCode: res.statusCode);
      }
      final user = User.fromJson(data);
      _currentUser = user;
      return user;
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

  Future<User> verifyOtp(VerifyOtpRequest request) async {
    try {
      final res = await http
          .post(
            _uri('/users/verify-otp'),
            headers: _buildHeaders(),
            body: jsonEncode(request.toJson()),
          )
          .timeout(requestTimeout);
      final data = _unwrapSpringEnvelope(res);
      if (data is! Map<String, dynamic>) {
        throw ApiException(message: 'Invalid user payload', statusCode: res.statusCode);
      }
      final user = User.fromJson(data);
      _currentUser = user;
      return user;
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

  Future<String> sendLoginOtp(SendLoginOtpRequest request) async {
    try {
      final res = await http
          .post(
            _uri('/users/login/send-otp'),
            headers: _buildHeaders(),
            body: jsonEncode(request.toJson()),
          )
          .timeout(requestTimeout);
      final data = _unwrapSpringEnvelope(res);
      return data is String ? data : '$data';
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

  Future<User> updateProfile(String userId, ProfileUpdateRequest request) async {
    try {
      final res = await http
          .put(
            _uri('/users/$userId/profile'),
            headers: _buildHeaders(),
            body: jsonEncode(request.toJson()),
          )
          .timeout(requestTimeout);
      if (res.statusCode == 202) {
        try {
          final decoded = jsonDecode(res.body);
          if (decoded is Map<String, dynamic>) {
            final msg = decoded['message']?.toString() ?? 'Accepted';
            throw ApiException(
              message: msg,
              statusCode: 202,
              responseBody: decoded,
            );
          }
        } catch (_) {}
        throw ApiException(
          message: 'Firebase verification required for mobile change',
          statusCode: 202,
        );
      }
      final data = _unwrapSpringEnvelope(res);
      if (data is! Map<String, dynamic>) {
        throw ApiException(message: 'Invalid user payload', statusCode: res.statusCode);
      }
      final user = User.fromJson(data);
      _currentUser = user;
      return user;
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

  Future<User> deleteProfile(String userId) async {
    try {
      final res = await http
          .delete(_uri('/users/$userId/profile'), headers: _buildHeaders())
          .timeout(requestTimeout);
      final data = _unwrapSpringEnvelope(res);
      if (data is! Map<String, dynamic>) {
        throw ApiException(message: 'Invalid user payload', statusCode: res.statusCode);
      }
      final user = User.fromJson(data);
      _currentUser = user;
      return user;
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

  // ==================== Spring Boot: wallets ====================

  Future<int> walletBalance(String userId) async {
    try {
      final res = await http
          .get(_uri('/wallets/$userId/balance'), headers: _buildHeaders())
          .timeout(requestTimeout);
      final data = _unwrapSpringEnvelope(res);
      if (data is int) return data;
      if (data is num) return data.toInt();
      throw ApiException(message: 'Invalid balance payload', statusCode: res.statusCode);
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

  Future<List<WalletTransaction>> walletTransactions(
    String userId, {
    int limit = 20,
  }) async {
    try {
      final res = await http
          .get(
            _uri('/wallets/$userId/transactions', {'limit': '$limit'}),
            headers: _buildHeaders(),
          )
          .timeout(requestTimeout);
      final data = _unwrapSpringEnvelope(res);
      if (data is! List) {
        throw ApiException(
          message: 'Invalid transactions payload',
          statusCode: res.statusCode,
        );
      }
      return data
          .whereType<Map<String, dynamic>>()
          .map(WalletTransaction.fromJson)
          .toList();
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

  Future<RazorpayIntentData> createTopUpIntent(
    String userId, {
    required int amountRupees,
  }) async {
    try {
      final res = await http
          .post(
            _uri('/wallets/$userId/topup-intent', {
              'amountRupees': '$amountRupees',
            }),
            headers: _buildHeaders(),
          )
          .timeout(requestTimeout);
      final data = _unwrapSpringEnvelope(res);
      if (data is! Map<String, dynamic>) {
        throw ApiException(message: 'Invalid intent payload', statusCode: res.statusCode);
      }
      return RazorpayIntentData.fromJson(data);
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

  Future<RazorpayIntentData> createSubscriptionIntent(
    String userId, {
    required int amountRupees,
  }) async {
    try {
      final res = await http
          .post(
            _uri('/wallets/$userId/subscription-intent', {
              'amountRupees': '$amountRupees',
            }),
            headers: _buildHeaders(),
          )
          .timeout(requestTimeout);
      final data = _unwrapSpringEnvelope(res);
      if (data is! Map<String, dynamic>) {
        throw ApiException(message: 'Invalid intent payload', statusCode: res.statusCode);
      }
      return RazorpayIntentData.fromJson(data);
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
    _currentUser = null;
  }
}
