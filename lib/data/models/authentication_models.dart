/// [AuthenticationModels] - Data models for authentication operations
///
/// Contains all DTOs (Data Transfer Objects) for:
/// - Login request/response
/// - Signup request/response
/// - User data
///
/// These models ensure type-safe communication with the backend and
/// proper JSON serialization/deserialization.
///
/// NOTE: Using manual JSON serialization (no code generation needed!)
/// All toJson() and fromJson() methods are implemented directly.

// ==================== Login Models ====================

/// [LoginRequest] - Request payload for login operation
///
/// Fields:
///   - email: User's email address
///   - password: User's password (encrypted before sending)
///
/// JSON Example:
/// {
///   "email": "user@example.com",
///   "password": "hashedPassword123"
/// }
class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });

  /// Convert LoginRequest to JSON for API call
  /// Returns a Map ready for JSON encoding
  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };

  /// Create LoginRequest from JSON (for testing/responses)
  /// Parses JSON map and returns typed object
  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
    email: json['email'] as String,
    password: json['password'] as String,
  );

  @override
  String toString() => 'LoginRequest(email: $email, password: ****)';
}

/// [LoginResponse] - Response payload from login operation
///
/// Fields:
///   - success: Whether login was successful
///   - message: Server response message
///   - data: User data and auth token
///   - errors: Validation errors (if any)
///
/// JSON Example:
/// {
///   "success": true,
///   "message": "Login successful",
///   "data": {
///     "userId": "123",
///     "username": "frank",
///     "email": "user@example.com",
///     "token": "jwt_token_here"
///   },
///   "errors": null
/// }
class LoginResponse {
  final bool success;
  final String message;
  final AuthData? data;
  final Map<String, dynamic>? errors;

  const LoginResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
  });

  /// Convert LoginResponse to JSON
  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
    'errors': errors,
  };

  /// Create LoginResponse from JSON (backend response)
  /// Example:
  /// ```dart
  /// final jsonResponse = {
  ///   "success": true,
  ///   "message": "Login successful",
  ///   "data": {
  ///     "userId": "123",
  ///     "username": "frank",
  ///     "email": "user@example.com",
  ///     "token": "jwt_token"
  ///   }
  /// };
  /// final response = LoginResponse.fromJson(jsonResponse);
  /// ```
  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: json['data'] != null ? AuthData.fromJson(json['data']) : null,
    errors: json['errors'] as Map<String, dynamic>?,
  );

  @override
  String toString() =>
      'LoginResponse(success: $success, message: $message, data: $data)';
}

// ==================== Signup Models ====================

/// [SignupRequest] - Request payload for signup/registration
///
/// Fields:
///   - username: Unique username
///   - email: User's email address
///   - password: User's password
///
/// JSON Example:
/// {
///   "username": "frankrnz",
///   "email": "frankrnz@gmail.com",
///   "password": "hashedPassword123"
/// }
class SignupRequest {
  final String username;
  final String email;
  final String password;

  const SignupRequest({
    required this.username,
    required this.email,
    required this.password,
  });

  /// Convert SignupRequest to JSON for API call
  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'password': password,
  };

  /// Create SignupRequest from JSON (for testing)
  factory SignupRequest.fromJson(Map<String, dynamic> json) => SignupRequest(
    username: json['username'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
  );

  @override
  String toString() =>
      'SignupRequest(username: $username, email: $email, password: ****)';
}

/// [SignupResponse] - Response payload from signup operation
///
/// Fields:
///   - success: Whether signup was successful
///   - message: Server response message
///   - data: Created user data and auth token
///   - errors: Validation errors (if any)
///
/// JSON Example:
/// {
///   "success": true,
///   "message": "Account created successfully",
///   "data": {
///     "userId": "123",
///     "username": "frankrnz",
///     "email": "frankrnz@gmail.com",
///     "token": "jwt_token_here"
///   },
///   "errors": null
/// }
class SignupResponse {
  final bool success;
  final String message;
  final AuthData? data;
  final Map<String, dynamic>? errors;

