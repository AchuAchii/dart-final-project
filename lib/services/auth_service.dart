import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _userKey = 'current_user';
  static const String _usersKey = 'all_users';
  static const Uuid _uuid = Uuid();

  /// Register a new user
  Future<UserModel?> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Check if email already exists
      final allUsersJson = prefs.getString(_usersKey);
      if (allUsersJson != null) {
        final List<dynamic> allUsers = json.decode(allUsersJson);
        final emailExists = allUsers.any((u) => u['email'] == email);
        if (emailExists) {
          return null; // Email already registered
        }
      }

      // Create new user
      final newUser = UserModel(
        id: _uuid.v4(),
        name: name,
        email: email,
        phone: phone,
      );

      // Save to all users list
      final List<Map<String, dynamic>> usersList = allUsersJson != null
          ? (json.decode(allUsersJson) as List).cast<Map<String, dynamic>>()
          : [];
      
      usersList.add({
        ...newUser.toJson(),
        'password': password, // In real app, would hash this
      });

      await prefs.setString(_usersKey, json.encode(usersList));
      await prefs.setString(_userKey, json.encode(newUser.toJson()));

      return newUser;
    } catch (e) {
      print('Error during registration: $e');
      return null;
    }
  }

  /// Login user
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final allUsersJson = prefs.getString(_usersKey);
      
      if (allUsersJson == null) {
        return null; // No users registered
      }

      final List<dynamic> allUsers = json.decode(allUsersJson);
      final userMap = allUsers.firstWhere(
        (u) => u['email'] == email && u['password'] == password,
        orElse: () => null,
      );

      if (userMap == null) {
        return null; // Invalid credentials
      }

      final user = UserModel.fromJson(userMap);
      await prefs.setString(_userKey, json.encode(user.toJson()));
      
      return user;
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  /// Logout user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  /// Get current logged-in user
  Future<UserModel?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      
      if (userJson == null) {
        return null;
      }

      return UserModel.fromJson(json.decode(userJson));
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }

  /// Update user profile
  Future<bool> updateProfile(UserModel updatedUser) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Update current user
      await prefs.setString(_userKey, json.encode(updatedUser.toJson()));
      
      // Update in all users list
      final allUsersJson = prefs.getString(_usersKey);
      if (allUsersJson != null) {
        final List<dynamic> allUsers = json.decode(allUsersJson);
        final index = allUsers.indexWhere((u) => u['id'] == updatedUser.id);
        
        if (index != -1) {
          final password = allUsers[index]['password']; // Preserve password
          allUsers[index] = {
            ...updatedUser.toJson(),
            'password': password,
          };
          await prefs.setString(_usersKey, json.encode(allUsers));
        }
      }
      
      return true;
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }
}
