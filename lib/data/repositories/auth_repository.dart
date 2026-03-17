// /// lib/data/repositories/auth_repository.dart
// ///
// /// Authentication repository implementing the repository pattern.
// /// Acts as a bridge between API client and business logic.
// ///
// /// Architecture Pattern: Clean Architecture
// /// - Dependency Inversion: Depends on abstractions, not concrete implementations
// /// - Single Responsibility: Only handles authentication data operations
// /// - Error Handling: Converts network exceptions to domain-level errors
// ///
// /// Key Responsibilities:
// /// 1. Coordinate authentication API calls
// /// 2. Manage token lifecycle (save, refresh, clear)
// /// 3. Handle session persistence
// /// 4. Provide clean interface for use cases
// ///
//
// import 'dart:async';
// import 'package:dio/dio.dart';
//
// import '../../core/models/auth_models.dart';
// import '../../core/network/api_client.dart';
// import '../../core/validators/form_validators.dart';
//
// /// ============================================================================
// /// AUTH REPOSITORY ABSTRACT CLASS
// /// ============================================================================
// /// Defines the contract for authentication operations.
// /// Enables dependency injection and testing with mock implementations.
// ///
// abstract class IAuthRepository {
//   /// Login with email and password.
//   ///
//   /// Parameters:
//   /// - [email]: User's email address
//   /// - [password]: User's password
//   /// - [rememberMe]: Whether to persist session
//   ///
//   /// Returns:
//   /// - [AuthSession] containing user and tokens
//   ///
//   /// Throws:
//   /// - [AuthException] if login fails
//   Future<AuthSession> login({
//     required String email,
//     required String password,
//     bool rememberMe = false,
//   });
//
//   /// Register a new user account.
//   ///
//   /// Parameters:
//   /// - [email]: User's email address
//   /// - [password]: User's password
//   /// - [fullName]: User's full name
//   /// - [confirmPassword]: Password confirmation
//   ///
//   /// Returns:
//   /// - [AuthSession] containing user and tokens
//   ///
//   /// Throws:
//   /// - [AuthException] if signup fails
//   Future<AuthSession> signup({
//     required String email,
//     required String password,
//     required String fullName,
//     required String confirmPassword,
//   });
//
//   /// Logout the current user.
//   /// Clears local tokens and notifies the server.
//   ///
//   /// Throws:
//   /// - [AuthException] if logout fails
//   Future<void> logout();
//
//   /// Refresh the access token using the refresh token.
//   /// Called when access token expires.
//   ///
//   /// Returns:
//   /// - [TokenPair] with new access token
//   ///
//   /// Throws:
//   /// - [AuthException] if refresh fails
//   Future<TokenPair> refreshAccessToken();
//
//   /// Verify user's email with verification code.
//   ///
//   /// Parameters:
//   /// - [email]: User's email address
//   /// - [verificationCode]: Code received in email
//   ///
//   /// Throws:
//   /// - [AuthException] if verification fails
//   Future<void> verifyEmail({
//     required String email,
//     required String verificationCode,
//   });
//
//   /// Request password reset for user account.
//   /// Sends reset link to user's email.
//   ///
//   /// Parameters:
//   /// - [email]: User's email address
//   ///
//   /// Throws:
//   /// - [AuthException] if request fails
//   Future<void> requestPasswordReset(String email);
//
//   /// Get current user profile.
//   ///
//   /// Returns:
//   /// - [User] object for authenticated user
//   ///
//   /// Throws:
//   /// - [AuthException] if unable to fetch profile
//   Future<User> getCurrentUser();
//
//   /// Check if user is currently authenticated.
//   ///
//   /// Returns:
//   /// - true if valid access token exists and is not expired
//   Future<bool> isAuthenticated();
//
//   /// Get stored access token.
//   ///
//   /// Returns:
//   /// - Access token string, or null if not available
//   Future<String?> getAccessToken();
//
//   /// Get stored refresh token.
//   ///
//   /// Returns:
//   /// - Refresh token string, or null if not available
//   Future<String?> getRefreshToken();
// }
//
// /// ============================================================================
// /// AUTH EXCEPTION
// /// ============================================================================
// /// Custom exception for authentication-related errors.
// /// Provides structured error information for UI handling.
// ///
// class AuthException implements Exception {
//   final String code;
//   final String message;
//   final dynamic originalException;
//
//   AuthException({
//     required this.code,
//     required this.message,
//     this.originalException,
//   });
//
//   /// Returns user-friendly error message.
//   @override
//   String toString() => message;
//
//   /// Creates AuthException from DioException.
//   factory AuthException.fromDioException(DioException error) {
//     final errorResponse = HttpExceptionHandler.parseErrorResponse(
//       error.response?.data,
//     );
//
//     return AuthException(
//       code: errorResponse.code,
//       message: HttpExceptionHandler.handleError(error),
//       originalException: error,
//     );
//   }
//
//   /// Creates AuthException from generic exception.
//   factory AuthException.fromException(dynamic error) {
//     return AuthException(
//       code: 'UNKNOWN_ERROR',
//       message: 'An unexpected error occurred. Please try again.',
//       originalException: error,
//     );
//   }
// }
//
// /// ============================================================================
// /// AUTH REPOSITORY IMPLEMENTATION
// /// ============================================================================
// /// Concrete implementation of IAuthRepository.
// /// Coordinates with API client and token storage.
// ///
// /// Key Design Decisions:
// /// 1. All public methods validate input before API calls
// /// 2. Token persistence happens before returning to caller
// /// 3. Automatic token refresh on 401 response
// /// 4. Session validation on authentication check
// ///
// class AuthRepository implements IAuthRepository {
//   final AuthApiClient _apiClient;
//   final TokenStorageService _tokenStorage;
//
//   // In-memory cache of current session for quick access
//   AuthSession? _cachedSession;
//
//   AuthRepository({
//     required AuthApiClient apiClient,
//     required TokenStorageService tokenStorage,
//   })  : _apiClient = apiClient,
//         _tokenStorage = tokenStorage;
//
//   /// ========================================================================
//   /// PUBLIC API
//   /// ========================================================================
//
//   @override
//   Future<AuthSession> login({
//     required String email,
//     required String password,
//     bool rememberMe = false,
//   }) async {
//     try {
//       // Validate input
//       final emailValidation = EmailValidator.validate(email);
//       if (!emailValidation.isValid) {
//         throw AuthException(
//           code: 'INVALID_EMAIL',
//           message: emailValidation.errorMessage ?? 'Invalid email address',
//         );
//       }
//
//       final passwordValidation = PasswordValidator.validate(password);
//       if (!passwordValidation.isValid) {
//         throw AuthException(
//           code: 'INVALID_PASSWORD',
//           message: passwordValidation.errorMessage ?? 'Invalid password format',
//         );
//       }
//
//       // Make API request
//       final request = LoginRequest(
//         email: email,
//         password: password,
//         rememberMe: rememberMe,
//       );
//
//       final response = await _apiClient.login(request);
//
//       // Persist tokens
//       await _tokenStorage.saveTokens(
//         accessToken: response.accessToken,
//         refreshToken: response.refreshToken,
//         expiresIn: response.expiresIn,
//       );
//
//       // Cache session
//       _cachedSession = AuthSession(
//         user: response.user,
//         tokens: TokenPair(
//           accessToken: response.accessToken,
//           refreshToken: response.refreshToken,
//           expiresAt: DateTime.now().add(Duration(seconds: response.expiresIn)),
//         ),
//       );
//
//       return _cachedSession!;
//     } on DioException catch (e) {
//       throw AuthException.fromDioException(e);
//     } catch (e) {
//       throw AuthException.fromException(e);
//     }
//   }
//
//   @override
//   Future<AuthSession> signup({
//     required String email,
//     required String password,
//     required String fullName,
//     required String confirmPassword,
//   }) async {
//     try {
//       // Validate all fields
//       final validationResults = SignupFormValidator.validateForm(
//         email: email,
//         password: password,
//         confirmPassword: confirmPassword,
//         fullName: fullName,
//         agreeToTerms: true, // Assumed to be validated in UI
//         agreeToPrivacy: true,
//       );
//
//       // Check for any validation errors
//       final invalidField = validationResults.entries
//           .firstWhere(
//             (entry) => !entry.value.isValid,
//         orElse: () => const MapEntry('', ValidationResult(isValid: true)),
//       );
//
//       if (invalidField.key.isNotEmpty) {
//         throw AuthException(
//           code: 'VALIDATION_ERROR',
//           message: invalidField.value.errorMessage ?? 'Validation failed',
//         );
//       }
//
//       // Make API request
//       final request = SignupRequest(
//         email: email,
//         password: password,
//         fullName: fullName,
//         confirmPassword: confirmPassword,
//         agreeToTerms: true,
//         agreeToPrivacy: true,
//       );
//
//       final response = await _apiClient.signup(request);
//
//       // Persist tokens
//       await _tokenStorage.saveTokens(
//         accessToken: response.accessToken,
//         refreshToken: response.refreshToken,
//         expiresIn: response.expiresIn,
//       );
//
//       // Cache session
//       _cachedSession = AuthSession(
//         user: response.user,
//         tokens: TokenPair(
//           accessToken: response.accessToken,
//           refreshToken: response.refreshToken,
//           expiresAt: DateTime.now().add(Duration(seconds: response.expiresIn)),
//         ),
//       );
//
//       return _cachedSession!;
//     } on DioException catch (e) {
//       throw AuthException.fromDioException(e);
//     } catch (e) {
//       throw AuthException.fromException(e);
//     }
//   }
//
//   @override
//   Future<void> logout() async {
//     try {
//       // Notify server
//       await _apiClient.logout();
//     } catch (e) {
//       // Proceed with local logout even if server call fails
//       print('Server logout failed: $e');
//     } finally {
//       // Clear local tokens regardless of server response
//       await _tokenStorage.clearTokens();
//       _cachedSession = null;
//     }
//   }
//
//   @override
//   Future<TokenPair> refreshAccessToken() async {
//     try {
//       final refreshToken = await _tokenStorage.getRefreshToken();
//
//       if (refreshToken == null) {
//         throw AuthException(
//           code: 'NO_REFRESH_TOKEN',
//           message: 'No refresh token available. Please login again.',
//         );
//       }
//
//       // Call refresh endpoint
//       final response = await _apiClient.refreshToken(refreshToken);
//
//       // Update stored tokens
//       await _tokenStorage.saveTokens(
//         accessToken: response.accessToken,
//         refreshToken: response.refreshToken,
//         expiresIn: response.expiresIn,
//       );
//
//       // Update cached session if it exists
//       if (_cachedSession != null) {
//         _cachedSession = _cachedSession!.copyWith(
//           tokens: TokenPair(
//             accessToken: response.accessToken,
//             refreshToken: response.refreshToken,
//             expiresAt: DateTime.now().add(Duration(seconds: response.expiresIn)),
//           ),
//         );
//       }
//
//       return TokenPair(
//         accessToken: response.accessToken,
//         refreshToken: response.refreshToken,
//         expiresAt: DateTime.now().add(Duration(seconds: response.expiresIn)),
//       );
//     } on DioException catch (e) {
//       // 401 means refresh token is invalid
//       if (e.response?.statusCode == 401) {
//         await _tokenStorage.clearTokens();
//         _cachedSession = null;
//       }
//       throw AuthException.fromDioException(e);
//     } catch (e) {
//       throw AuthException.fromException(e);
//     }
//   }
//
//   @override
//   Future<void> verifyEmail({
//     required String email,
//     required String verificationCode,
//   }) async {
//     try {
//       final emailValidation = EmailValidator.validate(email);
//       if (!emailValidation.isValid) {
//         throw AuthException(
//           code: 'INVALID_EMAIL',
//           message: emailValidation.errorMessage ?? 'Invalid email address',
//         );
//       }
//
//       if (verificationCode.isEmpty || verificationCode.length < 4) {
//         throw AuthException(
//           code: 'INVALID_CODE',
//           message: 'Invalid verification code',
//         );
//       }
//
//       await _apiClient.verifyEmail(email, verificationCode);
//     } on DioException catch (e) {
//       throw AuthException.fromDioException(e);
//     } catch (e) {
//       throw AuthException.fromException(e);
//     }
//   }
//
//   @override
//   Future<void> requestPasswordReset(String email) async {
//     try {
//       final emailValidation = EmailValidator.validate(email);
//       if (!emailValidation.isValid) {
//         throw AuthException(
//           code: 'INVALID_EMAIL',
//           message: emailValidation.errorMessage ?? 'Invalid email address',
//         );
//       }
//
//       await _apiClient.requestPasswordReset(email);
//     } on DioException catch (e) {
//       throw AuthException.fromDioException(e);
//     } catch (e) {
//       throw AuthException.fromException(e);
//     }
//   }
//
//   @override
//   Future<User> getCurrentUser() async {
//     try {
//       return await _apiClient.getCurrentUser();
//     } on DioException catch (e) {
//       throw AuthException.fromDioException(e);
//     } catch (e) {
//       throw AuthException.fromException(e);
//     }
//   }
//
//   @override
//   Future<bool> isAuthenticated() async {
//     try {
//       final accessToken = await _tokenStorage.getAccessToken();
//       if (accessToken == null) return false;
//
//       final isExpired = await _tokenStorage.isAccessTokenExpired();
//       if (isExpired) {
//         // Try to refresh token
//         try {
//           await refreshAccessToken();
//           return true;
//         } catch (e) {
//           return false;
//         }
//       }
//
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   @override
//   Future<String?> getAccessToken() async {
//     return await _tokenStorage.getAccessToken();
//   }
//
//   @override
//   Future<String?> getRefreshToken() async {
//     return await _tokenStorage.getRefreshToken();
//   }
// }
