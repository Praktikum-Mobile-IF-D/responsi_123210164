import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';

class UserLoginService {
  Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      final user = User.fromJson(jsonDecode(userData));
      if (user.username == username && user.password == password) {
        return true;
      }
    }
    return false;
  }
}