import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user_model.dart';

/// Controller to manage user information
class UserController extends ChangeNotifier {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  UserController() {
    _loadUserFromCache();
  }

  /// Load user from local storage
  Future<void> _loadUserFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('user_name');
    final userEmail = prefs.getString('user_email');

    if (userName != null && userEmail != null) {
      _currentUser = UserModel(
        id: 'local_user',
        name: userName,
        email: userEmail,
      );
      notifyListeners();
    }
  }

  /// Set user information (call this after login)
  Future<void> setUser(String name, String email) async {
    _currentUser = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
    );

    // Save to local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);

    notifyListeners();
  }

  /// Logout user
  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_name');
    await prefs.remove('user_email');
    notifyListeners();
  }

  /// For demo purposes - set a demo user
  Future<void> setDemoUser() async {
    await setUser('John Doe', 'john.doe@example.com');
  }
}
