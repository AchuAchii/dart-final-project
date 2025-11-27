import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Initialize and check if user is already logged in
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    _currentUser = await _authService.getCurrentUser();

    _isLoading = false;
    notifyListeners();
  }

  /// Register a new user
  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final user = await _authService.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );

    _isLoading = false;

    if (user != null) {
      _currentUser = user;
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = 'Email already registered';
      notifyListeners();
      return false;
    }
  }

  /// Login user
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final user = await _authService.login(
      email: email,
      password: password,
    );

    _isLoading = false;

    if (user != null) {
      _currentUser = user;
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = 'Invalid email or password';
      notifyListeners();
      return false;
    }
  }

  /// Logout user
  Future<void> logout() async {
    await _authService.logout();
    _currentUser = null;
    _errorMessage = null;
    notifyListeners();
  }

  /// Update user profile
  Future<bool> updateProfile({
    required String name,
    required String phone,
  }) async {
    if (_currentUser == null) return false;

    _isLoading = true;
    notifyListeners();

    final updatedUser = _currentUser!.copyWith(
      name: name,
      phone: phone,
    );

    final success = await _authService.updateProfile(updatedUser);

    if (success) {
      _currentUser = updatedUser;
    }

    _isLoading = false;
    notifyListeners();

    return success;
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
