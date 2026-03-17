// /// lib/presentation/providers/auth_provider.dart
// ///
// /// State management for authentication using Riverpod.
// /// Manages authentication state, user session, and loading states.
// ///
// /// Architecture Pattern: Riverpod state management
// /// - StateNotifiers for complex state logic
// /// - Providers for dependency injection
// /// - FutureProviders for async operations
// ///
// /// Key Concepts:
// /// 1. AuthStateNotifier: Manages current auth state
// /// 2. authProvider: Main auth state access point
// /// 3. Async providers: For individual auth operations
// /// 4. Family providers: For parameterized operations
// ///
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:dio/dio.dart';
//
// import '../../core/models/auth_models.dart';
// import '../../core/network/api_client.dart';
// import '../../data/repositories/auth_repository.dart';
//
// /// ============================================================================
// /// AUTH STATE MODEL
// /// ============================================================================
// /// Represents the current authentication state.
// /// Uses sealed class pattern for type-safe state management.
// ///
// sealed class AuthState {
//   const AuthState();
// }
//
// /// User is not authenticated.
// class AuthStateUnauthenticated extends AuthState {
//   const AuthStateUnauthenticated();
// }
//
// /// Authentication in progress.
// class AuthStateLoading extends AuthState {
//   const AuthStateLoading();
// }
//
// /// User is authenticated.
// class AuthStateAuthenticated extends AuthState {
//   final AuthSession session;
//
//   const AuthStateAuthenticated(this.session);
// }
//
// /// Authentication error occurred.
// class AuthStateError extends AuthState {
//   final String code;
//   final String message;
//
//   const AuthStateError({
//     required this.code,
//     required this.message,
//   });
// }
//
// /// ============================================================================
// /// DEPENDENCIES PROVIDERS
// /// ============================================================================
// /// Provides instances of required dependencies.
// /// Using providers enables dependency injection and testing.
// ///
//
// /// Provides FlutterSecureStorage instance.
// final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
//   return const FlutterSecureStorage();
// });
//
// /// Provides TokenStorageService instance.
// final tokenStorageProvider = Provider<TokenStorageService>((ref) {
//   final storage = ref.watch(secureStorageProvider);
//   return TokenStorageService(storage);
// });
//
// /// Provides Dio instance configured for API calls.
// final dioProvider = Provider<Dio>((ref) {
//   final tokenStorage = ref.watch(tokenStorageProvider);
//   final dioConfig = DioConfigService(tokenStorage);
//   return dioConfig.createDio();
// });
//
// /// Provides AuthApiClient instance.
// final authApiClientProvider = Provider<AuthApiClient>((ref) {
//   final dio = ref.watch(dioProvider);
//   return AuthApiClient(dio);
// });
//
// /// Provides AuthRepository instance.
// final authRepositoryProvider = Provider<IAuthRepository>((ref) {
//   final apiClient = ref.watch(authApiClientProvider);
//   final tokenStorage = ref.watch(tokenStorageProvider);
//   return AuthRepository(
//     apiClient: apiClient,
//     tokenStorage: tokenStorage,
//   );
// });
//
// /// ============================================================================
// /// AUTH STATE NOTIFIER
// /// ============================================================================
// /// Manages authentication state transitions.
// /// Handles login, signup, logout, and token refresh operations.
// ///
// class AuthStateNotifier extends StateNotifier<AuthState> {
//   final IAuthRepository _authRepository;
//
//   AuthStateNotifier(this._authRepository)
//       : super(const AuthStateUnauthenticated()) {
//     // Check if user is already authenticated on initialization
//     _initializeAuthState();
//   }
//
//   /// Initializes authentication state on app startup.
//   /// Checks for existing session and validates tokens.
//   Future<void> _initializeAuthState() async {
//     try {
//       state = const AuthStateLoading();
//
//       final isAuthenticated = await _authRepository.isAuthenticated();
//       if (isAuthenticated) {
//         // Try to load current user
//         final user = await _authRepository.getCurrentUser();
//         final accessToken = await _authRepository.getAccessToken();
//         final refreshToken = await _authRepository.getRefreshToken();
//
//         if (accessToken != null && refreshToken != null) {
//           state = AuthStateAuthenticated(
//             AuthSession(
//               user: user,
//               tokens: TokenPair(
//                 accessToken: accessToken,
//                 refreshToken: refreshToken,
//                 expiresAt: DateTime.now().add(const Duration(hours: 1)),
//               ),
//             ),
//           );
//           return;
//         }
//       }
//
//       state = const AuthStateUnauthenticated();
//     } catch (e) {
//       state = const AuthStateUnauthenticated();
//     }
//   }
//
//   /// Performs login operation.
//   ///
//   /// Parameters:
//   /// - [email]: User's email address
//   /// - [password]: User's password
//   /// - [rememberMe]: Whether to persist session
//   ///
//   /// Updates state to AuthStateAuthenticated on success,
//   /// or AuthStateError on failure.
//   Future<void> login({
//     required String email,
//     required String password,
//     bool rememberMe = false,
//   }) async {
//     try {
//       state = const AuthStateLoading();
//
//       final session = await _authRepository.login(
//         email: email,
//         password: password,
//         rememberMe: rememberMe,
//       );
//
//       state = AuthStateAuthenticated(session);
//     } on AuthException catch (e) {
//       state = AuthStateError(
//         code: e.code,
//         message: e.message,
//       );
//       rethrow;
//     } catch (e) {
//       state = AuthStateError(
//         code: 'UNKNOWN_ERROR',
//         message: 'An unexpected error occurred',
//       );
//       rethrow;
//     }
//   }
//
//   /// Performs signup operation.
//   ///
//   /// Parameters:
//   /// - [email]: User's email address
//   /// - [password]: User's password
//   /// - [fullName]: User's full name
//   /// - [confirmPassword]: Password confirmation
//   ///
//   /// Updates state to AuthStateAuthenticated on success,
//   /// or AuthStateError on failure.
//   Future<void> signup({
//     required String email,
//     required String password,
//     required String fullName,
//     required String confirmPassword,
//   }) async {
//     try {
//       state = const AuthStateLoading();
//
//       final session = await _authRepository.signup(
//         email: email,
//         password: password,
//         fullName: fullName,
//         confirmPassword: confirmPassword,
//       );
//
//       state = AuthStateAuthenticated(session);
//     } on AuthException catch (e) {
//       state = AuthStateError(
//         code: e.code,
//         message: e.message,
//       );
//       rethrow;
//     } catch (e) {
//       state = AuthStateError(
//         code: 'UNKNOWN_ERROR',
//         message: 'An unexpected error occurred',
//       );
//       rethrow;
//     }
//   }
//
//   /// Performs logout operation.
//   ///
//   /// Clears local session and notifies server.
//   /// Updates state to AuthStateUnauthenticated.
//   Future<void> logout() async {
//     try {
//       state = const AuthStateLoading();
//       await _authRepository.logout();
//       state = const AuthStateUnauthenticated();
//     } catch (e) {
//       // Always transition to unauthenticated even if server logout fails
//       state = const AuthStateUnauthenticated();
//       rethrow;
//     }
//   }
//
//   /// Refreshes the access token.
//   ///
//   /// Called when access token expires but refresh token is still valid.
//   /// Updates cached session with new token.
//   Future<void> refreshAccessToken() async {
//     try {
//       if (state is! AuthStateAuthenticated) {
//         throw AuthException(
//           code: 'NOT_AUTHENTICATED',
//           message: 'No active session to refresh',
//         );
//       }
//
//       final tokenPair = await _authRepository.refreshAccessToken();
//       final currentSession = (state as AuthStateAuthenticated).session;
//
//       state = AuthStateAuthenticated(
//         currentSession.copyWith(tokens: tokenPair),
//       );
//     } on AuthException {
//       state = const AuthStateUnauthenticated();
//       rethrow;
//     } catch (e) {
//       state = const AuthStateUnauthenticated();
//       rethrow;
//     }
//   }
//
//   /// Gets the current authenticated user.
//   ///
//   /// Returns:
//   /// - User object if authenticated
//   ///
//   /// Throws:
//   /// - AuthException if not authenticated
//   AuthSession? getCurrentSession() {
//     if (state is AuthStateAuthenticated) {
//       return (state as AuthStateAuthenticated).session;
//     }
//     return null;
//   }
//
//   /// Clears any error state (typically called after error is displayed to user).
//   void clearError() {
//     if (state is AuthStateError) {
//       state = const AuthStateUnauthenticated();
//     }
//   }
// }
//
// /// ============================================================================
// /// MAIN AUTH PROVIDER
// /// ============================================================================
// /// Provides the current authentication state.
// /// Watch this provider to react to auth state changes.
// ///
// /// Usage:
// /// ```
// /// final authState = ref.watch(authProvider);
// /// final notifier = ref.read(authProvider.notifier);
// /// ```
// ///
// final authProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
//   final authRepository = ref.watch(authRepositoryProvider);
//   return AuthStateNotifier(authRepository);
// });
//
// /// ============================================================================
// /// CONVENIENCE PROVIDERS
// /// ============================================================================
// /// Higher-level providers for common auth operations.
// ///
//
// /// Provides whether user is currently authenticated.
// final isAuthenticatedProvider = Provider<bool>((ref) {
//   final authState = ref.watch(authProvider);
//   return authState is AuthStateAuthenticated;
// });
//
// /// Provides current authenticated user, or null if not authenticated.
// final currentUserProvider = Provider<User?>((ref) {
//   final authState = ref.watch(authProvider);
//   if (authState is AuthStateAuthenticated) {
//     return authState.session.user;
//   }
//   return null;
// });
//
// /// Provides current access token, or null if not authenticated.
// final currentAccessTokenProvider = Provider<String?>((ref) {
//   final authState = ref.watch(authProvider);
//   if (authState is AuthStateAuthenticated) {
//     return authState.session.tokens.accessToken;
//   }
//   return null;
// });
//
// /// Provides whether authentication is currently in progress.
// final isLoadingProvider = Provider<bool>((ref) {
//   final authState = ref.watch(authProvider);
//   return authState is AuthStateLoading;
// });
//
// /// Provides current authentication error, if any.
// final authErrorProvider = Provider<String?>((ref) {
//   final authState = ref.watch(authProvider);
//   if (authState is AuthStateError) {
//     return authState.message;
//   }
//   return null;
// });
//
// /// ============================================================================
// /// ASYNC OPERATION PROVIDERS
// /// ============================================================================
// /// Family providers for operations with parameters.
// /// These are typically used for one-off async operations.
// ///
//
// /// Login operation provider (family for testability).
// final loginProvider = FutureProvider.family<
//     void,
//     ({String email, String password, bool rememberMe})>((ref, params) async {
//   final authNotifier = ref.read(authProvider.notifier);
//   await authNotifier.login(
//     email: params.email,
//     password: params.password,
//     rememberMe: params.rememberMe,
//   );
// });
//
// /// Signup operation provider (family for testability).
// final signupProvider = FutureProvider.family<
//     void,
//     ({
//     String email,
//     String password,
//     String fullName,
//     String confirmPassword,
//     })>((ref, params) async {
//   final authNotifier = ref.read(authProvider.notifier);
//   await authNotifier.signup(
//     email: params.email,
//     password: params.password,
//     fullName: params.fullName,
//     confirmPassword: params.confirmPassword,
//   );
// });
//
// /// Logout operation provider.
// final logoutProvider = FutureProvider<void>((ref) async {
//   final authNotifier = ref.read(authProvider.notifier);
//   await authNotifier.logout();
// });
//
// /// ============================================================================
// /// TOKEN REFRESH PROVIDER
// /// ============================================================================
// /// Handles automatic token refresh when needed.
// /// Can be watched to trigger refresh on token expiry.
// ///
// final tokenRefreshProvider = FutureProvider<void>((ref) async {
//   final authNotifier = ref.read(authProvider.notifier);
//   await authNotifier.refreshAccessToken();
// });
