import 'package:flutter/foundation.dart';

class UserSession extends ChangeNotifier {
  static const devEmail = 'dev@teste.com';
  static const devPassword = '123456';
  static const adminEmail = 'adm@teste.com';
  static const adminPassword = '123456';

  bool _isAdmin = false;

  bool get isAdmin => _isAdmin;

  bool loginWithCredentials({required String email, required String password}) {
    final normalizedEmail = email.trim().toLowerCase();
    final normalizedPassword = password.trim();

    final isDevLogin =
        normalizedEmail == devEmail && normalizedPassword == devPassword;
    final isAdminLogin =
        normalizedEmail == adminEmail && normalizedPassword == adminPassword;

    if (!isDevLogin && !isAdminLogin) {
      return false;
    }

    _isAdmin = isAdminLogin;
    notifyListeners();
    return true;
  }

  void logout() {
    _isAdmin = false;
    notifyListeners();
  }
}

final userSession = UserSession();