  const SignupResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
  });

  /// Convert SignupResponse to JSON
  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
    'errors': errors,
  };

  /// Create SignupResponse from JSON (backend response)
  /// Example:
  /// ```dart
  /// final jsonResponse = {
  ///   "success": true,
  ///   "message": "Account created successfully",
  ///   "data": {
  ///     "userId": "123",
  ///     "username": "frank",
  ///     "email": "user@example.com",
  ///     "token": "jwt_token"
  ///   }
  /// };
  /// final response = SignupResponse.fromJson(jsonResponse);
  /// ```
  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: json['data'] != null ? AuthData.fromJson(json['data']) : null,
    errors: json['errors'] as Map<String, dynamic>?,
  );

  @override
  String toString() =>
      'SignupResponse(success: $success, message: $message, data: $data)';
}

// ==================== Common Auth Data ====================

/// [AuthData] - User data returned after successful authentication
///
/// Contains user information and authentication token.
///
/// Fields:
///   - userId: Unique user identifier
///   - username: User's username
///   - email: User's email address
///   - token: JWT authentication token for subsequent requests
///
/// Note: Only includes essential fields. Add more fields as needed
/// (e.g., profilePictureUrl, firstName, lastName, etc.)
///
/// Example:
/// ```dart
/// final jsonData = {
///   "userId": "123",
///   "username": "frank",
///   "email": "user@example.com",
///   "token": "jwt_token_here"
/// };
/// final authData = AuthData.fromJson(jsonData);
/// print(authData.token); // jwt_token_here
/// ```
class AuthData {
  final String userId;
  final String username;
  final String email;
  final String token;

  const AuthData({
    required this.userId,
    required this.username,
    required this.email,
    required this.token,
  });

  /// Convert AuthData to JSON
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'username': username,
    'email': email,
    'token': token,
  };

  /// Create AuthData from JSON (backend response)
  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
    userId: json['userId'] as String,
    username: json['username'] as String,
    email: json['email'] as String,
    token: json['token'] as String,
  );

  @override
  String toString() =>
      'AuthData(userId: $userId, username: $username, email: $email)';
}

// ==================== Error Response ====================

/// [ApiErrorResponse] - Standard error response from API
///
/// Used when any API call fails, provides structured error information.
///
/// Fields:
///   - success: Always false for error responses
///   - message: User-friendly error message
///   - errors: Detailed validation errors (field-specific)
///
/// JSON Example:
/// {
///   "success": false,
///   "message": "Validation failed",
///   "errors": {
///     "email": "Email format is invalid",
///     "password": "Password must be at least 8 characters"
///   }
/// }
///
/// Example:
/// ```dart
/// final jsonError = {
///   "success": false,
///   "message": "Invalid credentials",
///   "errors": {
///     "email": "Email not found"
///   }
/// };
/// final errorResponse = ApiErrorResponse.fromJson(jsonError);
/// print(errorResponse.message); // Invalid credentials
/// ```
class ApiErrorResponse {
  final bool success;
  final String message;
  final Map<String, dynamic>? errors;

  const ApiErrorResponse({
    required this.success,
    required this.message,
    this.errors,
  });

  /// Convert ApiErrorResponse to JSON
  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'errors': errors,
  };

  /// Create ApiErrorResponse from JSON (backend error response)
  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) =>
      ApiErrorResponse(
        success: json['success'] as bool,
        message: json['message'] as String,
        errors: json['errors'] as Map<String, dynamic>?,
      );

  @override
  String toString() => 'ApiErrorResponse(success: $success, message: $message)';
}

// ==================== Utility Extensions ====================

/// Extension to safely convert any JSON-like data to proper types
extension JsonExtension on Map<String, dynamic> {
  /// Safely get string value
  String? getString(String key) => this[key] as String?;

  /// Safely get bool value
  bool? getBool(String key) => this[key] as bool?;

  /// Safely get map value
  Map<String, dynamic>? getMap(String key) =>
      this[key] as Map<String, dynamic>?;

  /// Safely get list value
  List<dynamic>? getList(String key) => this[key] as List<dynamic>?;
}
